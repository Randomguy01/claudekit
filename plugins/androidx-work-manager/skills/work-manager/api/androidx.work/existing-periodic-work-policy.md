# API Reference

> Last updated 2026-06-10

# ExistingPeriodicWorkPolicy

> Added in 1.0.0

```
enum ExistingPeriodicWorkPolicy : Enum
```

An enumeration of the conflict resolution policies available to unique [`PeriodicWorkRequest`](periodic-work-request.md)s in case of a collision.

## Enum Values

### CANCEL_AND_REENQUEUE

```
val ExistingPeriodicWorkPolicy.CANCEL_AND_REENQUEUE: ExistingPeriodicWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, cancel and delete it. Then, insert the newly-specified work.

This is identical to the deprecated `REPLACE`, but for readability it is better to use `CANCEL_AND_REENQUEUE`, because the difference between `REPLACE` and [`UPDATE`](#update) is unclear to a reader.

### KEEP

```
val ExistingPeriodicWorkPolicy.KEEP: ExistingPeriodicWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, do nothing. Otherwise, insert the newly-specified work.

### REPLACE

```
val ExistingPeriodicWorkPolicy.REPLACE: ExistingPeriodicWorkPolicy
```

**Deprecated — use [`CANCEL_AND_REENQUEUE`](#cancel_and_reenqueue) (identical behavior) or [`UPDATE`](#update) instead.**

If there is existing pending (uncompleted) work with the same unique name, cancel and delete it. Then, insert the newly-specified work.

### UPDATE

```
val ExistingPeriodicWorkPolicy.UPDATE: ExistingPeriodicWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, it will be updated with the new specification. Otherwise, new work with the given name will be enqueued.

It preserves enqueue time — e.g. if a work ran 3 hours ago and had an 8-hour period, after the update it is still eligible to run in 5 hours, assuming periodicity wasn't updated.

If the work being updated is currently running, the current run won't be interrupted and will continue to rely on the previous state of the request (old constraints, tags, etc.). However, on the next iteration of the periodic worker, the new worker specification will be used.

If the work was previously cancelled (via [`WorkManager.cancelWorkById`](work-manager.md#cancelworkbyid) or similar), it will be deleted and then the newly-specified work will be enqueued.

## Public Functions

### valueOf

> Added in 1.0.0
```
fun valueOf(value: String): ExistingPeriodicWorkPolicy
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 1.0.0
```
fun values(): Array<ExistingPeriodicWorkPolicy>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<ExistingPeriodicWorkPolicy>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
