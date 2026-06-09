# API Reference

> Last updated 2026-06-08

# FtsOptions.Order

> Added in 2.1.0

```
enum FtsOptions.Order : Enum
```

The preferred `rowid` order of an FTS table. See [`Fts4.order`](fts4.md#order).

## Enum Values

### ASC

```
val FtsOptions.Order.ASC: FtsOptions.Order
```

Ascending returning order.

### DESC

```
val FtsOptions.Order.DESC: FtsOptions.Order
```

Descending returning order.

## Public Functions

### valueOf

> Added in 2.1.0
```
fun valueOf(value: String): FtsOptions.Order
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.1.0
```
fun values(): Array<FtsOptions.Order>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<FtsOptions.Order>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
