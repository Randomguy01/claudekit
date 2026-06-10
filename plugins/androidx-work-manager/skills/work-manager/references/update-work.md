# Updating Work

**Requires WorkManager 2.8.0+**

Update a [`WorkRequest`](../api/androidx.work/work-request.md) after enqueuing it with the [`updateWork()`](../api/androidx.work/work-manager.md) API. This is often necessary in larger apps that frequently change constraints or update their workers on the fly. `updateWork()` changes certain aspects of a `WorkRequest` without manually canceling and enqueuing a new one.

## Avoid Canceling Work

Generally avoid canceling an existing `WorkRequest` and enqueuing a new one — it can cause the app to repeat tasks and requires extra code. Canceling a `WorkRequest` can cause difficulties such as:

- **Back-end request**: If you cancel a [`Worker`](../api/androidx.work/worker.md) while it's computing a payload to send to the server, the new `Worker` must start over and recompute the potentially expensive payload.
- **Scheduling**: If you cancel a [`PeriodicWorkRequest`](../api/androidx.work/periodic-work-request.md) and want the new one to run on the same schedule, you must calculate a time offset so the new execution time aligns with the previous work request.

### When to Cancel Work

Directly cancel a `WorkRequest` rather than calling `updateWork()` when you want to change the fundamental nature of the enqueued work.

> [!CAUTION]
> `updateWork()` can't change the type of `Worker` in a `WorkRequest`. For example, if you've enqueued a `OneTimeWorkRequest` and want it to run periodically, you must cancel the request and schedule a new `PeriodicWorkRequest`.

### When to Update Work

Consider a photo app that does a daily backup of the user's photos with a `PeriodicWorkRequest` constrained to require the device to be charging and connected to Wi-Fi. If the user only charges their device for 20 minutes a day with a fast charger, the app may want to update the `WorkRequest` to relax the charging constraint so it can still upload the photos. Use `updateWork()` to update the work request's constraints.

## How to Update Work

To update enqueued work, follow these steps:

1. **Get the existing ID for the enqueued work**: Retrieve the ID of the `WorkRequest` you want to update with any of the [`getWorkInfo`](../api/androidx.work/work-manager.md) APIs, or by manually persisting the [`WorkRequest.id`](../api/androidx.work/work-request.md) before enqueuing it.
2. **Create a new WorkRequest**: Use `WorkRequest.Builder.setId()` to set its ID to match that of the existing `WorkRequest`.
3. **Set constraints**: Use `WorkRequest.Builder.setConstraints()` to pass WorkManager the new constraints.
4. **Call updateWork()**: Pass the new `WorkRequest` to `updateWork()`.

### Update Work Example

This snippet uses `updateWork()` to change the battery constraints of a `WorkRequest` used to upload photos:

```kotlin
suspend fun updatePhotoUploadWork() {
    // Get instance of WorkManager.
    val workManager = WorkManager.getInstance(context)

    // Retrieve the work request ID. In this example, the work being updated is unique
    // work so we can retrieve the ID using the unique work name.
    val photoUploadWorkInfoList = workManager.getWorkInfosForUniqueWork(
        PHOTO_UPLOAD_WORK_NAME
    ).await()

    val existingWorkRequestId = photoUploadWorkInfoList.firstOrNull()?.id ?: return

    // Update the constraints of the WorkRequest to not require a charging device.
    val newConstraints = Constraints.Builder()
        // Add other constraints as required here.
        .setRequiresCharging(false)
        .build()

    // Create new WorkRequest from existing Worker, new constraints, and the id of the old WorkRequest.
    val updatedWorkRequest: WorkRequest =
        OneTimeWorkRequestBuilder<MyWorker>()
            .setConstraints(newConstraints)
            .setId(existingWorkRequestId)
            .build()

    // Pass the new WorkRequest to updateWork().
    workManager.updateWork(updatedWorkRequest)
}
```

### Handle the Result

`updateWork()` returns a `ListenableFuture<UpdateResult>`. The [`UpdateResult`](../api/androidx.work/work-manager-update-result.md) can have one of several values that indicate whether WorkManager was able to apply your changes, and when it was able to apply them.

## Track Work with Generations

Each time you update a `WorkRequest`, its *generation* increments by one. This lets you track exactly which `WorkRequest` is currently enqueued, giving you more control when observing, tracing, and testing work requests.

To get the generation of a `WorkRequest`, follow these steps:

1. **WorkInfo**: Call `WorkManager.getWorkInfoById()` (one of several methods that return a [`WorkInfo`](../api/androidx.work/work-info.md)) to retrieve the instance corresponding to your `WorkRequest`.
2. **getGeneration**: Call [`getGeneration()`](../api/androidx.work/work-info.md) on the `WorkInfo`. The returned `Int` is the generation of the `WorkRequest`. There is no generation field or property — only the `WorkInfo.getGeneration()` method.

### Track Generation Example

```kotlin
// Get instance of WorkManager.
val workManager = WorkManager.getInstance(context)

// Retrieve WorkInfo instance.
val workInfo = workManager.getWorkInfoById(oldWorkRequestId)

// Call getGeneration to retrieve the generation.
val generation = workInfo.getGeneration()
```

> [!NOTE]
> The `UpdateResult` that `updateWork()` returns does not include the generation of the `WorkRequest`.

## Policies for Updating Work

Previously, the recommended way to update periodic work was to enqueue a `PeriodicWorkRequest` with the policy `ExistingPeriodicWorkPolicy.REPLACE`. If there was a pending `PeriodicWorkRequest` with the same unique `id`, the new request would cancel and delete it. This policy is now *deprecated* in favor of [`ExistingPeriodicWorkPolicy.UPDATE`](../api/androidx.work/existing-periodic-work-policy.md).

For example, when using [`enqueueUniquePeriodicWork`](../api/androidx.work/work-manager.md) with a `PeriodicWorkRequest`, initialize the new `PeriodicWorkRequest` with the `ExistingPeriodicWorkPolicy.UPDATE` policy. If there is a pending `PeriodicWorkRequest` with the same unique name, WorkManager updates it to the new specification. With this workflow, `updateWork()` isn't necessary.

> [!NOTE]
> A similar update policy doesn't exist for `OneTimeWorkRequest`, because you can use [`enqueueUniqueWork`](../api/androidx.work/work-manager.md) with the [`APPEND` or `APPEND_OR_REPLACE`](../api/androidx.work/existing-work-policy.md) policies. Doing so creates a chain of workers with the same name, so WorkManager can't decide which workers in the chain an `UPDATE` policy should apply to.
