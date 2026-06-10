# API Reference

> Last updated 2026-06-10

# RemoteWorkManager

> Added in 2.5.0

```
abstract class RemoteWorkManager
```

A subset of [`WorkManager`](../androidx.work/work-manager.md) APIs that are available for apps that use multiple processes. Obtain an instance with [`getInstance`](#getinstance).

## Public Companion Functions

### getInstance

> Added in 2.5.0
```
java-static fun getInstance(context: Context): RemoteWorkManager
```

Gets the instance of `RemoteWorkManager` which provides a subset of [`WorkManager`](../androidx.work/work-manager.md) APIs that are safe to use for apps that use multiple processes.

## Public Functions

### beginUniqueWork

> Added in 2.5.0
```
fun beginUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    work: OneTimeWorkRequest
): RemoteWorkContinuation

abstract fun beginUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    work: (Mutable)List<OneTimeWorkRequest!>
): RemoteWorkContinuation
```

Begins a unique chain of work for situations where you only want one chain with a given name active at a time — for example, a single sync operation. The `uniqueWorkName` uniquely identifies this set of work, and the [`ExistingWorkPolicy`](../androidx.work/existing-work-policy.md) decides what happens to any pending chain with that name.

If new work should be enqueued, all records of previous work with `uniqueWorkName` are pruned; otherwise the chain is a no-op. If any work in the chain fails or is cancelled, all dependent work inherits that state — particularly important with `APPEND`. Returns a [`RemoteWorkContinuation`](remote-work-continuation.md).

### beginWith

> Added in 2.5.0
```
fun beginWith(work: OneTimeWorkRequest): RemoteWorkContinuation
abstract fun beginWith(work: (Mutable)List<OneTimeWorkRequest!>): RemoteWorkContinuation
```

Begins a chain with one or more [`OneTimeWorkRequest`](../androidx.work/one-time-work-request.md)s, which can be enqueued together later via [`RemoteWorkContinuation.enqueue`](remote-work-continuation.md#enqueue). If any work in the chain fails or is cancelled, all dependent work inherits that state.

### cancelAllWork

> Added in 2.5.0
```
abstract fun cancelAllWork(): ListenableFuture<Void!>
```

Cancels all unfinished work. **Use with extreme caution** — this potentially affects other modules or libraries in your codebase; prefer one of the other cancellation methods. Upon cancellation, [`onStopped`](../androidx.work/listenable-worker.md#onstopped) is invoked for any affected workers.

### cancelAllWorkByTag

> Added in 2.5.0
```
abstract fun cancelAllWorkByTag(tag: String): ListenableFuture<Void!>
```

Cancels all unfinished work with the given tag. Cancellation is best-effort; work already executing may continue to run.

### cancelUniqueWork

> Added in 2.5.0
```
abstract fun cancelUniqueWork(uniqueWorkName: String): ListenableFuture<Void!>
```

Cancels all unfinished work in the work chain with the given name. Cancellation is best-effort; work already executing may continue to run.

### cancelWorkById

> Added in 2.5.0
```
abstract fun cancelWorkById(id: UUID): ListenableFuture<Void!>
```

Cancels work with the given id if it isn't finished. Cancellation is best-effort; work already executing may continue to run.

### enqueue

> Added in 2.5.0
```
abstract fun enqueue(request: WorkRequest): ListenableFuture<Void!>
abstract fun enqueue(requests: (Mutable)List<WorkRequest!>): ListenableFuture<Void!>
```

Enqueues one or more [`WorkRequest`](../androidx.work/work-request.md)s for background processing.

### enqueueUniquePeriodicWork

> Added in 2.5.0
```
abstract fun enqueueUniquePeriodicWork(
    uniqueWorkName: String,
    existingPeriodicWorkPolicy: ExistingPeriodicWorkPolicy,
    periodicWork: PeriodicWorkRequest
): ListenableFuture<Void!>
```

Enqueues a uniquely-named [`PeriodicWorkRequest`](../androidx.work/periodic-work-request.md), where only one of a particular name can be active at a time. The [`ExistingPeriodicWorkPolicy`](../androidx.work/existing-periodic-work-policy.md) decides what happens to any pending request with that name.

### enqueueUniqueWork

> Added in 2.5.0
```
fun enqueueUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    work: OneTimeWorkRequest
): ListenableFuture<Void!>

abstract fun enqueueUniqueWork(
    uniqueWorkName: String,
    existingWorkPolicy: ExistingWorkPolicy,
    work: (Mutable)List<OneTimeWorkRequest!>
): ListenableFuture<Void!>
```

Enqueues `work` requests to a uniquely-named continuation, where only one continuation of a particular name can be active at a time. The `uniqueWorkName` uniquely identifies it and the [`ExistingWorkPolicy`](../androidx.work/existing-work-policy.md) decides what happens to any pending work with that name.

### getWorkInfos

> Added in 2.5.0
```
abstract fun getWorkInfos(workQuery: WorkQuery): ListenableFuture<(Mutable)List<WorkInfo!>!>
```

Gets a `ListenableFuture` of the list of [`WorkInfo`](../androidx.work/work-info.md) for all work referenced by the [`WorkQuery`](../androidx.work/work-query.md) specification.
