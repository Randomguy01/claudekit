# API Reference

> Last updated 2026-06-10

# WorkManagerTestInitHelper

> Added in 1.0.0

```
class WorkManagerTestInitHelper
```

Helps initialize [`WorkManager`](../androidx.work/work-manager.md) for testing. After initializing, use [`getTestDriver`](#gettestdriver) to drive constraints and timing-related triggers for your background work.

## Nested Types

| Type | Summary |
|---|---|
| [`WorkManagerTestInitHelper.ExecutorsMode`](work-manager-test-init-helper-executors-mode.md) | Modes that control which executors are used in tests. |

## Public Functions

### closeWorkDatabase

> Added in 2.9.0
```
java-static fun closeWorkDatabase(): Unit
```

Closes [`WorkManager`](../androidx.work/work-manager.md)'s internal database. Helpful to avoid `CloseGuard` warnings in test infra. Make sure `WorkManager` has finished all operations and won't touch the database anymore — that is, both [`taskExecutor`](../androidx.work/configuration.md#taskexecutor) and [`executor`](../androidx.work/configuration.md#executor) are idle.

Don't call this from the [`taskExecutor`](../androidx.work/configuration.md#taskexecutor): the method blocks until all internal work completes after cancellation, and blocking the task executor may lead to deadlocks.

### getTestDriver

> Added in 1.0.0
>
> Deprecated in 2.1.0
```
java-static fun getTestDriver(): TestDriver?
```

**Deprecated.** Call [`getTestDriver(context)`](#gettestdriver) instead.

Returns an instance of [`TestDriver`](test-driver.md), which exposes additional functionality useful when testing with WorkManager.

### getTestDriver

> Added in 2.1.0
```
java-static fun getTestDriver(context: Context): TestDriver?
```

Returns an instance of [`TestDriver`](test-driver.md), which exposes additional functionality useful when testing with WorkManager.

### initializeTestWorkManager

> Added in 1.0.0
```
java-static fun initializeTestWorkManager(context: Context): Unit
```

Initializes a test [`WorkManager`](../androidx.work/work-manager.md) with a [`SynchronousExecutor`](synchronous-executor.md). `context` is the application `Context`.

### initializeTestWorkManager

> Added in 1.0.0
```
java-static fun initializeTestWorkManager(
    context: Context,
    configuration: Configuration
): Unit
```

Initializes a test [`WorkManager`](../androidx.work/work-manager.md) with a user-specified [`Configuration`](../androidx.work/configuration.md), but using [`SynchronousExecutor`](synchronous-executor.md) instead of the main thread.

### initializeTestWorkManager

> Added in 2.9.0
```
java-static fun initializeTestWorkManager(
    context: Context,
    executorsMode: WorkManagerTestInitHelper.ExecutorsMode
): Unit
```

Initializes a test [`WorkManager`](../androidx.work/work-manager.md) that can be controlled via [`TestDriver`](test-driver.md). `executorsMode` controls which executors WorkManager uses in tests — see [`ExecutorsMode`](work-manager-test-init-helper-executors-mode.md).

### initializeTestWorkManager

> Added in 2.9.0
```
java-static fun initializeTestWorkManager(
    context: Context,
    configuration: Configuration,
    executorsMode: WorkManagerTestInitHelper.ExecutorsMode
): Unit
```

Initializes a test [`WorkManager`](../androidx.work/work-manager.md) that can be controlled via [`TestDriver`](test-driver.md), with the given test [`Configuration`](../androidx.work/configuration.md). `executorsMode` controls which executors WorkManager uses in tests — see [`ExecutorsMode`](work-manager-test-init-helper-executors-mode.md).
