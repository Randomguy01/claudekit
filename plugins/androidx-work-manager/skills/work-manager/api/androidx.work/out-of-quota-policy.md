# API Reference

> Last updated 2026-06-10

# OutOfQuotaPolicy

> Added in 2.7.0

```
enum OutOfQuotaPolicy : Enum
```

An enumeration of policies that help determine out-of-quota behavior for expedited jobs.

## Enum Values

### DROP_WORK_REQUEST

```
val OutOfQuotaPolicy.DROP_WORK_REQUEST: OutOfQuotaPolicy
```

When the app does not have any expedited job quota, the expedited work request will be dropped and no work requests are enqueued.

### RUN_AS_NON_EXPEDITED_WORK_REQUEST

```
val OutOfQuotaPolicy.RUN_AS_NON_EXPEDITED_WORK_REQUEST: OutOfQuotaPolicy
```

When the app does not have any expedited job quota, the expedited work request will fall back to a regular work request.

## Public Functions

### valueOf

> Added in 2.7.0
```
fun valueOf(value: String): OutOfQuotaPolicy
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.7.0
```
fun values(): Array<OutOfQuotaPolicy>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<OutOfQuotaPolicy>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
