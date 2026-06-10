# API Reference

> Last updated 2026-06-10

# Configuration.Builder

> Added in 1.0.0

```
class Configuration.Builder
```

A builder for [`Configuration`](configuration.md)s. Each setter returns the builder for chaining.

## Public Constructors

### Builder

> Added in 1.0.0
```
Builder()
```

Creates a new `Configuration.Builder`.

## Public Functions

### build

> Added in 1.0.0
```
fun build(): Configuration
```

Builds a [`Configuration`](configuration.md) object.

### setClock

> Added in 2.9.0
```
fun setClock(clock: Clock): Configuration.Builder
```

Sets a [`Clock`](clock.md) for WorkManager to calculate schedules and perform book-keeping. Override only for testing; in production it must return the same value as `System.currentTimeMillis()`.

### setContentUriTriggerWorkersLimit

> Added in 2.9.0
```
fun setContentUriTriggerWorkersLimit(contentUriTriggerWorkersLimit: Int): Configuration.Builder
```

Specifies the maximum number of workers with [content uri triggers](constraints.md#contenturitriggers) that can be enqueued simultaneously.

### setDefaultProcessName

> Added in 2.5.0
```
fun setDefaultProcessName(processName: String): Configuration.Builder
```

Designates the primary process that [`WorkManager`](work-manager.md) should schedule work in.

### setExecutor

> Added in 1.0.0
```
fun setExecutor(executor: Executor): Configuration.Builder
```

Specifies a custom `Executor` to run [`Worker.doWork`](worker.md#dowork). If [`setWorkerCoroutineContext`](#setworkercoroutinecontext) wasn't called, this executor is also used as the `CoroutineDispatcher` for [`CoroutineWorker`](coroutine-worker.md)s.

### setInitializationExceptionHandler

> Added in 2.8.0
```
fun setInitializationExceptionHandler(
    exceptionHandler: Consumer<Throwable>
): Configuration.Builder
```

Specifies a handler to intercept exceptions caused when trying to initialize WorkManager — usually when WorkManager cannot access its internal datastore. Invoked on a thread bound to [`Configuration.taskExecutor`](configuration.md#taskexecutor).

### setInputMergerFactory

> Added in 2.3.0
```
fun setInputMergerFactory(inputMergerFactory: InputMergerFactory): Configuration.Builder
```

Specifies a custom [`InputMergerFactory`](input-merger-factory.md).

### setJobSchedulerJobIdRange

> Added in 1.0.0
```
fun setJobSchedulerJobIdRange(minJobSchedulerId: Int, maxJobSchedulerId: Int): Configuration.Builder
```

Specifies the range of `JobInfo` IDs that WorkManager can use (it needs a range of at least `1000`). Use this to avoid clashing with job codes used elsewhere in your app. Defaults are `0` and `Integer.MAX_VALUE`.

### setMarkingJobsAsImportantWhileForeground

> Added in 2.10.0
```
@ExperimentalConfigurationApi
fun setMarkingJobsAsImportantWhileForeground(markAsImportant: Boolean): Configuration.Builder
```

Regulates whether WorkManager automatically sets `JobInfo.Builder.setImportantWhileForeground` for workers eligible to run immediately (effective only on API levels >= 23). Requires opt-in via [`ExperimentalConfigurationApi`](experimental-configuration-api.md).

### setMaxSchedulerLimit

> Added in 1.0.0
```
fun setMaxSchedulerLimit(maxSchedulerLimit: Int): Configuration.Builder
```

Specifies the maximum number of system requests made by WorkManager when using `JobScheduler` or `AlarmManager`. Useful when your app also uses those APIs directly and risks exhausting the OS limit. When exceeded, WorkManager queues [`WorkRequest`](work-request.md)s internally and schedules them as slots free up. Requires at least [`MIN_SCHEDULER_LIMIT`](configuration.md#min_scheduler_limit) slots (also the default); the total cannot exceed `50`.

### setMinimumLoggingLevel

> Added in 1.0.0
```
fun setMinimumLoggingLevel(loggingLevel: Int): Configuration.Builder
```

Specifies the minimum logging level using the `Log` constants — e.g. `Log.VERBOSE` logs everything, `Log.ERROR` only errors and assertions. The default is `Log.INFO`.

### setRemoteSessionTimeoutMillis

> Added in 2.11.0
```
fun setRemoteSessionTimeoutMillis(
    timeoutMillis: @IntRange(from = 0, to = 1200000) Long
): Configuration.Builder
```

Sets how long a `RemoteWorkManager` binding to the designated process stays active before timing out and unbinding. A timeout of `0` unbinds immediately after each call.

### setRunnableScheduler

> Added in 2.4.0
```
fun setRunnableScheduler(runnableScheduler: RunnableScheduler): Configuration.Builder
```

Specifies the [`RunnableScheduler`](runnable-scheduler.md) used by the in-process scheduler to track timed work.

### setSchedulingExceptionHandler

> Added in 2.8.0
```
fun setSchedulingExceptionHandler(
    schedulingExceptionHandler: Consumer<Throwable>
): Configuration.Builder
```

Specifies a handler to intercept exceptions caused when trying to schedule [`WorkRequest`](work-request.md)s. Invoked on a thread bound to [`Configuration.taskExecutor`](configuration.md#taskexecutor).

### setTaskExecutor

> Added in 2.1.0
```
fun setTaskExecutor(taskExecutor: Executor): Configuration.Builder
```

Specifies an `Executor` used by WorkManager for all its internal book-keeping. For best performance this executor should be bounded.

### setWorkerCoroutineContext

> Added in 2.10.0
```
fun setWorkerCoroutineContext(context: CoroutineContext): Configuration.Builder
```

Specifies a custom `CoroutineContext` to run [`CoroutineWorker.doWork`](coroutine-worker.md#dowork); WorkManager uses its own `Job` with the provided context. If [`setExecutor`](#setexecutor) wasn't called, this context is also used as the `Executor` to run [`Worker`](worker.md)s.

### setWorkerExecutionExceptionHandler

> Added in 2.10.0
```
fun setWorkerExecutionExceptionHandler(
    workerExceptionHandler: Consumer<WorkerExceptionInfo>
): Configuration.Builder
```

Specifies a handler to intercept exceptions caused when trying to execute [`ListenableWorker`](listenable-worker.md)s. Receives a [`WorkerExceptionInfo`](worker-exception-info.md); invoked on a thread bound to [`Configuration.taskExecutor`](configuration.md#taskexecutor).

### setWorkerFactory

> Added in 1.0.0
```
fun setWorkerFactory(workerFactory: WorkerFactory): Configuration.Builder
```

Specifies a custom [`WorkerFactory`](worker-factory.md).

### setWorkerInitializationExceptionHandler

> Added in 2.10.0
```
fun setWorkerInitializationExceptionHandler(
    workerExceptionHandler: Consumer<WorkerExceptionInfo>
): Configuration.Builder
```

Specifies a handler to intercept exceptions caused when trying to initialize [`ListenableWorker`](listenable-worker.md)s. Receives a [`WorkerExceptionInfo`](worker-exception-info.md); invoked on a thread bound to [`Configuration.taskExecutor`](configuration.md#taskexecutor).
