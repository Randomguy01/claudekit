# API Reference

> Last updated 2026-06-10

# WorkInfo.State

> Added in 1.0.0

```
enum WorkInfo.State : Enum
```

The current lifecycle state of a [`WorkRequest`](work-request.md).

## Enum Values

### BLOCKED

```
val WorkInfo.State.BLOCKED: WorkInfo.State
```

Used to indicate that the [`WorkRequest`](work-request.md) is currently blocked because its prerequisites haven't finished successfully.

### CANCELLED

```
val WorkInfo.State.CANCELLED: WorkInfo.State
```

Used to indicate that the [`WorkRequest`](work-request.md) has been cancelled and will not execute. All dependent work will also be marked as `CANCELLED` and will not run.

### ENQUEUED

```
val WorkInfo.State.ENQUEUED: WorkInfo.State
```

Used to indicate that the [`WorkRequest`](work-request.md) is enqueued and eligible to run when its [`Constraints`](constraints.md) are met and resources are available.

### FAILED

```
val WorkInfo.State.FAILED: WorkInfo.State
```

Used to indicate that the [`WorkRequest`](work-request.md) has completed in a failure state. All dependent work will also be marked as `FAILED` and will never run.

### RUNNING

```
val WorkInfo.State.RUNNING: WorkInfo.State
```

Used to indicate that the [`WorkRequest`](work-request.md) is currently being executed.

### SUCCEEDED

```
val WorkInfo.State.SUCCEEDED: WorkInfo.State
```

Used to indicate that the [`WorkRequest`](work-request.md) has completed in a successful state.

> [!NOTE]
> [`PeriodicWorkRequest`](periodic-work-request.md)s never enter this state — they simply go back to `ENQUEUED` and become eligible to run again.

## Public Functions

### valueOf

> Added in 1.0.0
```
fun valueOf(value: String): WorkInfo.State
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 1.0.0
```
fun values(): Array<WorkInfo.State>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<WorkInfo.State>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.

### isFinished

> Added in 1.0.0
```
val isFinished: Boolean
```

Returns `true` if this state is considered finished: `SUCCEEDED`, `FAILED`, or `CANCELLED`.
