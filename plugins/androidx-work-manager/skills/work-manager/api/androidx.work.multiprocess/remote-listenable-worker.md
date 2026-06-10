# API Reference

> Last updated 2026-06-10

# RemoteListenableWorker

> Added in 2.6.0

```
abstract class RemoteListenableWorker : ListenableWorker
```

An implementation of [`ListenableWorker`](../androidx.work/listenable-worker.md) that can bind to a remote process. Ships in the `androidx.work:work-multiprocess` artifact.

To bind to a remote process, a `RemoteListenableWorker` needs additional arguments as part of its input [`Data`](../androidx.work/data.md). The [`ARGUMENT_PACKAGE_NAME`](#argument_package_name) and [`ARGUMENT_CLASS_NAME`](#argument_class_name) arguments determine the `Service` the worker binds to. [`startRemoteWork`](#startremotework) is then called in the process that the `Service` runs in.

## Known Direct Subtypes

| Type | Description |
|------|-------------|
| [`RemoteCoroutineWorker`](remote-coroutine-worker.md) | A `RemoteListenableWorker` that provides interop with Kotlin Coroutines. |

## Constants

### ARGUMENT_CLASS_NAME

> Added in 2.6.0
```
const val ARGUMENT_CLASS_NAME = "androidx.work.impl.workers.RemoteListenableWorker.ARGUMENT_CLASS_NAME": String!
```

The [`ARGUMENT_PACKAGE_NAME`](#argument_package_name) and class name together determine the `ComponentName` that the `RemoteListenableWorker` binds to before calling [`startRemoteWork`](#startremotework).

### ARGUMENT_PACKAGE_NAME

> Added in 2.6.0
```
const val ARGUMENT_PACKAGE_NAME = "androidx.work.impl.workers.RemoteListenableWorker.ARGUMENT_PACKAGE_NAME": String!
```

The package name and [`ARGUMENT_CLASS_NAME`](#argument_class_name) together determine the `ComponentName` that the `RemoteListenableWorker` binds to before calling [`startRemoteWork`](#startremotework).

## Public Constructors

### RemoteListenableWorker

> Added in 2.6.0
```
RemoteListenableWorker(appContext: Context, workerParams: WorkerParameters)
```

- `appContext` — the application `Context`.
- `workerParams` — [`WorkerParameters`](../androidx.work/worker-parameters.md) to set up the internal state of this worker.

## Public Functions

### startRemoteWork

> Added in 2.6.0
```
abstract fun startRemoteWork(): ListenableFuture<ListenableWorker.Result!>
```

Override this method to define the work that needs to run in the remote process. Called on the main thread. The worker has a well-defined execution window — which includes the cost of binding to the remote process — to finish and return a [`Result`](../androidx.work/listenable-worker-result.md); after it expires the worker is signalled to stop and its `ListenableFuture` is cancelled. The worker is also signalled to stop when its constraints are no longer met. Cancelling the returned future causes WorkManager to treat the work as failed.

### startWork

> Added in 2.6.0
```
fun startWork(): ListenableFuture<ListenableWorker.Result!>
```

Drives the remote binding and [`startRemoteWork`](#startremotework), returning a `ListenableFuture` with the [`Result`](../androidx.work/listenable-worker-result.md). The future is cancelled if the worker is stopped for any reason.

## Inherited Members

Inherits the rest of its API (e.g. `getId`, `getInputData`, `setProgressAsync`, `setForegroundAsync`, `onStopped`) from [`ListenableWorker`](../androidx.work/listenable-worker.md).
