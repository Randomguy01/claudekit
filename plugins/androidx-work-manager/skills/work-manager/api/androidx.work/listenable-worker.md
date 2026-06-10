# API Reference

> Last updated 2026-06-10

# ListenableWorker

> Added in 1.0.0

```
abstract class ListenableWorker
```

A class that can perform work asynchronously in [`WorkManager`](work-manager.md). For most cases, prefer [`Worker`](worker.md), which offers a simple synchronous API executed on a pre-specified background thread.

`ListenableWorker` classes are instantiated at runtime by the [`WorkerFactory`](worker-factory.md) specified in the [`Configuration`](configuration.md). The [`startWork`](#startwork) method is called on the main thread.

If work is preempted and later restarted for any reason, a new instance of `ListenableWorker` is created — `startWork` is called exactly once per instance.

A `ListenableWorker` is given a maximum of ten minutes to finish its execution and return a [`Result`](listenable-worker-result.md). After this time expires, the worker is signalled to stop and its `ListenableFuture` is cancelled.

## Known Direct Subtypes

| Type | Description |
|------|-------------|
| [`CoroutineWorker`](coroutine-worker.md) | Provides interop with Kotlin Coroutines. |
| [`RxWorker`](rx-worker.md) | RxJava2 interoperability worker implementation. |
| [`Worker`](worker.md) | Performs work synchronously on a background thread provided by WorkManager. |

## Nested Types

| Type | Description |
|------|-------------|
| [`ListenableWorker.Result`](listenable-worker-result.md) | The result of a `ListenableWorker`'s computation. |

## Public Constructors

### ListenableWorker

> Added in 1.0.0
```
ListenableWorker(appContext: Context, workerParams: WorkerParameters)
```

- `appContext` — the application `Context`.
- `workerParams` — [`WorkerParameters`](worker-parameters.md) to set up the internal state of this worker.

## Public Functions

### getApplicationContext

> Added in 1.0.0
```
fun getApplicationContext(): Context
```

Gets the application `Context`.

### getForegroundInfoAsync

> Added in 2.7.0
```
fun getForegroundInfoAsync(): ListenableFuture<ForegroundInfo!>
```

Returns a `ListenableFuture` of a [`ForegroundInfo`](foreground-info.md) instance if the [`WorkRequest`](work-request.md) is important to the user; WorkManager then signals the OS to keep the process alive while this work executes.

Prior to Android S, WorkManager runs a foreground service on your behalf, showing the notification in the [`ForegroundInfo`](foreground-info.md). Starting in Android S, WorkManager manages the request using an immediate job. See [`WorkRequest.Builder.setExpedited`](work-request-builder.md#setexpedited).

### getId

> Added in 1.0.0
```
fun getId(): UUID
```

Gets the ID of the [`WorkRequest`](work-request.md) that created this worker.

### getInputData

> Added in 1.0.0
```
fun getInputData(): Data
```

Gets the input [`Data`](data.md). When there are multiple prerequisites for this worker, the input data has been run through an [`InputMerger`](input-merger.md).

### getNetwork

> Added in 1.0.0
```
@RequiresApi(value = 28)
fun getNetwork(): Network?
```

Gets the `Network` to use for this worker, or `null` if no network is needed for this work request.

### getRunAttemptCount

> Added in 1.0.0
```
fun getRunAttemptCount(): @IntRange(from = 0) Int
```

Gets the current run attempt count for this work. For periodic work, this value resets between periods.

### getStopReason

> Added in 2.9.0
```
@RequiresApi(value = 31)
fun getStopReason(): Int
```

Returns a reason why this worker has been stopped, matching the `JobParameters.STOP_REASON_*` constants. If the worker hasn't been stopped, `STOP_REASON_NOT_STOPPED` is returned.

### getTags

> Added in 1.0.0
```
fun getTags(): (Mutable)Set<String!>
```

Gets the set of tags associated with this worker's [`WorkRequest`](work-request.md). See [`WorkRequest.Builder.addTag`](work-request-builder.md#addtag).

### getTriggeredContentAuthorities

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun getTriggeredContentAuthorities(): (Mutable)List<String!>
```

Gets the list of content authorities that caused this worker to execute.

### getTriggeredContentUris

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun getTriggeredContentUris(): (Mutable)List<Uri!>
```

Gets the list of content `Uri`s that caused this worker to execute. See [`Constraints.Builder.addContentUriTrigger`](constraints-builder.md#addcontenturitrigger).

### isStopped

> Added in 1.0.0
```
fun isStopped(): Boolean
```

Returns `true` if this worker has been told to stop — because of an explicit cancellation by the user, or because the system decided to preempt the task. In these cases the results are ignored by WorkManager, and it is safe to stop the computation; WorkManager will retry the work later if necessary.

### onStopped

> Added in 1.0.0
```
fun onStopped(): Unit
```

Invoked when this worker has been told to stop. At this point the `ListenableFuture` returned by [`startWork`](#startwork) is also cancelled. Keep all processing here lightweight — there are no guarantees about which thread invokes this call, so it should not be long-running or blocking.

### setForegroundAsync

> Added in 2.3.0
```
fun setForegroundAsync(foregroundInfo: ForegroundInfo): ListenableFuture<Void!>
```

Specifies that the [`WorkRequest`](work-request.md) is long-running or otherwise important; WorkManager signals the OS to keep the process alive while this work executes. Calls to `setForegroundAsync` must complete before the worker signals completion by returning a [`Result`](listenable-worker-result.md).

Throws `IllegalStateException` when the process is subject to foreground service restrictions; consider [`WorkRequest.Builder.setExpedited`](work-request-builder.md#setexpedited) and [`getForegroundInfoAsync`](#getforegroundinfoasync) instead.

### setProgressAsync

> Added in 2.3.0
```
fun setProgressAsync(data: Data): ListenableFuture<Void!>
```

Updates the worker's progress. The returned future resolves after the progress [`Data`](data.md) is persisted; cancelling it is a no-op.

### startWork

> Added in 1.0.0
```
@MainThread
abstract fun startWork(): ListenableFuture<ListenableWorker.Result!>
```

Override this method to start your actual background processing. Called on the main thread. Returns a `ListenableFuture` with the [`Result`](listenable-worker-result.md) of the computation; cancelling it causes WorkManager to treat the work as failed. The future is also cancelled if the worker is stopped (see [`onStopped`](#onstopped)).
