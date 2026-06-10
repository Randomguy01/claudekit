# API Reference

> Last updated 2026-06-10

# BackoffPolicy

> Added in 1.0.0

```
enum BackoffPolicy : Enum
```

An enumeration of backoff policies when retrying work. These policies are used when a worker returns [`ListenableWorker.Result.retry`](listenable-worker-result.md#retry) to determine the correct backoff time. Backoff policies are set in [`WorkRequest.Builder.setBackoffCriteria`](work-request-builder.md#setbackoffcriteria) or one of its variants.

## Enum Values

### EXPONENTIAL

```
val BackoffPolicy.EXPONENTIAL: BackoffPolicy
```

Used to indicate that [`WorkManager`](work-manager.md) should increase the backoff time exponentially.

### LINEAR

```
val BackoffPolicy.LINEAR: BackoffPolicy
```

Used to indicate that [`WorkManager`](work-manager.md) should increase the backoff time linearly.

## Public Functions

### valueOf

> Added in 1.0.0
```
fun valueOf(value: String): BackoffPolicy
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 1.0.0
```
fun values(): Array<BackoffPolicy>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<BackoffPolicy>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
