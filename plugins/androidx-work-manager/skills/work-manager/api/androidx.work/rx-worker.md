# API Reference

> Last updated 2026-06-10

# RxWorker

> Added in 1.0.0

```
abstract class RxWorker : ListenableWorker
```

RxJava2 interoperability [`ListenableWorker`](listenable-worker.md) implementation. When invoked by [`WorkManager`](work-manager.md), it calls [`createWork`](#creatework) to get a `Single<Result>` and subscribes to it.

By default, `RxWorker` subscribes on the thread pool that runs WorkManager's [`Worker`](worker.md)s. Change this by overriding [`getBackgroundScheduler`](#getbackgroundscheduler).

An `RxWorker` is given a maximum of ten minutes to finish and return a [`Result`](listenable-worker-result.md). After this time expires, the worker is signalled to stop.

> [!NOTE]
> `RxWorker` ships in the separate `androidx.work:work-rxjava2` artifact. An RxJava3 variant lives in the `androidx.work.rxjava3` package.

## Public Functions

### createWork

> Added in 1.0.0
```
@MainThread
abstract fun createWork(): Single<ListenableWorker.Result!>
```

Override this method to define your work and return a `Single` of [`Result`](listenable-worker-result.md), which WorkManager subscribes to. If the returned `Single` fails, the worker is considered failed. If the worker is cancelled by WorkManager (e.g. due to a constraint change), the subscription is disposed immediately. By default, subscription happens on the shared worker pool; change it via [`getBackgroundScheduler`](#getbackgroundscheduler).

### getForegroundInfo

> Added in 2.8.0
```
fun getForegroundInfo(): Single<ForegroundInfo!>
```

Returns a `Single` with a [`ForegroundInfo`](foreground-info.md) instance if the [`WorkRequest`](work-request.md) is important to the user; WorkManager then signals the OS to keep the process alive while this work executes.

### getForegroundInfoAsync

```
fun getForegroundInfoAsync(): ListenableFuture<ForegroundInfo!>
```

The `ListenableFuture` equivalent of [`getForegroundInfo`](#getforegroundinfo).

### setCompletableProgress

> Added in 2.4.0
```
fun setCompletableProgress(data: Data): Completable
```

Updates the progress for the worker, returning a `Completable` (unlike [`ListenableWorker.setProgressAsync`](listenable-worker.md#setprogressasync)).

### setForeground

> Added in 2.8.0
```
fun setForeground(foregroundInfo: ForegroundInfo): Completable
```

Specifies that the [`WorkRequest`](work-request.md) is long-running or otherwise important. Calls must complete before the worker signals completion by returning a [`Result`](listenable-worker-result.md). Throws `IllegalStateException` when the process is subject to foreground service restrictions; consider [`WorkRequest.Builder.setExpedited`](work-request-builder.md#setexpedited) and [`getForegroundInfo`](#getforegroundinfo) instead.

### setProgress

> Added in 2.3.0 · Deprecated in 2.4.0
```
fun setProgress(data: Data): Single<Void!>
```

**Deprecated — use [`setCompletableProgress`](#setcompletableprogress) instead.**

Updates the progress for the worker, returning a `Single` (unlike [`ListenableWorker.setProgressAsync`](listenable-worker.md#setprogressasync)).

### startWork

> Added in 1.0.0
```
fun startWork(): ListenableFuture<ListenableWorker.Result!>
```

Drives [`createWork`](#creatework) and returns a `ListenableFuture` with the [`Result`](listenable-worker-result.md).

## Protected Functions

### getBackgroundScheduler

> Added in 1.0.0
```
protected fun getBackgroundScheduler(): Scheduler
```

Returns the default background `Scheduler` that `RxWorker` uses to subscribe. The default implementation uses the `Executor` provided in WorkManager's [`Configuration`](configuration.md). Override this to change the scheduler used to start the subscription; the result of the `Single` is always observed on WorkManager's internal thread.
