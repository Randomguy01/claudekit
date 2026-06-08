# API Reference

> Last updated 2026-06-08

# BuiltInTypeConverters.State

> Added in 2.4.0

```
enum BuiltInTypeConverters.State : Enum
```

Control flags for built-in converters. Used by the [`@BuiltInTypeConverters`](built-in-type-converters.md) flags.

## Enum Values

### DISABLED

```
val BuiltInTypeConverters.State.DISABLED: BuiltInTypeConverters.State
```

Room cannot use the built-in converter.

### ENABLED

```
val BuiltInTypeConverters.State.ENABLED: BuiltInTypeConverters.State
```

Room can use the built-in converter.

### INHERITED

```
val BuiltInTypeConverters.State.INHERITED: BuiltInTypeConverters.State
```

The value is inherited from the higher scope. See the [`@TypeConverters`](type-converters.md) documentation to learn more about `@TypeConverters` scoping. If this value is never set, it defaults to [`ENABLED`](#enabled).

## Public Functions

### valueOf

> Added in 2.4.0
```
fun valueOf(value: String): BuiltInTypeConverters.State
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.4.0
```
fun values(): Array<BuiltInTypeConverters.State>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<BuiltInTypeConverters.State>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
