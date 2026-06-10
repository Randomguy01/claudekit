# API Reference

> Last updated 2026-06-10

# Worker

> Added in 1.0.0

```
abstract class Worker : ListenableWorker
```

A class that performs work synchronously on a background thread provided by [`WorkManager`](work-manager.md).

`Worker` classes are instantiated at runtime by WorkManager, and [`doWork`](#dowork) is called on a pre-specified background thread (see [`Configuration.executor`](configuration.md#executor)). This method is for **synchronous** processing — once you return from it, the worker is considered finished and is destroyed. To do work asynchronously or call asynchronous APIs, use [`ListenableWorker`](listenable-worker.md) instead.

If work is preempted for any reason, the same `Worker` instance is not reused — [`doWork`](#dowork) is called exactly once per instance.

A `Worker` is given a maximum of ten minutes to finish and return a [`Result`](listenable-worker-result.md). After this time expires, the worker is signalled to stop.

## Public Constructors

### Worker

> Added in 1.0.0
```
Worker(context: Context, workerParams: WorkerParameters)
```

## Public Functions

### doWork

> Added in 1.0.0
```
@WorkerThread
abstract fun doWork(): ListenableWorker.Result
```

Override this method to do your actual background processing. Called on a background thread — do your work **synchronously** and return the [`Result`](listenable-worker-result.md). Once you return, the worker is considered finished and is destroyed. To run work asynchronously on a thread of your own choice, see [`ListenableWorker`](listenable-worker.md).

### getForegroundInfo

> Added in 2.8.0
```
@WorkerThread
open fun getForegroundInfo(): ForegroundInfo
```

Returns a [`ForegroundInfo`](foreground-info.md) instance if the [`WorkRequest`](work-request.md) is important to the user; WorkManager then signals the OS to keep the process alive while this work executes. Throws `IllegalStateException` if it is not overridden and the worker tries to go to the foreground. See [`WorkRequest.Builder.setExpedited`](work-request-builder.md#setexpedited).

### getForegroundInfoAsync

```
open fun getForegroundInfoAsync(): ListenableFuture<ForegroundInfo>
```

The async equivalent of [`getForegroundInfo`](#getforegroundinfo), returning a `ListenableFuture` of [`ForegroundInfo`](foreground-info.md).

### startWork

```
final fun startWork(): ListenableFuture<ListenableWorker.Result>
```

Final override that drives [`doWork`](#dowork) on the background thread and returns a `ListenableFuture` with the [`Result`](listenable-worker-result.md).

## Inherited Members

Inherits the member-access functions from [`ListenableWorker`](listenable-worker.md) (`getApplicationContext`, `getId`, `getInputData`, `getTags`, `isStopped`, `onStopped`, `setForegroundAsync`, `setProgressAsync`, etc.).
