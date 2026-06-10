# API Reference

> Last updated 2026-06-10

# ExistingWorkPolicy

> Added in 1.0.0

```
enum ExistingWorkPolicy : Enum
```

An enumeration of the conflict resolution policies available to unique [`OneTimeWorkRequest`](one-time-work-request.md)s in case of a collision.

## Enum Values

### APPEND

```
val ExistingWorkPolicy.APPEND: ExistingWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, append the newly-specified work as a child of all the leaves of that work sequence. Otherwise, insert the newly-specified work as the start of a new sequence.

> [!NOTE]
> When using `APPEND` with failed or cancelled prerequisites, newly enqueued work will also be marked as failed or cancelled respectively. Use [`APPEND_OR_REPLACE`](#append_or_replace) to create a new chain of work.

### APPEND_OR_REPLACE

```
val ExistingWorkPolicy.APPEND_OR_REPLACE: ExistingWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, append the newly-specified work as the child of all the leaves of that work sequence. Otherwise, insert the newly-specified work as the start of a new sequence.

> [!NOTE]
> If there are failed or cancelled prerequisites, these prerequisites are *dropped* and the newly-specified work is the start of a new sequence.

### KEEP

```
val ExistingWorkPolicy.KEEP: ExistingWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, do nothing. Otherwise, insert the newly-specified work.

### REPLACE

```
val ExistingWorkPolicy.REPLACE: ExistingWorkPolicy
```

If there is existing pending (uncompleted) work with the same unique name, cancel and delete it. Then, insert the newly-specified work.

## Public Functions

### valueOf

> Added in 1.0.0
```
fun valueOf(value: String): ExistingWorkPolicy
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 1.0.0
```
fun values(): Array<ExistingWorkPolicy>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<ExistingWorkPolicy>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
