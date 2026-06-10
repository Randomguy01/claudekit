# API Reference

> Last updated 2026-06-10

# WorkManagerTestInitHelper.ExecutorsMode

> Added in 2.9.0

```
enum WorkManagerTestInitHelper.ExecutorsMode : Enum
```

Modes that control which executors are used in tests. Passed to [`WorkManagerTestInitHelper.initializeTestWorkManager`](work-manager-test-init-helper.md#initializetestworkmanager).

## Enum Values

### LEGACY_OVERRIDE_WITH_SYNCHRONOUS_EXECUTORS

```
val WorkManagerTestInitHelper.ExecutorsMode.LEGACY_OVERRIDE_WITH_SYNCHRONOUS_EXECUTORS: WorkManagerTestInitHelper.ExecutorsMode
```

Preserves the old behavior of the two-argument and one-argument [`initializeTestWorkManager`](work-manager-test-init-helper.md#initializetestworkmanager) overloads. In this mode [`SynchronousExecutor`](synchronous-executor.md) is used instead of the main thread, and also as the [`taskExecutor`](../androidx.work/configuration.md#taskexecutor) — unless the task executor was explicitly set in the `configuration` passed in.

### PRESERVE_EXECUTORS

```
val WorkManagerTestInitHelper.ExecutorsMode.PRESERVE_EXECUTORS: WorkManagerTestInitHelper.ExecutorsMode
```

Uses executors as they are configured in the passed [`Configuration`](../androidx.work/configuration.md), preserving the real main thread.

### USE_TIME_BASED_SCHEDULING

```
val WorkManagerTestInitHelper.ExecutorsMode.USE_TIME_BASED_SCHEDULING: WorkManagerTestInitHelper.ExecutorsMode
```

Like [`PRESERVE_EXECUTORS`](#preserve_executors), but uses the real `Clock` and `RunnableScheduler` in the provided [`Configuration`](../androidx.work/configuration.md) instead of the [`TestDriver`](test-driver.md) `setDelayMet()` methods to run scheduled work. Work is passed to the `RunnableScheduler` with an appropriate time-based delay, and the scheduler must reschedule the work itself once the clock delay has passed. [`setInitialDelayMet`](test-driver.md#setinitialdelaymet) and [`setPeriodDelayMet`](test-driver.md#setperioddelaymet) throw exceptions in this mode.

This mode is intended for integrated fake-clock / scheduling test frameworks, e.g. `kotlinx.coroutines.test.StandardTestDispatcherImpl` with `kotlinx.coroutines.test.TestCoroutineScheduler`.

## Public Functions

### valueOf

> Added in 2.9.0
```
java-static fun valueOf(name: String): WorkManagerTestInitHelper.ExecutorsMode
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.9.0
```
java-static fun values(): Array<WorkManagerTestInitHelper.ExecutorsMode>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<WorkManagerTestInitHelper.ExecutorsMode>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
