# API Reference

> Last updated 2026-06-10

# WorkInfo

> Added in 1.0.0

```
class WorkInfo
```

Information about a particular [`WorkRequest`](work-request.md): its id, current [`State`](work-info-state.md), output, tags, and run attempt count.

> [!NOTE]
> Output is only available in the terminal states [`SUCCEEDED`](work-info-state.md#succeeded) and [`FAILED`](work-info-state.md#failed); otherwise it is [`Data.EMPTY`](data.md#empty).

## Nested Types

| Type | Description |
|------|-------------|
| [`WorkInfo.State`](work-info-state.md) | The current lifecycle state of a `WorkRequest`. |
| [`WorkInfo.PeriodicityInfo`](work-info-periodicity-info.md) | A periodic work's interval and flex duration. |

## Constants

The `STOP_REASON_*` constants mirror the `JobParameters.STOP_REASON_*` values and are returned by [`stopReason`](#stopreason):

| Constant | Value | Meaning |
|----------|-------|---------|
| `STOP_REASON_NOT_STOPPED` | — | The worker wasn't stopped (e.g. just enqueued, or returned `retry()`). |
| `STOP_REASON_UNKNOWN` | — | Stopped for an unknown reason (e.g. crash or sudden battery loss). |
| `STOP_REASON_CANCELLED_BY_APP` | 1 | Cancelled directly by the app. |
| `STOP_REASON_PREEMPT` | 2 | Stopped to run a higher-priority job of the app. |
| `STOP_REASON_TIMEOUT` | 3 | Used up its maximum execution time. |
| `STOP_REASON_DEVICE_STATE` | 4 | Device state (Doze, battery saver, etc.) requires stopping. |
| `STOP_REASON_CONSTRAINT_BATTERY_NOT_LOW` | 5 | Battery-not-low constraint no longer satisfied. |
| `STOP_REASON_CONSTRAINT_CHARGING` | 6 | Charging constraint no longer satisfied. |
| `STOP_REASON_CONSTRAINT_CONNECTIVITY` | 7 | Connectivity constraint no longer satisfied. |
| `STOP_REASON_CONSTRAINT_DEVICE_IDLE` | 8 | Idle constraint no longer satisfied. |
| `STOP_REASON_CONSTRAINT_STORAGE_NOT_LOW` | 9 | Storage-not-low constraint no longer satisfied. |
| `STOP_REASON_QUOTA` | 10 | The app consumed all of its current quota. |
| `STOP_REASON_BACKGROUND_RESTRICTION` | 11 | The app is restricted from running in the background. |
| `STOP_REASON_APP_STANDBY` | 12 | The current standby bucket requires stopping. |
| `STOP_REASON_USER` | 13 | The user stopped the job. |
| `STOP_REASON_SYSTEM_PROCESSING` | 14 | The system needs to stop this job to do processing. |
| `STOP_REASON_ESTIMATED_APP_LAUNCH_TIME_CHANGED` | 15 | The estimated app-launch time changed significantly. |
| `STOP_REASON_FOREGROUND_SERVICE_TIMEOUT` | — | The foreground worker used up its maximum execution time. |

## Public Constructors

### WorkInfo

> Added in 2.9.0
```
WorkInfo(
    id: UUID,
    state: WorkInfo.State,
    tags: Set<String>,
    outputData: Data = Data.EMPTY,
    progress: Data = Data.EMPTY,
    runAttemptCount: Int = 0,
    generation: Int = 0,
    constraints: Constraints = Constraints.NONE,
    initialDelayMillis: Long = 0,
    periodicityInfo: WorkInfo.PeriodicityInfo? = null,
    nextScheduleTimeMillis: Long = Long.MAX_VALUE,
    stopReason: Int = STOP_REASON_NOT_STOPPED
)
```

## Public Properties

### constraints

> Added in 2.9.0
```
val constraints: Constraints
```

The [`Constraints`](constraints.md) of this worker.

### generation

> Added in 2.8.0
```
val generation: Int
```

The latest generation of this worker (incremented when updated via [`WorkManager.updateWork`](work-manager.md#updatework) or an [`UPDATE`](existing-periodic-work-policy.md#update) periodic enqueue).

### id

> Added in 1.0.0
```
val id: UUID
```

The identifier of the [`WorkRequest`](work-request.md).

### initialDelayMillis

> Added in 2.9.0
```
val initialDelayMillis: Long
```

The initial delay for this work set in the [`WorkRequest`](work-request.md).

### nextScheduleTimeMillis

> Added in 2.9.0
```
val nextScheduleTimeMillis: Long
```

The earliest time this work is eligible to run next, if it is [`ENQUEUED`](work-info-state.md#enqueued). Defaults to `Long.MAX_VALUE` for all other states. Intended for scheduling tests or inspection — actual run times depend on the system scheduler, Doze, power-saving modes, and constraints.

### outputData

> Added in 1.0.0
```
val outputData: Data
```

The output [`Data`](data.md) for the [`WorkRequest`](work-request.md). Always [`Data.EMPTY`](data.md#empty) while unfinished.

### periodicityInfo

> Added in 2.9.0
```
val periodicityInfo: WorkInfo.PeriodicityInfo?
```

For periodic work, the period and flex duration set in the [`PeriodicWorkRequest`](periodic-work-request.md); `null` for one-time work.

### progress

> Added in 2.3.0
```
val progress: Data
```

The progress [`Data`](data.md) associated with the [`WorkRequest`](work-request.md).

### runAttemptCount

> Added in 2.1.0
```
val runAttemptCount: Int
```

The run attempt count of the [`WorkRequest`](work-request.md). Resets between successful runs for periodic work.

### state

> Added in 1.0.0
```
val state: WorkInfo.State
```

The current [`State`](work-info-state.md) of the [`WorkRequest`](work-request.md).

### stopReason

> Added in 2.9.0
```
val stopReason: Int
```

The reason this worker was stopped on the previous run attempt (one of the `STOP_REASON_*` constants). Returns `STOP_REASON_NOT_STOPPED` when the worker wasn't stopped, including when it returned `retry()`.

### tags

> Added in 1.0.0
```
val tags: Set<String>
```

The set of tags associated with the [`WorkRequest`](work-request.md).
