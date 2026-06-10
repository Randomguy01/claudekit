# API Reference

> Last updated 2026-06-10

# WorkRequest.Builder

> Added in 1.0.0

```
abstract class WorkRequest.Builder<B : WorkRequest.Builder<B, *>, W : WorkRequest>
```

A builder for [`WorkRequest`](work-request.md)s. There are two concrete implementations: [`OneTimeWorkRequest.Builder`](one-time-work-request-builder.md) and [`PeriodicWorkRequest.Builder`](periodic-work-request-builder.md). Each setter returns the builder (`B`) for chaining.

## Public Functions

### addTag

> Added in 1.0.0
```
fun addTag(tag: String): B
```

Adds a tag for the work. You can query and cancel work by tags. Tags are particularly useful for modules or libraries to find and operate on their own work.

### build

> Added in 1.0.0
```
fun build(): W
```

Builds a [`WorkRequest`](work-request.md) based on this builder.

### keepResultsForAtLeast

> Added in 1.0.0
```
@RequiresApi(value = 26)
fun keepResultsForAtLeast(duration: Duration): B
```

Specifies that the results of this work should be kept for at least the given time. After this time elapses, the results may be pruned at WorkManager's discretion once the request has reached a finished state (see [`WorkInfo.State.isFinished`](work-info-state.md#isfinished)) and there are no pending dependent jobs. Once pruned, its [`WorkInfo`](work-info.md) can no longer be queried. A long duration may adversely affect app storage and database query time.

### keepResultsForAtLeast

> Added in 1.0.0
```
fun keepResultsForAtLeast(duration: Long, timeUnit: TimeUnit): B
```

As above, with the duration expressed in `timeUnit` units.

### setBackoffCriteria

> Added in 1.0.0
```
@RequiresApi(value = 26)
fun setBackoffCriteria(backoffPolicy: BackoffPolicy, duration: Duration): B
```

Sets the backoff policy and delay for the work. Defaults are [`BackoffPolicy.EXPONENTIAL`](backoff-policy.md#exponential) and [`DEFAULT_BACKOFF_DELAY_MILLIS`](work-request.md#default_backoff_delay_millis). `duration` is clamped between [`MIN_BACKOFF_MILLIS`](work-request.md#min_backoff_millis) and [`MAX_BACKOFF_MILLIS`](work-request.md#max_backoff_millis).

### setBackoffCriteria

> Added in 1.0.0
```
fun setBackoffCriteria(
    backoffPolicy: BackoffPolicy,
    backoffDelay: Long,
    timeUnit: TimeUnit
): B
```

As above, with the delay expressed in `timeUnit` units.

### setBackoffForSystemInterruptions

> Added in 2.11.2
```
@ExperimentalWorkRequestBuilderApi
fun setBackoffForSystemInterruptions(): B
```

Specifies that the backoff policy (set via [`setBackoffCriteria`](#setbackoffcriteria)) will be applied when work is interrupted by the system without the app requesting it — e.g. when the [`ListenableWorker`](listenable-worker.md) runs longer than it should, or when its constraints become unmet. Requires opt-in via [`ExperimentalWorkRequestBuilderApi`](experimental-work-request-builder-api.md).

### setConstraints

> Added in 1.0.0
```
fun setConstraints(constraints: Constraints): B
```

Adds [`Constraints`](constraints.md) to the [`WorkRequest`](work-request.md).

### setExpedited

> Added in 2.7.0
```
open fun setExpedited(policy: OutOfQuotaPolicy): B
```

Marks the [`WorkRequest`](work-request.md) as important to the user, providing an additional signal to the OS. Execution time isn't counted against your app's quota while the app is in the foreground, but expedited work that continues in the background is subject to quota. Power-management restrictions like Battery Saver and Doze are less likely to affect it. Best suited for short, immediate, user-important tasks. Takes an [`OutOfQuotaPolicy`](out-of-quota-policy.md).

### setId

> Added in 2.8.0
```
fun setId(id: UUID): B
```

Sets a unique identifier for this unit of work. Useful when retrieving [`WorkInfo`](work-info.md) by id or updating existing work — [`WorkManager.updateWork`](work-manager.md#updatework) requires the work to have an id.

### setInitialDelay

> Added in 2.1.0
```
@RequiresApi(value = 26)
open fun setInitialDelay(duration: Duration): B
```

Sets an initial delay for the [`WorkRequest`](work-request.md). Throws `IllegalArgumentException` if the delay pushes the execution time past `Long.MAX_VALUE` and causes an overflow.

### setInitialDelay

> Added in 2.1.0
```
open fun setInitialDelay(duration: Long, timeUnit: TimeUnit): B
```

As above, with the delay expressed in `timeUnit` units.

### setInputData

> Added in 1.0.0
```
fun setInputData(inputData: Data): B
```

Adds input [`Data`](data.md) to the work. If a worker has prerequisites in its chain, this data is merged with the outputs of the prerequisites using an [`InputMerger`](input-merger.md).

### setTraceTag

> Added in 2.10.0
```
fun setTraceTag(traceTag: String): B
```

Specifies the name of the trace span used by [`WorkManager`](work-manager.md) when executing this [`WorkRequest`](work-request.md). By default WorkManager uses the simple name of the [`ListenableWorker`](listenable-worker.md) class, truncated to 127 characters. Override this when using worker delegation via a [`WorkerFactory`](worker-factory.md).
