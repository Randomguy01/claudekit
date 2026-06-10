# API Reference

> Last updated 2026-06-10

# WorkManager.UpdateResult

> Added in 2.8.0

```
enum WorkManager.UpdateResult : Enum
```

An enumeration of results for the [`WorkManager.updateWork`](work-manager.md#updatework) method.

## Enum Values

### APPLIED_FOR_NEXT_RUN

```
val WorkManager.UpdateResult.APPLIED_FOR_NEXT_RUN: WorkManager.UpdateResult
```

An update was successfully applied, but the worker being updated was running. That run isn't interrupted and continues to rely on the previous state of the request (old constraints, tags, etc.). However, on the next run — e.g. a retry of a one-time worker or another iteration of a periodic worker — the new worker specification will be used.

### APPLIED_IMMEDIATELY

```
val WorkManager.UpdateResult.APPLIED_IMMEDIATELY: WorkManager.UpdateResult
```

An update was successfully applied immediately, meaning the updated work wasn't currently running at the moment of the request. See [`APPLIED_FOR_NEXT_RUN`](#applied_for_next_run) for the case of a running worker.

### NOT_APPLIED

```
val WorkManager.UpdateResult.NOT_APPLIED: WorkManager.UpdateResult
```

An update wasn't applied because the `Worker` has already finished.

## Public Functions

### valueOf

> Added in 2.8.0
```
fun valueOf(value: String): WorkManager.UpdateResult
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.8.0
```
fun values(): Array<WorkManager.UpdateResult>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<WorkManager.UpdateResult>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
