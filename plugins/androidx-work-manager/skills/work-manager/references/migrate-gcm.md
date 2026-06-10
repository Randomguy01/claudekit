# Migrating from GCMNetworkManager

WorkManager is the preferred library for scheduling background jobs. By also including the WorkManager GCM library, WorkManager can use GCM to schedule tasks on devices running API level 22 or lower.

## Migrate to WorkManager

These steps assume you start with the following GCMNetworkManager code, which defines and schedules a task:

```kotlin
val myTask = OneoffTask.Builder()
    // setService() says what class does the work
    .setService(MyUploadService::class.java)
    // Don't run the task unless device is charging
    .setRequiresCharging(true)
    // Run the task between 5 & 15 minutes from now
    .setExecutionWindow(5 * DateUtil.MINUTE_IN_SECONDS,
            15 * DateUtil.MINUTE_IN_SECONDS)
    // Define a unique tag for the task
    .setTag("test-upload")
    // ...finally, build the task and assign its value to myTask
    .build()
GcmNetworkManager.getInstance(this).schedule(myTask)
```

`MyUploadService` defines the actual upload operation:

```kotlin
class MyUploadService : GcmTaskService() {
    fun onRunTask(params: TaskParams): Int {
        // Do some upload work
        return GcmNetworkManager.RESULT_SUCCESS
    }
}
```

### Include the WorkManager Libraries

Add the WorkManager library to your build dependencies. Also add the WorkManager GCM library, which lets WorkManager use GCM for scheduling on devices that don't support JobScheduler (API level 22 or lower). See [Installing WorkManager](install.md).

### Modify Your Manifest

When you implemented GCMNetworkManager, you added a `GcmTaskService` to your manifest to delegate incoming tasks to the task handler. WorkManager manages task delegation to your Worker, so remove your `GcmTaskService` from the manifest.

> [!NOTE]
> If you added logic to your `GcmTaskService` to do work before dispatching the task to the handler, refactor that logic into the [`Worker`](../api/androidx.work/worker.md) class you define next.

### Define the Worker

Rewrite your `OneoffTask` or `RecurringTask` as a `Worker`, as documented in [Defining WorkRequests](define-work-requests.md). The WorkManager equivalent of `myTask`:

```kotlin
class UploadWorker(context: Context, params: WorkerParameters)
                        : Worker(context, params) {
    override fun doWork(): Result {
        // Do the upload operation ...
        myUploadOperation()

        // Indicate whether the task finished successfully with the Result
        return Result.success()
    }
}
```

> [!NOTE]
> In GCMNetworkManager, the task defines both *what* work to do and *when* it should run. WorkManager splits these across two classes: the [`Worker`](../api/androidx.work/worker.md) defines the task, and the [`WorkRequest`](../api/androidx.work/work-request.md) specifies the constraints on when it runs.

Differences between the GCM task and the `Worker`:

- GCM uses a `TaskParams` object to pass parameters. WorkManager uses input data specified on the `WorkRequest` (see [Assigning input data](define-work-requests.md#assigning-input-data)). Both pass key/value pairs.
- `GcmTaskService` signals success or failure by returning flags like `GcmNetworkManager.RESULT_SUCCESS`. A WorkManager `Worker` signals results with a [`ListenableWorker.Result`](../api/androidx.work/listenable-worker-result.md) method such as [`Result.success()`](../api/androidx.work/listenable-worker-result.md), returning that method's value.
- Set constraints and tags when you create the `WorkRequest`, not when you define the `Worker`.

### Schedule the Work Request

Defining a `Worker` specifies *what* to do. To specify *when*, define the [`WorkRequest`](../api/androidx.work/work-request.md):

1. Create a [`OneTimeWorkRequest`](../api/androidx.work/one-time-work-request.md) or [`PeriodicWorkRequest`](../api/androidx.work/periodic-work-request.md), setting any constraints and tags.
2. Pass the request to [`WorkManager.enqueue()`](../api/androidx.work/work-manager.md) to queue it for execution.

The earlier `OneoffTask` did not carry its execution constraints and tag into the `Worker`; set those on the `WorkRequest`. GCMNetworkManager requires a network connection by default, but WorkManager does not unless you add the constraint:

```kotlin
val uploadConstraints = Constraints.Builder()
    .setRequiredNetworkType(NetworkType.CONNECTED)
    .setRequiresCharging(true).build()

val uploadTask = OneTimeWorkRequestBuilder<UploadWorker>()
    .setConstraints(uploadConstraints)
    .build()
WorkManager.getInstance().enqueue(uploadTask)
```

> [!NOTE]
> With GCMNetworkManager, every task needs a unique tag. The WorkManager analog is the `WorkRequest` ID, set automatically when the request is created; get it with [`WorkRequest.getId()`](../api/androidx.work/work-request.md). WorkManager tags need not be unique — several tasks can be enqueued at once using the same tag.

> [!NOTE]
> GCMNetworkManager requires an execution window; WorkManager does not. WorkManager runs the job as soon as possible after its constraints are met.

## API Mappings

### Constraint Mappings

Set GCMNetworkManager constraints by calling the task Builder's methods (for example, `Task.Builder.setRequiredNetwork()`). In WorkManager, create a [`Constraints.Builder`](../api/androidx.work/constraints-builder.md), call its methods (for example, [`Constraints.Builder.setRequiredNetworkType()`](../api/androidx.work/constraints-builder.md)), and attach the resulting `Constraints` to the work request. See [Work constraints](define-work-requests.md#work-constraints).

> [!NOTE]
> GCMNetworkManager lets you specify an execution window; WorkManager has no equivalent. To run work at a precise time, use another option such as [`AlarmManager`](https://developer.android.com/reference/android/app/AlarmManager).

| GCMNetworkManager constraint | WorkManager equivalent | Notes |
|---|---|---|
| `setPersisted()` | *(not required)* | All WorkManager jobs are persisted across device reboots. |
| `setRequiredNetwork()` | `setRequiredNetworkType()` | GCMNetworkManager requires network access by default; WorkManager does not. If your job needs the network, use `setRequiredNetworkType(CONNECTED)` or a more specific type. |
| `setRequiresCharging()` | `setRequiresCharging()` | |

### Other Mappings

#### Tags

All GCMNetworkManager tasks must have a tag string, set with the Builder's `setTag()` method. WorkManager jobs are identified by an auto-generated ID, retrieved with [`WorkRequest.getId()`](../api/androidx.work/work-request.md). Work requests can *optionally* have one or more tags; set one with [`WorkRequest.Builder.addTag()`](../api/androidx.work/work-request-builder.md) before building the request.

In GCMNetworkManager, `setUpdateCurrent()` specifies whether a task should replace an existing task with the same tag. The WorkManager equivalent is to enqueue with [`enqueueUniqueWork()`](../api/androidx.work/work-manager.md) or [`enqueueUniquePeriodicWork()`](../api/androidx.work/work-manager.md): give the job a unique name and specify how WorkManager handles an existing pending job with that name. See [Unique work](managing-work.md#unique-work).

#### Task Parameters

Pass parameters to a GCMNetworkManager job with `Task.Builder.setExtras()` and a `Bundle`. WorkManager passes a [`Data`](../api/androidx.work/data.md) object of key/value pairs. See [Assigning input data](define-work-requests.md#assigning-input-data).
