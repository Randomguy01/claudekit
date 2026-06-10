# API Reference

> Last updated 2026-06-10

# DelegatingWorkerFactory

> Added in 2.1.0

```
open class DelegatingWorkerFactory : WorkerFactory
```

A [`WorkerFactory`](worker-factory.md) which delegates to other factories. Factories register themselves as delegates and are invoked in order until one returns a non-null [`ListenableWorker`](listenable-worker.md) instance.

## Public Constructors

### DelegatingWorkerFactory

> Added in 2.1.0
```
DelegatingWorkerFactory()
```

## Public Functions

### addFactory

> Added in 2.1.0
```
fun addFactory(workerFactory: WorkerFactory): Unit
```

Adds a [`WorkerFactory`](worker-factory.md) to the list of delegates.

### createWorker

```
final fun createWorker(
    appContext: Context,
    workerClassName: String,
    workerParameters: WorkerParameters
): ListenableWorker?
```

Invokes each registered delegate factory in order, returning the first non-null [`ListenableWorker`](listenable-worker.md), or `null` if none could create the worker (so WorkManager delegates to the default factory).

- `appContext` — the application context.
- `workerClassName` — the class name of the worker to create.
- `workerParameters` — [`WorkerParameters`](worker-parameters.md) for worker initialization.
