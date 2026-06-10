# API Reference

> Last updated 2026-06-10

# CoroutineWorker

> Added in 1.0.0

```
abstract class CoroutineWorker : ListenableWorker
```

A [`ListenableWorker`](listenable-worker.md) implementation that provides interop with Kotlin Coroutines. Override [`doWork`](#dowork) to do your suspending work.

By default, `CoroutineWorker` runs on `Dispatchers.Default` if neither [`Configuration.Builder.setExecutor`](configuration-builder.md#setexecutor) nor [`Configuration.Builder.setWorkerCoroutineContext`](configuration-builder.md#setworkercoroutinecontext) was set.

A `CoroutineWorker` is given a maximum of ten minutes to finish and return a [`Result`](listenable-worker-result.md). After this time expires, the worker is signalled to stop.

## Public Constructors

### CoroutineWorker

> Added in 1.0.0
```
CoroutineWorker(appContext: Context, params: WorkerParameters)
```

## Public Functions

### doWork

```
abstract suspend fun doWork(): ListenableWorker.Result
```

A suspending method to do your work. To specify which `CoroutineDispatcher` your work should run on, use `withContext()` within `doWork()`; if none is declared, `Dispatchers.Default` is used. Returns the [`Result`](listenable-worker-result.md) of the background work.

### getForegroundInfo

```
open suspend fun getForegroundInfo(): ForegroundInfo
```

Returns the [`ForegroundInfo`](foreground-info.md) instance if the [`WorkRequest`](work-request.md) is marked as expedited. Throws `IllegalStateException` when not overridden; override it when the corresponding request is marked expedited.

### getForegroundInfoAsync

> Added in 2.7.0
```
final fun getForegroundInfoAsync(): ListenableFuture<ForegroundInfo>
```

The async equivalent of [`getForegroundInfo`](#getforegroundinfo), returning a `ListenableFuture` of [`ForegroundInfo`](foreground-info.md).

### onStopped

> Added in 1.0.0
```
final fun onStopped(): Unit
```

Invoked when this worker has been told to stop; the `ListenableFuture` returned by `startWork` is also cancelled. Keep all processing here lightweight — there are no guarantees about which thread invokes this call.

### setForeground

> Added in 2.3.0
```
suspend fun setForeground(foregroundInfo: ForegroundInfo): Unit
```

Makes the `CoroutineWorker` run in the context of a foreground service. This is the suspending equivalent of [`ListenableWorker.setForegroundAsync`](listenable-worker.md#setforegroundasync). Throws `IllegalStateException` if the process is subject to foreground service restrictions; consider [`WorkRequest.Builder.setExpedited`](work-request-builder.md#setexpedited) and [`getForegroundInfo`](#getforegroundinfo) instead.

### setProgress

> Added in 2.3.0
```
suspend fun setProgress(data: Data): Unit
```

Updates the progress for the `CoroutineWorker`. This is the suspending equivalent of [`ListenableWorker.setProgressAsync`](listenable-worker.md#setprogressasync).

### startWork

> Added in 1.0.0
```
final fun startWork(): ListenableFuture<ListenableWorker.Result>
```

Final override that drives [`doWork`](#dowork) and returns a `ListenableFuture` with the [`Result`](listenable-worker-result.md).

## Public Properties

### coroutineContext

> Added in 1.0.0 · Deprecated in 2.1.0
```
open val coroutineContext: CoroutineDispatcher
```

**Deprecated — use `withContext(...)` inside `doWork()` instead.**

The coroutine context on which [`doWork`](#dowork) runs. If overridden, it takes precedence over [`Configuration.executor`](configuration.md#executor) or `Configuration.workerCoroutineContext`. Defaults to a dispatcher delegating to `Dispatchers.Default`.

### foregroundInfoAsync

> Added in 2.7.0
```
final val foregroundInfoAsync: ListenableFuture<ForegroundInfo>
```
