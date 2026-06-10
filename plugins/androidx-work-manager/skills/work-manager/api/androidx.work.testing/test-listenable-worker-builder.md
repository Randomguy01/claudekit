# API Reference

> Last updated 2026-06-10

# TestListenableWorkerBuilder

> Added in 2.1.0

```
class TestListenableWorkerBuilder<W : ListenableWorker?>
```

Builds instances of [`ListenableWorker`](../androidx.work/listenable-worker.md) which can be used for testing. `W` is the actual [`ListenableWorker`](../androidx.work/listenable-worker.md) subtype being built. Create one with [`from`](#from), or use the [`TestListenableWorkerBuilder`](package-functions.md#testlistenableworkerbuilder) top-level factory function.

## Known Direct Subtypes

| Type | Summary |
|---|---|
| [`TestWorkerBuilder`](test-worker-builder.md) | Builds instances of [`Worker`](../androidx.work/worker.md) which can be used for testing. |

## Public Companion Functions

### from

> Added in 2.1.0
```
java-static fun from(
    context: Context,
    workRequest: WorkRequest
): TestListenableWorkerBuilder<ListenableWorker!>
```

Creates a new instance of a `TestListenableWorkerBuilder` from a [`WorkRequest`](../androidx.work/work-request.md).

### from

> Added in 2.1.0
```
java-static fun <W : ListenableWorker?> from(
    context: Context,
    workerClass: Class<W!>
): TestListenableWorkerBuilder<W!>
```

Creates a new instance of a `TestListenableWorkerBuilder` from the worker `Class`. `workerClass` is the [`ListenableWorker`](../androidx.work/listenable-worker.md) subtype being built.

## Public Functions

### build

> Added in 2.1.0
```
fun build(): W
```

Builds the [`ListenableWorker`](../androidx.work/listenable-worker.md).

### build

> Added in 2.11.0
```
fun build(enqueuedClass: Class<ListenableWorker!>): W
```

Builds the [`ListenableWorker`](../androidx.work/listenable-worker.md) by passing the enqueued [`ListenableWorker`](../androidx.work/listenable-worker.md) class to the [`WorkerFactory`](../androidx.work/worker-factory.md). Useful for testing custom [`createWorker`](../androidx.work/worker-factory.md#createworker) implementations, as the enqueued class may differ from the one that is built.

### setForegroundUpdater

> Added in 2.3.0
```
fun setForegroundUpdater(updater: ForegroundUpdater): TestListenableWorkerBuilder<W!>
```

Sets the [`ForegroundUpdater`](../androidx.work/foreground-updater.md) used to construct the [`ListenableWorker`](../androidx.work/listenable-worker.md).

### setId

> Added in 2.1.0
```
fun setId(id: UUID): TestListenableWorkerBuilder<W!>
```

Sets the id for this unit of work.

### setInputData

> Added in 2.1.0
```
fun setInputData(inputData: Data): TestListenableWorkerBuilder<W!>
```

Adds input [`Data`](../androidx.work/data.md) — the key/value pairs that will be provided to the worker.

### setNetwork

> Added in 2.1.0
```
@RequiresApi(value = 28)
fun setNetwork(network: Network): TestListenableWorkerBuilder<W!>
```

Sets the `Network` associated with this unit of work.

### setProgressUpdater

> Added in 2.3.0
```
fun setProgressUpdater(updater: ProgressUpdater): TestListenableWorkerBuilder<W!>
```

Sets the [`ProgressUpdater`](../androidx.work/progress-updater.md) used to construct the [`ListenableWorker`](../androidx.work/listenable-worker.md).

### setRunAttemptCount

> Added in 2.1.0
```
fun setRunAttemptCount(runAttemptCount: Int): TestListenableWorkerBuilder<W!>
```

Sets the initial run attempt count for this work.

### setTags

> Added in 2.1.0
```
fun setTags(tags: (Mutable)List<String!>): TestListenableWorkerBuilder<W!>
```

Sets the tags associated with this unit of work.

### setTriggeredContentAuthorities

> Added in 2.1.0
```
@RequiresApi(value = 24)
fun setTriggeredContentAuthorities(
    authorities: (Mutable)List<String!>
): TestListenableWorkerBuilder<W!>
```

Sets the authorities for content `Uri`s associated with this unit of work.

### setTriggeredContentUris

> Added in 2.1.0
```
@RequiresApi(value = 24)
fun setTriggeredContentUris(contentUris: (Mutable)List<Uri!>): TestListenableWorkerBuilder<W!>
```

Sets the list of content `Uri`s associated with this unit of work.

### setWorkerFactory

> Added in 2.1.0
```
fun setWorkerFactory(workerFactory: WorkerFactory): TestListenableWorkerBuilder<W!>
```

Sets the [`WorkerFactory`](../androidx.work/worker-factory.md) used to construct the [`ListenableWorker`](../androidx.work/listenable-worker.md).

## Extension Functions

The top-level [`TestListenableWorkerBuilder`](package-functions.md#testlistenableworkerbuilder) function offers a Kotlin-friendly way to create a builder with default arguments.
