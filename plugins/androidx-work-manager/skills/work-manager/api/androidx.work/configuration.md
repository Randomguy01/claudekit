# API Reference

> Last updated 2026-06-10

# Configuration

> Added in 1.0.0

```
class Configuration
```

The configuration object used to customize [`WorkManager`](work-manager.md) upon initialization. Contains the parameters used to set up WorkManager — for example, the `Executor` used by [`Worker`](worker.md)s. To install a custom configuration, see [`WorkManager.initialize`](work-manager.md#initialize) or [`Configuration.Provider`](configuration-provider.md).

## Nested Types

| Type | Description |
|------|-------------|
| [`Configuration.Builder`](configuration-builder.md) | A builder for `Configuration`s. |
| [`Configuration.Provider`](configuration-provider.md) | Provides the `Configuration` for on-demand WorkManager initialization. |

## Constants

### MIN_SCHEDULER_LIMIT

```
const val MIN_SCHEDULER_LIMIT = 20: Int
```

The minimum number of system requests that can be enqueued by WorkManager when using `JobScheduler` or `AlarmManager`.

## Public Functions

### isMarkingJobsAsImportantWhileForeground

> Added in 2.10.0
```
@ExperimentalConfigurationApi
fun isMarkingJobsAsImportantWhileForeground(): Boolean
```

Whether WorkManager automatically sets `JobInfo.Builder.setImportantWhileForeground` for workers eligible to run immediately. Requires opt-in via [`ExperimentalConfigurationApi`](experimental-configuration-api.md).

## Public Properties

### clock

> Added in 2.9.0
```
val clock: Clock
```

The [`Clock`](clock.md) used by WorkManager to calculate schedules and perform book-keeping.

### contentUriTriggerWorkersLimit

> Added in 2.9.0
```
val contentUriTriggerWorkersLimit: Int
```

Maximum number of workers with [content uri triggers](constraints.md#contenturitriggers) that can be enqueued simultaneously. These workers must immediately occupy slots in JobScheduler to avoid missing updates, so they have their own category.

### defaultProcessName

> Added in 2.5.0
```
val defaultProcessName: String?
```

The name of the process where work should be scheduled.

### executor

> Added in 1.0.0
```
val executor: Executor
```

The `Executor` used by WorkManager to execute [`Worker`](worker.md)s.

### initializationExceptionHandler

> Added in 2.8.0
```
val initializationExceptionHandler: Consumer<Throwable>?
```

The handler used to intercept exceptions caused when trying to initialize WorkManager.

### inputMergerFactory

> Added in 2.3.0
```
val inputMergerFactory: InputMergerFactory
```

The [`InputMergerFactory`](input-merger-factory.md) used to create [`InputMerger`](input-merger.md) instances.

### maxJobSchedulerId

> Added in 1.0.0
```
val maxJobSchedulerId: Int
```

The last valid id (inclusive) used when creating new `JobInfo`s. If the current `jobId` goes beyond the range (`minJobSchedulerId`, `maxJobSchedulerId`), it resets to `minJobSchedulerId`.

### minJobSchedulerId

> Added in 1.0.0
```
val minJobSchedulerId: Int
```

The first valid id (inclusive) used when creating new `JobInfo`s.

### remoteSessionTimeoutMillis

> Added in 2.11.2
```
val remoteSessionTimeoutMillis: @IntRange(from = 0, to = 1200000) Long
```

The time in milliseconds the designated process stays active before unbinding when using `RemoteWorkManager`.

### runnableScheduler

> Added in 2.4.0
```
val runnableScheduler: RunnableScheduler
```

The [`RunnableScheduler`](runnable-scheduler.md) used to keep track of timed work in the in-process scheduler.

### schedulingExceptionHandler

> Added in 2.8.0
```
val schedulingExceptionHandler: Consumer<Throwable>?
```

The handler used to intercept exceptions caused when trying to schedule [`WorkRequest`](work-request.md)s.

### taskExecutor

> Added in 2.1.0
```
val taskExecutor: Executor
```

The `Executor` used by WorkManager for all its internal business logic.

### workerCoroutineContext

> Added in 2.10.0
```
val workerCoroutineContext: CoroutineContext
```

The `CoroutineContext` used by WorkManager to execute [`CoroutineWorker`](coroutine-worker.md)s.

### workerExecutionExceptionHandler

> Added in 2.10.0
```
val workerExecutionExceptionHandler: Consumer<WorkerExceptionInfo>?
```

The handler used to intercept exceptions caused when trying to execute [`ListenableWorker`](listenable-worker.md)s.

### workerFactory

> Added in 1.0.0
```
val workerFactory: WorkerFactory
```

The [`WorkerFactory`](worker-factory.md) used to create [`ListenableWorker`](listenable-worker.md)s.

### workerInitializationExceptionHandler

> Added in 2.10.0
```
val workerInitializationExceptionHandler: Consumer<WorkerExceptionInfo>?
```

The handler used to intercept exceptions caused when trying to initialize [`ListenableWorker`](listenable-worker.md)s.
