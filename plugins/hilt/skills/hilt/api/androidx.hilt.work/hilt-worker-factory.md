# API Reference

> Last updated 2026-06-11

# HiltWorkerFactory

> Added in 1.0.0

```kotlin
class HiltWorkerFactory : WorkerFactory
```

Worker factory for the Hilt extension. Artifact: `androidx.hilt:hilt-work`.

A provider for this factory is installed in the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md). Inject it into your `Configuration.Provider` and set it via `Configuration.Builder.setWorkerFactory` so `WorkManager` can construct [`@HiltWorker`](hilt-worker.md)-annotated workers. See [`@HiltWorker`](hilt-worker.md) for the full setup.

## Public Functions

### createWorker

> Added in 1.0.0

```kotlin
fun createWorker(
    appContext: Context,
    workerClassName: String,
    workerParameters: WorkerParameters
): ListenableWorker?
```

Creates an instance of the worker named by `workerClassName`, injecting its Hilt-provided dependencies. Returns a newly created `ListenableWorker`, or `null` if this factory cannot create the worker so `WorkManager` can delegate to the default `WorkerFactory`.

- `appContext` — the application context.
- `workerClassName` — the fully qualified class name of the worker to create.
- `workerParameters` — parameters for worker initialization.

The returned worker must be a fresh instance that has not been previously returned or invoked, or `WorkManager` throws `IllegalStateException`.

## Inherited Members

Inherits `createWorkerWithDefaultFallback` from `androidx.work.WorkerFactory`.
