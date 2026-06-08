# API Reference

> Last updated 2026-06-08

# Transactor.SQLiteTransactionType

> Added in 2.7.0

```
enum Transactor.SQLiteTransactionType : Enum
```

Transaction types.

|             See also              |
| --------------------------------- |
| [`Transactor.withTransaction`](transactor.md#withtransaction) |

## Enum Values

### DEFERRED

```
val Transactor.SQLiteTransactionType.DEFERRED: Transactor.SQLiteTransactionType
```

The transaction mode that does not start the actual transaction until the database is accessed, be it a read or a write.

### EXCLUSIVE

```
val Transactor.SQLiteTransactionType.EXCLUSIVE: Transactor.SQLiteTransactionType
```

The transaction mode that immediately starts a write transaction and locks the database, preventing others from accessing it.

### IMMEDIATE

```
val Transactor.SQLiteTransactionType.IMMEDIATE: Transactor.SQLiteTransactionType
```

The transaction mode that immediately starts a write transaction.

## Public Functions

### valueOf

> Added in 2.7.0
```
fun valueOf(value: String): Transactor.SQLiteTransactionType
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.7.0
```
fun values(): Array<Transactor.SQLiteTransactionType>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<Transactor.SQLiteTransactionType>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
