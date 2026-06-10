# Migrating from Firebase JobDispatcher

WorkManager is the recommended replacement for Firebase JobDispatcher. This guide maps each Firebase JobDispatcher construct to its WorkManager equivalent.

## Gradle Setup

Add the WorkManager dependencies to your project — see [Installing WorkManager](install.md).

## From JobService to Workers

`FirebaseJobDispatcher` uses a subclass of `JobService` as the entry point for defining work. You might use `JobService` directly or use `SimpleJobService`.

A `JobService` looks like this:

```kotlin
import com.firebase.jobdispatcher.JobParameters
import com.firebase.jobdispatcher.JobService

class MyJobService : JobService() {
    override fun onStartJob(job: JobParameters): Boolean {
        // Do some work here
        return false // Answers the question: "Is there still work going on?"
    }
    override fun onStopJob(job: JobParameters): Boolean {
        return false // Answers the question: "Should this job be retried?"
    }
}
```

With `SimpleJobService` you override `onRunJob()`, which returns a `@JobResult int`.

The key difference: with `JobService` directly, `onStartJob()` is called on the main thread and the app must offload work to a background thread. With `SimpleJobService`, the service runs your work on a background thread.

WorkManager's fundamental unit of work is a [`ListenableWorker`](../api/androidx.work/listenable-worker.md). Other subtypes include [`Worker`](../api/androidx.work/worker.md), [`RxWorker`](../api/androidx.work/rx-worker.md), and [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) (for Kotlin coroutines).

### JobService Maps to a ListenableWorker

If you use `JobService` directly, it maps to a `ListenableWorker`. If you use `SimpleJobService`, use `Worker` instead.

Converting `MyJobService` to a `ListenableWorker`:

```kotlin
import android.content.Context
import androidx.work.ListenableWorker
import androidx.work.ListenableWorker.Result
import androidx.work.WorkerParameters
import com.google.common.util.concurrent.ListenableFuture

class MyWorker(appContext: Context, params: WorkerParameters) :
    ListenableWorker(appContext, params) {

    override fun startWork(): ListenableFuture<ListenableWorker.Result> {
        // Do your work here.
        TODO("Return a ListenableFuture<Result>")
    }

    override fun onStopped() {
        // Cleanup because you are being stopped.
    }
}
```

Like `JobService.onStartJob()`, `startWork()` is called on the main thread. It returns a `ListenableFuture` that signals work completion *asynchronously*, so choose your own threading strategy. The `ListenableFuture` eventually returns a [`ListenableWorker.Result`](../api/androidx.work/listenable-worker-result.md), one of `Result.success()`, `Result.success(Data)`, `Result.retry()`, `Result.failure()`, or `Result.failure(Data)`.

`onStopped()` signals that the worker must stop — because its constraints are no longer met (for example, the network is gone), because a `WorkManager.cancel...()` method was called, or because the OS shut the work down.

### SimpleJobService Maps to a Worker

```kotlin
import android.content.Context
import androidx.work.ListenableWorker.Result
import androidx.work.Worker
import androidx.work.WorkerParameters

class MyWorker(context: Context, params: WorkerParameters) : Worker(context, params) {
    override fun doWork(): Result {
        TODO("Return a Result")
    }

    override fun onStopped() {
        super.onStopped()
        TODO("Cleanup, because you are being stopped")
    }
}
```

`doWork()` returns a `ListenableWorker.Result` to signal completion *synchronously*, similar to how `SimpleJobService` runs jobs on a background thread.

## JobBuilder Maps to WorkRequest

Firebase JobDispatcher uses `Job.Builder` to represent job metadata. WorkManager uses [`WorkRequest`](../api/androidx.work/work-request.md), which comes in two types: [`OneTimeWorkRequest`](../api/androidx.work/one-time-work-request.md) and [`PeriodicWorkRequest`](../api/androidx.work/periodic-work-request.md). If you use `Job.Builder.setRecurring(true)`, create a `PeriodicWorkRequest`; otherwise use a `OneTimeWorkRequest`.

Scheduling a complex `Job` with Firebase JobDispatcher:

```kotlin
val input: Bundle = Bundle().apply {
    putString("some_key", "some_value")
}

val job = dispatcher.newJobBuilder()
    // the JobService that will be called
    .setService(MyJobService::class.java)
    // uniquely identifies the job
    .setTag("my-unique-tag")
    // one-off job
    .setRecurring(false)
    // don't persist past a device reboot
    .setLifetime(Lifetime.UNTIL_NEXT_BOOT)
    // start between 0 and 60 seconds from now
    .setTrigger(Trigger.executionWindow(0, 60))
    // don't overwrite an existing job with the same tag
    .setReplaceCurrent(false)
    // retry with exponential backoff
    .setRetryStrategy(RetryStrategy.DEFAULT_EXPONENTIAL)
    .setConstraints(
        // only run on an unmetered network
        Constraint.ON_UNMETERED_NETWORK,
        // only run when the device is charging
        Constraint.DEVICE_CHARGING
    )
    .setExtras(input)
    .build()

dispatcher.mustSchedule(job)
```

To achieve the same with WorkManager:

- Build input data for the `Worker`.
- Build a `WorkRequest` with that input data and the constraints.
- Enqueue the `WorkRequest`.

### Setting Up Inputs for the Worker

Firebase JobDispatcher uses a `Bundle` to send input to the `JobService`. WorkManager uses [`Data`](../api/androidx.work/data.md) instead:

```kotlin
import androidx.work.workDataOf

val data = workDataOf("some_key" to "some_val")
```

### Setting Up Constraints for the Worker

Firebase JobDispatcher uses `Job.Builder.setConstraints(...)`. WorkManager uses [`Constraints`](../api/androidx.work/constraints.md):

```kotlin
import androidx.work.*

val constraints: Constraints = Constraints.Builder().apply {
    setRequiredNetworkType(NetworkType.CONNECTED)
    setRequiresCharging(true)
}.build()
```

### Creating the WorkRequest

Use [`OneTimeWorkRequest.Builder`](../api/androidx.work/one-time-work-request-builder.md) and [`PeriodicWorkRequest.Builder`](../api/androidx.work/periodic-work-request-builder.md). A `OneTimeWorkRequest` similar to the `Job` above:

```kotlin
import androidx.work.*
import java.util.concurrent.TimeUnit

val constraints: Constraints = TODO("Define constraints as above")
val request: OneTimeWorkRequest =
    OneTimeWorkRequestBuilder<MyWorker>()
        // Sets the input data for the ListenableWorker
        .setInputData(input)
        // Delay the start of work by 60 seconds
        .setInitialDelay(60, TimeUnit.SECONDS)
        // Set a backoff criteria to use when retrying
        .setBackoffCriteria(BackoffPolicy.EXPONENTIAL, 30000, TimeUnit.MILLISECONDS)
        // Set additional constraints
        .setConstraints(constraints)
        .build()
```

WorkManager's jobs are always persisted across device reboot automatically.

A `PeriodicWorkRequest`:

```kotlin
val constraints: Constraints = TODO("Define constraints as above")
val request: PeriodicWorkRequest =
    PeriodicWorkRequestBuilder<MyWorker>(15, TimeUnit.MINUTES)
        // Sets the input data for the ListenableWorker
        .setInputData(input)
        // Other setters
        .build()
```

## Scheduling Work

Every Firebase JobDispatcher `Job` had a `tag` that *uniquely identified* it, and `setReplaceCurrent` told the scheduler whether this instance should replace an existing copy:

```kotlin
val job = dispatcher.newJobBuilder()
    // the JobService that will be called
    .setService(MyJobService::class.java)
    // uniquely identifies the job
    .setTag("my-unique-tag")
    // don't overwrite an existing job with the same tag
    .setReplaceCurrent(false)
    // other setters...
    .build()

dispatcher.mustSchedule(job)
```

With WorkManager, achieve the same with `enqueueUniqueWork()` and `enqueueUniquePeriodicWork()` (for a `OneTimeWorkRequest` and a `PeriodicWorkRequest` respectively):

```kotlin
import androidx.work.*

val request: OneTimeWorkRequest = TODO("A WorkRequest")
WorkManager.getInstance(myContext)
    .enqueueUniqueWork("my-unique-name", ExistingWorkPolicy.KEEP, request)
```

> [!NOTE]
> `Job` tags in Firebase JobDispatcher map to the `name` of the WorkManager `WorkRequest`. See [Unique work](managing-work.md#unique-work).

## Cancelling Work

Firebase JobDispatcher:

```kotlin
dispatcher.cancel("my-unique-tag")
```

WorkManager:

```kotlin
import androidx.work.WorkManager

WorkManager.getInstance(myContext).cancelUniqueWork("my-unique-name")
```

## Initializing WorkManager

WorkManager typically initializes itself using a `ContentProvider`. For more control over how it organizes and schedules work, [customize the WorkManager configuration and initialization](custom-configuration.md).
