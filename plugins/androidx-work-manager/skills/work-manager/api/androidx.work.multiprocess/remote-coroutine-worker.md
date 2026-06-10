# API Reference

> Last updated 2026-06-10

# RemoteCoroutineWorker

> Added in 2.6.0

```
abstract class RemoteCoroutineWorker : RemoteListenableWorker
```

An implementation of [`RemoteListenableWorker`](remote-listenable-worker.md) that provides interop with Kotlin Coroutines. Ships in the `androidx.work:work-multiprocess` artifact.

To bind to a remote process, a `RemoteCoroutineWorker` needs additional arguments as part of its input [`Data`](../androidx.work/data.md). The [`ARGUMENT_PACKAGE_NAME`](remote-listenable-worker.md#argument_package_name) and [`ARGUMENT_CLASS_NAME`](remote-listenable-worker.md#argument_class_name) arguments determine the `Service` the worker binds to. [`doRemoteWork`](#doremotework) is then called in the process that the `Service` runs in.

## Public Constructors

### RemoteCoroutineWorker

> Added in 2.6.0
```
RemoteCoroutineWorker(context: Context, parameters: WorkerParameters)
```

## Public Functions

### doRemoteWork

```
abstract suspend fun doRemoteWork(): ListenableWorker.Result
```

Override this method to define the work that needs to run in the remote process; `Dispatchers.Default` is the dispatcher used when it is called. The worker has a well-defined execution window — which includes the cost of binding to the remote process — to finish and return a [`Result`](../androidx.work/listenable-worker-result.md).

### onStopped

> Added in 2.6.0
```
final fun onStopped(): Unit
```

Invoked when this worker has been told to stop; at this point the `ListenableFuture` returned by `startWork` is also cancelled. Keep all processing here lightweight — there are no guarantees about which thread invokes this call.

### setProgress

> Added in 2.6.0
```
suspend fun setProgress(data: Data): Unit
```

Updates the progress for the worker. This is the suspending equivalent of [`ListenableWorker.setProgressAsync`](../androidx.work/listenable-worker.md#setprogressasync), which returns a `ListenableFuture`.

### startRemoteWork

```
open fun startRemoteWork(): ListenableFuture<ListenableWorker.Result>
```

Drives [`doRemoteWork`](#doremotework) and returns a `ListenableFuture` with the [`Result`](../androidx.work/listenable-worker-result.md). Cancelling it causes WorkManager to treat the work as failed.

## Inherited Members

Inherits the rest of its API from [`RemoteListenableWorker`](remote-listenable-worker.md) and [`ListenableWorker`](../androidx.work/listenable-worker.md).
