# API Reference

> Last updated 2026-06-10

# WorkerFactory

> Added in 1.0.0

```
abstract class WorkerFactory
```

A factory object that creates [`ListenableWorker`](listenable-worker.md) instances. The factory is invoked every time a work runs. Override the default implementation by manually initializing [`WorkManager`](work-manager.md) (see [`WorkManager.initialize`](work-manager.md#initialize)) and specifying a new factory in [`Configuration.Builder.setWorkerFactory`](configuration-builder.md#setworkerfactory).

## Known Direct Subtypes

| Type | Description |
|------|-------------|
| [`DelegatingWorkerFactory`](delegating-worker-factory.md) | A factory which delegates to other factories. |

## Public Constructors

### WorkerFactory

> Added in 1.0.0
```
WorkerFactory()
```

## Public Functions

### createWorker

> Added in 1.0.0
```
abstract fun createWorker(
    appContext: Context,
    workerClassName: String,
    workerParameters: WorkerParameters
): ListenableWorker?
```

Override this method to implement your custom worker-creation logic. Use [`Configuration.Builder.setWorkerFactory`](configuration-builder.md#setworkerfactory) to install your custom class.

If the factory is unable to create an instance, return `null` so WorkManager can delegate to the default factory. The returned worker must be a newly-created instance that has not been previously returned or invoked, otherwise WorkManager throws `IllegalStateException`. Throwing an exception here means no worker is created.

- `appContext` — the application context.
- `workerClassName` — the class name of the worker to create.
- `workerParameters` — [`WorkerParameters`](worker-parameters.md) for worker initialization.
