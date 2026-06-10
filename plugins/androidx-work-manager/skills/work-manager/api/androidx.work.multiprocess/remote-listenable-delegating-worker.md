# API Reference

> Last updated 2026-06-10

# RemoteListenableDelegatingWorker

> Added in 2.10.0

```
class RemoteListenableDelegatingWorker : ListenableWorker
```

A worker which can delegate to an instance of [`RemoteListenableWorker`](remote-listenable-worker.md), but importantly only constructs that `RemoteListenableWorker` in the remote process. Ships in the `androidx.work:work-multiprocess` artifact.

## Public Constructors

### RemoteListenableDelegatingWorker

> Added in 2.10.0
```
RemoteListenableDelegatingWorker(
    context: Context,
    workerParameters: WorkerParameters
)
```

## Public Functions

### getForegroundInfoAsync

```
open fun getForegroundInfoAsync(): ListenableFuture<ForegroundInfo>
```

Returns a `ListenableFuture` of a [`ForegroundInfo`](../androidx.work/foreground-info.md) instance if the [`WorkRequest`](../androidx.work/work-request.md) is marked immediate; WorkManager then signals the OS to keep the process alive while this work executes. Prior to Android S, WorkManager runs a foreground service showing the notification in the [`ForegroundInfo`](../androidx.work/foreground-info.md); starting in Android S it uses an immediate job. See [`WorkRequest.Builder.setExpedited`](../androidx.work/work-request-builder.md#setexpedited).

### onStopped

```
open fun onStopped(): Unit
```

Invoked when this worker has been told to stop; at this point the `ListenableFuture` returned by `startWork` is also cancelled. Keep all processing here lightweight — there are no guarantees about which thread invokes this call.

### startWork

> Added in 2.10.0
```
open fun startWork(): ListenableFuture<ListenableWorker.Result>
```

Override this method to start your actual background processing. Called on the main thread. Returns a `ListenableFuture` with the [`Result`](../androidx.work/listenable-worker-result.md); cancelling it causes WorkManager to treat the work as failed. The future is also cancelled if the worker is stopped (see [`onStopped`](#onstopped)).

## Public Properties

### foregroundInfoAsync

```
open val foregroundInfoAsync: ListenableFuture<ForegroundInfo>
```

## Inherited Members

Inherits the rest of its API (e.g. `getId`, `getInputData`, `setProgressAsync`, `setForegroundAsync`) from [`ListenableWorker`](../androidx.work/listenable-worker.md).
