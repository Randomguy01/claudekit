# API Reference

> Last updated 2026-06-08

# Index.Order

> Added in 2.4.0

```
enum Index.Order : Enum
```

Sort order for a column in an [`@Index`](index.md). See [`Index.orders`](index.md#orders).

## Enum Values

### ASC

```
val Index.Order.ASC: Index.Order
```

Ascending returning order.

### DESC

```
val Index.Order.DESC: Index.Order
```

Descending returning order.

## Public Functions

### valueOf

> Added in 2.4.0
```
fun valueOf(value: String): Index.Order
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.4.0
```
fun values(): Array<Index.Order>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<Index.Order>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
