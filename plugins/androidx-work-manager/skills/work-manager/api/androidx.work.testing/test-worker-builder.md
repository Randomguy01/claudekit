# API Reference

> Last updated 2026-06-10

# TestWorkerBuilder

> Added in 2.1.0

```
class TestWorkerBuilder<W : Worker?> : TestListenableWorkerBuilder
```

Builds instances of [`Worker`](../androidx.work/worker.md) which can be used for testing. `W` is the actual [`Worker`](../androidx.work/worker.md) subtype being built. Create one with [`from`](#from), or use the [`TestWorkerBuilder`](package-functions.md#testworkerbuilder) top-level factory function.

## Public Companion Functions

### from

> Added in 2.1.0
```
java-static fun from(
    context: Context,
    workRequest: WorkRequest,
    executor: Executor
): TestWorkerBuilder<Worker!>
```

Creates a new instance of a `TestWorkerBuilder` from a [`WorkRequest`](../androidx.work/work-request.md) that runs on the given `Executor`.

### from

> Added in 2.1.0
```
java-static fun <W : Worker?> from(
    context: Context,
    workerClass: Class<W!>,
    executor: Executor
): TestWorkerBuilder<W!>
```

Creates a new instance of a `TestWorkerBuilder` with the worker `Class` that runs on the given `Executor`.

## Inherited Members

Inherits its building API (`build`, `setId`, `setInputData`, `setTags`, `setRunAttemptCount`, `setWorkerFactory`, `setForegroundUpdater`, `setProgressUpdater`, `setNetwork`, `setTriggeredContentUris`, `setTriggeredContentAuthorities`) from [`TestListenableWorkerBuilder`](test-listenable-worker-builder.md).

## Extension Functions

The top-level [`TestWorkerBuilder`](package-functions.md#testworkerbuilder) function offers a Kotlin-friendly way to create a builder with default arguments.
