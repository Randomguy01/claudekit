# Defining WorkRequests

## Creating a WorkRequest

Work is defined in WorkManager using a [`WorkRequest`](../api/androidx.work/work-request.md). To schedule any work, first create a `WorkRequest` object and then enqueue it.

```kotlin
val myWorkRequest = ...
WorkManager.getInstance(myContext).enqueue(myWorkRequest)
```

The `WorkRequest` object contains all of the information WorkManager needs to schedule and run your work: constraints that must be met for the work to run, scheduling information such as delays or repeating intervals, retry configuration, and any input data the work relies on.

`WorkRequest` is an abstract base class. Two implementations derive from it: [`OneTimeWorkRequest`](../api/androidx.work/one-time-work-request.md) for non-repeating work, and [`PeriodicWorkRequest`](../api/androidx.work/periodic-work-request.md) for work that repeats on an interval.

## Scheduling One-Time Work

For basic work that requires no additional configuration, use the static method `from`:

```kotlin
val myWorkRequest = OneTimeWorkRequest.from(MyWork::class.java)
```

For more complex work, use a builder:

```kotlin
val uploadWorkRequest: WorkRequest =
    OneTimeWorkRequestBuilder<MyWork>()
        // Additional configuration
        .build()
```

## Scheduling Expedited Work

**Requires WorkManager 2.7+**

Expedited work lets WorkManager execute important work while giving the system better control over access to resources. Expedited work has the following characteristics:

- **Importance**: Suits tasks that are important to the user or are user-initiated.
- **Speed**: Best fits short tasks that start immediately and complete within a few minutes.
- **Quotas**: A system-level quota that limits foreground execution time determines whether an expedited job can start.
- **Power management**: [Power management restrictions](https://developer.android.com/topic/performance/power/power-details) such as Battery Saver and Doze are less likely to affect expedited work.
- **Latency**: The system executes expedited work immediately, provided its current workload allows. Expedited work is therefore latency sensitive and can't be scheduled for later execution.

Use expedited work for tasks that are important to the user, execute quickly, must begin immediately, and should continue even if the user closes the app — for example, sending a chat message with an attachment, or handling a payment or subscription flow.

### Quotas

The system must allocate execution time to an expedited job before it can run, and execution time is not unlimited. Each app receives a quota of execution time; once an app reaches its allocated quota, it can no longer execute expedited work until the quota refreshes. This lets Android balance resources between applications.

The amount of execution time available to an app is based on the [standby bucket](https://developer.android.com/topic/performance/appstandby) and process importance.

> [!NOTE]
> While your app is in the foreground, quotas won't limit the execution of expedited work. An execution time quota applies only when your app is in the background, or when it moves to the background. Expedite work that you want to continue in the background; continue to use `setForeground()` while your app is in the foreground. See [Power management resource limits](https://developer.android.com/topic/performance/power/power-details) for more details.

## Executing Expedited Work

Call `setExpedited()` to declare that a `WorkRequest` should run as quickly as possible using an expedited job:

```kotlin
val request = OneTimeWorkRequestBuilder<SyncWorker>()
    .setExpedited(OutOfQuotaPolicy.RUN_AS_NON_EXPEDITED_WORK_REQUEST)
    .build()

WorkManager.getInstance(context)
    .enqueue(request)
```

Calling `setExpedited()` makes the request expedited work. If the quota allows, it begins running immediately in the background. If the quota has been used, the [`OutOfQuotaPolicy`](../api/androidx.work/out-of-quota-policy.md) parameter indicates the request should run as normal, non-expedited work.

### Backwards Compatibility and Foreground Services

To maintain backwards compatibility for expedited jobs, WorkManager might run a foreground service on platform versions older than Android 12. Foreground services can display a notification to the user.

The `getForegroundInfoAsync()` and `getForegroundInfo()` methods in your Worker let WorkManager display a notification when you call `setExpedited()` prior to Android 12. Any [`ListenableWorker`](../api/androidx.work/listenable-worker.md) must implement `getForegroundInfo()` to request that the task run as an expedited job.

> [!CAUTION]
> Failing to implement the corresponding `getForegroundInfo()` method can lead to runtime crashes when calling `setExpedited()` on older platform versions.

When targeting Android 12 or higher, foreground services remain available through the corresponding `setForeground()` method.

> [!CAUTION]
> `setForeground()` can throw runtime exceptions on Android 12, and might throw an exception if the [launch was restricted](https://developer.android.com/develop/background-work/services/fgs/restrictions-bg-start).

### Worker

Workers don't know whether the work they're doing is expedited. But a worker can display a notification on some versions of Android when a `WorkRequest` has been expedited. To enable this, implement `getForegroundInfoAsync()` so WorkManager can display a notification to start a `ForegroundService` where necessary.

### CoroutineWorker

With a [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md), implement `getForegroundInfo()` and pass it to `setForeground()` within `doWork()`. This creates the notification on versions of Android prior to 12.

```kotlin
class ExpeditedWorker(appContext: Context, workerParams: WorkerParameters) :
    CoroutineWorker(appContext, workerParams) {

    override suspend fun getForegroundInfo(): ForegroundInfo {
        return ForegroundInfo(
            NOTIFICATION_ID, createNotification()
        )
    }

    override suspend fun doWork(): Result {
        TODO()
    }

    private fun createNotification(): Notification {
        TODO()
    }
}
```

> [!NOTE]
> Wrap `setForeground()` in a `try/catch` block to catch a potential `IllegalStateException`, which can occur when your app isn't able to run in the foreground at that point. On Android 12 and higher, use the more detailed `ForegroundServiceStartNotAllowedException`.

### Quota Policies

Control what happens to expedited work when your app reaches its execution quota by passing an [`OutOfQuotaPolicy`](../api/androidx.work/out-of-quota-policy.md) to `setExpedited()`:

- `OutOfQuotaPolicy.RUN_AS_NON_EXPEDITED_WORK_REQUEST` runs the job as an ordinary work request.
- `OutOfQuotaPolicy.DROP_WORK_REQUEST` cancels the request if there is not sufficient quota.

### Deferred Expedited Work

The system tries to execute an expedited job as soon as possible after it's invoked. However, as with other types of jobs, the system might defer the start of new expedited work, such as in these cases:

- **Load**: The system load is too high, which can occur when too many jobs are already running or the system is low on memory.
- **Quota**: The expedited job quota limit has been exceeded. Expedited work uses a quota system based on App Standby Buckets that limits maximum execution time within a rolling time window. These quotas are more restrictive than those used for other types of background jobs.

## Scheduling Periodic Work

Some work must run periodically — for example, backing up data, downloading fresh content, or uploading logs to a server. Use [`PeriodicWorkRequest`](../api/androidx.work/periodic-work-request.md) to create a request that executes periodically:

```kotlin
val saveRequest =
    PeriodicWorkRequestBuilder<SaveImageToFileWorker>(1, TimeUnit.HOURS)
        // Additional configuration
        .build()
```

Here the work is scheduled with a one-hour interval. The interval period is the minimum time between repetitions; the exact time the worker executes depends on the constraints in your `WorkRequest` and on system optimizations.

> [!NOTE]
> The minimum repeat interval is 15 minutes, the same as the `JobScheduler` API.

### Flexible Run Intervals

If your work is sensitive to run timing, configure your [`PeriodicWorkRequest`](../api/androidx.work/periodic-work-request.md) to run within a **flex period** inside each interval period. Pass a `flexInterval` along with the `repeatInterval` when creating the request. The flex period begins at `repeatInterval - flexInterval` and runs to the end of the interval.

This example runs during the last 15 minutes of every one-hour period:

```kotlin
val myUploadWork = PeriodicWorkRequestBuilder<SaveImageToFileWorker>(
    1, TimeUnit.HOURS, // repeatInterval (the period cycle)
    15, TimeUnit.MINUTES) // flexInterval
    .build()
```

The repeat interval must be greater than or equal to `PeriodicWorkRequest.MIN_PERIODIC_INTERVAL_MILLIS`, and the flex interval must be greater than or equal to `PeriodicWorkRequest.MIN_PERIODIC_FLEX_MILLIS`.

### Effect of Constraints on Periodic Work

Apply [constraints](#work-constraints) to periodic work. For example, add a constraint so the work only runs while the device is charging. Even if the repeat interval passes, the `PeriodicWorkRequest` won't run until the condition is met — a run can be delayed, or skipped entirely if the conditions aren't met within the run interval.

## Work Constraints

[`Constraints`](../api/androidx.work/constraints.md) ensure that work is deferred until optimal conditions are met. The following constraints are available:

| Constraint | Description |
|---|---|
| **NetworkType** | Constrains the [type of network](../api/androidx.work/network-type.md) required for your work to run — for example, `UNMETERED` for Wi-Fi. |
| **BatteryNotLow** | When `true`, work won't run if the device is in low battery mode. |
| **RequiresCharging** | When `true`, work runs only when the device is charging. |
| **DeviceIdle** | When `true`, requires the device to be idle before the work runs. Useful for batched operations that could otherwise hurt the performance of other actively running apps. |
| **StorageNotLow** | When `true`, work won't run if the device's storage space is too low. |

To create a set of constraints and associate it with some work, build a `Constraints` instance with [`Constraints.Builder()`](../api/androidx.work/constraints-builder.md) and assign it to your `WorkRequest.Builder()`. This work request only runs when the device is both charging and on Wi-Fi:

```kotlin
val constraints = Constraints.Builder()
    .setRequiredNetworkType(NetworkType.UNMETERED)
    .setRequiresCharging(true)
    .build()

val myWorkRequest: WorkRequest =
    OneTimeWorkRequestBuilder<MyWork>()
        .setConstraints(constraints)
        .build()
```

When multiple constraints are specified, your work runs only when all of them are met. If a constraint becomes unmet while your work is running, WorkManager stops your worker. The work is retried once all the constraints are met again.

## Delayed Work

If your work has no constraints, or all constraints are met when the work is enqueued, the system may run it immediately. To prevent that, specify a minimum initial delay before the work starts. This work runs at least 10 minutes after it's enqueued:

```kotlin
val myWorkRequest = OneTimeWorkRequestBuilder<MyWork>()
    .setInitialDelay(10, TimeUnit.MINUTES)
    .build()
```

An initial delay can also be set on a `PeriodicWorkRequest`; in that case, only the first run is delayed.

> [!NOTE]
> The exact time the worker executes also depends on the constraints in your work request and on system optimizations. WorkManager is designed to give the best possible behavior under these restrictions.

## Retry and Backoff Policy

To have WorkManager retry your work, return [`Result.retry()`](../api/androidx.work/listenable-worker-result.md) from your worker. The work is then rescheduled according to a *backoff delay* and *backoff policy*.

- *Backoff delay* specifies the minimum time to wait before retrying after the first attempt. This value can be no less than 10 seconds (`MIN_BACKOFF_MILLIS`).
- *Backoff policy* defines how the backoff delay increases over time for subsequent retries. WorkManager supports two policies, [`LINEAR` and `EXPONENTIAL`](../api/androidx.work/backoff-policy.md).

Every work request has a backoff policy and backoff delay. The default is `EXPONENTIAL` with a delay of 30 seconds, but you can override it:

```kotlin
val myWorkRequest = OneTimeWorkRequestBuilder<MyWork>()
    .setBackoffCriteria(
        BackoffPolicy.LINEAR,
        WorkRequest.MIN_BACKOFF_MILLIS,
        TimeUnit.MILLISECONDS)
    .build()
```

Here the backoff delay is set to the minimum allowed value, 10 seconds. Because the policy is `LINEAR`, the retry interval increases by roughly 10 seconds with each attempt: a run that finishes with `Result.retry()` is retried after 10 seconds, then 20, 30, 40, and so on. With `EXPONENTIAL`, the sequence would be closer to 20, 40, and 80.

> [!NOTE]
> Backoff delays are inexact and can vary by several seconds between retries, but are never less than the initial backoff delay specified in your configuration.

## Tagging Work

Every work request has a [unique identifier](../api/androidx.work/work-request.md), which you can use to identify that work later to [cancel](managing-work.md#cancelling-and-stopping-work) it or [observe its progress](managing-work.md#observing-your-work).

Tag logically related work items to operate on them as a group. For example, [`WorkManager.cancelAllWorkByTag(String)`](../api/androidx.work/work-manager.md) cancels all work requests with a particular tag, and [`WorkManager.getWorkInfosByTag(String)`](../api/androidx.work/work-manager.md) returns a list of [`WorkInfo`](../api/androidx.work/work-info.md) objects that report the current work state.

Add a `"cleanup"` tag to your work:

```kotlin
val myWorkRequest = OneTimeWorkRequestBuilder<MyWork>()
    .addTag("cleanup")
    .build()
```

Multiple tags can be added to a single work request; internally they're stored as a set of strings. Get the tags associated with a `WorkRequest` using [`WorkInfo.getTags()`](../api/androidx.work/work-info.md), or retrieve them from inside your `Worker` class using [`ListenableWorker.getTags()`](../api/androidx.work/listenable-worker.md).

## Assigning Input Data

Your work may require input data — for example, work that uploads an image needs the URI of the image to upload.

Input values are stored as key-value pairs in a [`Data`](../api/androidx.work/data.md) object and set on the work request. WorkManager delivers the input `Data` to your work when it executes, and the [`Worker`](../api/androidx.work/worker.md) accesses the arguments by calling `getInputData()`. This `Worker` requires input data, and the request supplies it:

```kotlin
// Define the Worker requiring input
class UploadWork(appContext: Context, workerParams: WorkerParameters)
    : Worker(appContext, workerParams) {

    override fun doWork(): Result {
        val imageUriInput =
            inputData.getString("IMAGE_URI") ?: return Result.failure()

        uploadFile(imageUriInput)
        return Result.success()
    }
    ...
}

// Create a WorkRequest for your Worker and send it input
val myUploadWork = OneTimeWorkRequestBuilder<UploadWork>()
    .setInputData(workDataOf(
        "IMAGE_URI" to "http://..."
    ))
    .build()
```

Use the `Data` class to output a return value as well.

> [!NOTE]
> Next, see [Work states](work-states.md) to learn about the work lifecycle, and [Observing your work](managing-work.md#observing-your-work) to monitor the progress of your work.
