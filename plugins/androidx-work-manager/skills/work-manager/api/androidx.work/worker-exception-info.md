# API Reference

> Last updated 2026-06-10

# WorkerExceptionInfo

> Added in 2.10.0

```
class WorkerExceptionInfo
```

Represents exceptions that occurred while initializing or executing a [`ListenableWorker`](listenable-worker.md). Passed to the handler registered with [`Configuration.Builder.setWorkerInitializationExceptionHandler`](configuration-builder.md#setworkerinitializationexceptionhandler) / `setWorkerExecutionExceptionHandler`.

## Public Constructors

### WorkerExceptionInfo

> Added in 2.10.0
```
WorkerExceptionInfo(
    workerClassName: String,
    workerParameters: WorkerParameters,
    throwable: Throwable
)
```

## Public Properties

### throwable

> Added in 2.10.0
```
val throwable: Throwable
```

The `Throwable` thrown while initializing or executing a [`ListenableWorker`](listenable-worker.md).

### workerClassName

> Added in 2.10.0
```
val workerClassName: String
```

The class name of the worker.

### workerParameters

> Added in 2.10.0
```
val workerParameters: WorkerParameters
```

[`WorkerParameters`](worker-parameters.md) for worker initialization.
