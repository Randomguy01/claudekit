# API Reference

> Last updated 2026-06-10

# TestDriver

> Added in 1.0.0

```
interface TestDriver
```

Additional functionality exposed for [`WorkManager`](../androidx.work/work-manager.md) that is useful in the context of testing. Obtain an instance with [`WorkManagerTestInitHelper.getTestDriver`](work-manager-test-init-helper.md#gettestdriver).

## Public Functions

### setAllConstraintsMet

> Added in 1.0.0
```
fun setAllConstraintsMet(workSpecId: UUID): Unit
```

Tells `TestDriver` to pretend that all constraints on the [`WorkRequest`](../androidx.work/work-request.md) with the given `workSpecId` are met. This may trigger execution of the work. Throws `IllegalArgumentException` if `workSpecId` is not enqueued.

### setInitialDelayMet

> Added in 1.0.0
```
fun setInitialDelayMet(workSpecId: UUID): Unit
```

Tells `TestDriver` to pretend that the initial delay of the [`OneTimeWorkRequest`](../androidx.work/one-time-work-request.md) with the given `workSpecId` is met. This may trigger execution of the work. Throws `IllegalArgumentException` if `workSpecId` is not enqueued.

### setPeriodDelayMet

> Added in 1.0.0
```
fun setPeriodDelayMet(workSpecId: UUID): Unit
```

Tells `TestDriver` to pretend that the period delay on the [`PeriodicWorkRequest`](../androidx.work/periodic-work-request.md) with the given `workSpecId` is met. This may trigger execution of the work. Throws `IllegalArgumentException` if `workSpecId` is not enqueued.

### stopRunningWorkWithReason

> Added in 2.11.2
```
fun stopRunningWorkWithReason(workSpecId: UUID, reason: Int): Unit
```

Tells `TestDriver` to pretend that a running worker should be stopped with the provided `StopReason`.

- `workSpecId` — the [`WorkRequest`](../androidx.work/work-request.md)'s id.
- `reason` — the `StopReason` that will be made available to the worker.
