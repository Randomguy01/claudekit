# API Reference

> Last updated 2026-06-10

# WorkManager

> Added in 1.0.0

```
abstract class WorkManager
```

The recommended library for persistent work. Scheduled work is guaranteed to execute after its [`Constraints`](constraints.md) are met. WorkManager supports observing work status, cancellation, and creating complex chains of work.

Under the hood it uses `JobScheduler` on API 23+, and a custom `AlarmManager` + `BroadcastReceiver` implementation on API 14–22. All work runs in a [`ListenableWorker`](listenable-worker.md) (or [`Worker`](worker.md) / [`CoroutineWorker`](coroutine-worker.md) / [`RxWorker`](rx-worker.md)), with a ten-minute maximum execution time.

> [!CAUTION]
> Avoid renaming or removing [`ListenableWorker`](listenable-worker.md) subclasses — WorkManager stores their class names in its database.

## Nested Types

| Type | Description |
|------|-------------|
| [`WorkManager.UpdateResult`](work-manager-update-result.md) | Results for the [`updateWork`](#updatework) method. |

## Public Companion Functions

### getInstance

> Added in 2.1.0
```
fun getInstance(context: Context): WorkManager
```

Retrieves the singleton instance of `WorkManager`.

### initialize

> Added in 1.0.0
```
fun initialize(context: Context, configuration: Configuration): Unit
```

Initializes the singleton with a custom [`Configuration`](configuration.md). Use this for on-demand initialization (see [`Configuration.Provider`](configuration-provider.md)); do not call it if the default `WorkManagerInitializer` is enabled.

### isInitialized

> Added in 2.8.0
```
fun isInitialized(): Boolean
```

Returns `true` if WorkManager has been initialized.

## Public Functions

### enqueue

> Added in 1.0.0
```
abstract fun enqueue(request: WorkRequest): Operation
fun enqueue(requests: List<WorkRequest>): Operation
```

Enqueues one or more [`WorkRequest`](work-request.md)s for execution. Returns an [`Operation`](operation.md).

### enqueueUniqueWork

> Added in 1.0.0
```
fun enqueueUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    request: OneTimeWorkRequest
): Operation

abstract fun enqueueUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    work: List<OneTimeWorkRequest>
): Operation
```

Enqueues uniquely-named [`OneTimeWorkRequest`](one-time-work-request.md)(s), resolving collisions per the [`ExistingWorkPolicy`](existing-work-policy.md).

### enqueueUniquePeriodicWork

> Added in 1.0.0
```
abstract fun enqueueUniquePeriodicWork(
    uniqueWorkName: String,
    existingPeriodicWorkPolicy: ExistingPeriodicWorkPolicy,
    request: PeriodicWorkRequest
): Operation
```

Enqueues a uniquely-named [`PeriodicWorkRequest`](periodic-work-request.md), resolving collisions per the [`ExistingPeriodicWorkPolicy`](existing-periodic-work-policy.md).

### beginWith

> Added in 1.0.0
```
fun beginWith(work: OneTimeWorkRequest): WorkContinuation
fun beginWith(work: List<OneTimeWorkRequest>): WorkContinuation
```

Begins a chain of work with one or more [`OneTimeWorkRequest`](one-time-work-request.md)s, returning a [`WorkContinuation`](work-continuation.md) to chain further work with `.then(...)`.

### beginUniqueWork

> Added in 1.0.0
```
abstract fun beginUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    work: List<OneTimeWorkRequest>
): WorkContinuation
```

Begins a uniquely-named chain of work.

### cancelWorkById

> Added in 1.0.0
```
abstract fun cancelWorkById(id: UUID): Operation
```

Cancels work by its id.

### cancelAllWorkByTag

> Added in 1.0.0
```
abstract fun cancelAllWorkByTag(tag: String): Operation
```

Cancels all work with the given tag.

### cancelUniqueWork

> Added in 1.0.0
```
abstract fun cancelUniqueWork(uniqueWorkName: String): Operation
```

Cancels a uniquely-named chain of work.

### cancelAllWork

> Added in 1.0.0
```
abstract fun cancelAllWork(): Operation
```

> [!WARNING]
> Cancels **all** unfinished work. Use with caution — this can interfere with other libraries' work scheduled via WorkManager.

### createCancelPendingIntent

> Added in 2.4.0
```
abstract fun createCancelPendingIntent(id: UUID): PendingIntent
```

Creates a `PendingIntent` that cancels the work with the given id when fired.

### getWorkInfoById

> Added in 2.4.0
```
abstract fun getWorkInfoById(id: UUID): ListenableFuture<WorkInfo?>
```

Gets a `ListenableFuture` of the [`WorkInfo`](work-info.md) for a given id.

### getWorkInfoByIdLiveData

> Added in 2.4.0
```
abstract fun getWorkInfoByIdLiveData(id: UUID): LiveData<WorkInfo?>
```

Gets a `LiveData` of the [`WorkInfo`](work-info.md) for a given id.

### getWorkInfoByIdFlow

> Added in 2.10.0
```
abstract fun getWorkInfoByIdFlow(id: UUID): Flow<WorkInfo?>
```

Gets a `Flow` of the [`WorkInfo`](work-info.md) for a given id.

### getWorkInfosByTag / getWorkInfosByTagLiveData / getWorkInfosByTagFlow

> Added in 1.0.0 / 1.0.0 / 2.10.0
```
abstract fun getWorkInfosByTag(tag: String): ListenableFuture<List<WorkInfo>>
abstract fun getWorkInfosByTagLiveData(tag: String): LiveData<List<WorkInfo>>
abstract fun getWorkInfosByTagFlow(tag: String): Flow<List<WorkInfo>>
```

Gets the [`WorkInfo`](work-info.md)s for all work with the given tag, as a future, `LiveData`, or `Flow`.

### getWorkInfosForUniqueWork / …LiveData / …Flow

> Added in 1.0.0 / 1.0.0 / 2.10.0
```
abstract fun getWorkInfosForUniqueWork(uniqueWorkName: String): ListenableFuture<List<WorkInfo>>
abstract fun getWorkInfosForUniqueWorkLiveData(uniqueWorkName: String): LiveData<List<WorkInfo>>
abstract fun getWorkInfosForUniqueWorkFlow(uniqueWorkName: String): Flow<List<WorkInfo>>
```

Gets the [`WorkInfo`](work-info.md)s for a uniquely-named chain of work.

### getWorkInfos / getWorkInfosLiveData / getWorkInfosFlow

> Added in 2.4.0 / 2.4.0 / 2.10.0
```
abstract fun getWorkInfos(workQuery: WorkQuery): ListenableFuture<List<WorkInfo>>
abstract fun getWorkInfosLiveData(workQuery: WorkQuery): LiveData<List<WorkInfo>>
abstract fun getWorkInfosFlow(workQuery: WorkQuery): Flow<List<WorkInfo>>
```

Gets the [`WorkInfo`](work-info.md)s matching a [`WorkQuery`](work-query.md).

### getLastCancelAllTimeMillis / …LiveData

> Added in 2.1.0
```
abstract fun getLastCancelAllTimeMillis(): ListenableFuture<Long>
abstract fun getLastCancelAllTimeMillisLiveData(): LiveData<Long>
```

Gets the timestamp of the last [`cancelAllWork`](#cancelallwork) call.

### pruneWork

> Added in 1.0.0
```
abstract fun pruneWork(): Operation
```

Prunes finished work from the internal database.

### updateWork

> Added in 2.8.0
```
abstract fun updateWork(request: WorkRequest): ListenableFuture<WorkManager.UpdateResult>
```

Updates an existing [`WorkRequest`](work-request.md) (which must have an id set via [`WorkRequest.Builder.setId`](work-request-builder.md#setid)), returning a [`WorkManager.UpdateResult`](work-manager-update-result.md).

## Public Properties

### configuration

> Added in 2.9.0
```
abstract val configuration: Configuration
```

The [`Configuration`](configuration.md) WorkManager was initialized with.
