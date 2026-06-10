# API Reference

> Last updated 2026-06-10

# ListenableWorker.Result

> Added in 1.0.0

```
abstract class ListenableWorker.Result
```

The result of a [`ListenableWorker`](listenable-worker.md)'s computation. Call [`success`](#success), [`failure`](#failure), or [`retry`](#retry) (or one of their variants) to generate an object indicating what happened in your background work.

## Public Functions

### failure

> Added in 1.0.0
```
java-static fun failure(): ListenableWorker.Result
```

Returns a `Result` indicating that the work completed with a permanent failure. Any work that depends on this is also marked as failed and will not run.

**If you need child workers to run, use [`success`](#success) instead** — failure indicates a permanent stoppage of the chain of work.

### failure

> Added in 1.0.0
```
java-static fun failure(outputData: Data): ListenableWorker.Result
```

As above, with an output [`Data`](data.md) object that can be used to track why the work failed.

### getOutputData

> Added in 2.6.0
```
abstract fun getOutputData(): Data
```

Returns the output [`Data`](data.md) that will be merged into the input data of any [`OneTimeWorkRequest`](one-time-work-request.md) dependent on this work request.

### retry

> Added in 1.0.0
```
java-static fun retry(): ListenableWorker.Result
```

Returns a `Result` indicating that the work encountered a transient failure and should be retried with the backoff specified in [`WorkRequest.Builder.setBackoffCriteria`](work-request-builder.md#setbackoffcriteria).

### success

> Added in 1.0.0
```
java-static fun success(): ListenableWorker.Result
```

Returns a `Result` indicating that the work completed successfully. Any dependent work can execute once its other dependencies and constraints are met.

### success

> Added in 1.0.0
```
java-static fun success(outputData: Data): ListenableWorker.Result
```

As above, with an output [`Data`](data.md) object that will be merged into the input data of any dependent [`OneTimeWorkRequest`](one-time-work-request.md).
