# API Reference

> Last updated 2026-06-08

# ForeignKey

> Added in 2.0.0

```
@Target(allowedTargets = [])
@Retention(value = AnnotationRetention.BINARY)
annotation ForeignKey
```

Declares a foreign key on another [`@Entity`](entity.md).

Foreign keys allow you to specify constraints across entities such that SQLite will ensure the relationship is valid when you modify the database.

When a foreign key constraint is specified, SQLite requires the referenced columns to be part of a unique index in the parent table or the primary key of that table. You must create a unique index in the parent entity that covers the referenced columns (Room verifies this at compile time and prints an error if it is missing).

It is also recommended to create an index on the child table to avoid full table scans when the parent table is modified. If a suitable index on the child table is missing, Room prints a [`RoomWarnings.MISSING_INDEX_ON_FOREIGN_KEY_CHILD`](room-warnings.md) warning.

A foreign key constraint can be deferred until the transaction is complete. This is useful if you are doing bulk inserts into the database in a single transaction. By default, foreign key constraints are immediate, but you can change this by setting [`deferred`](#deferred) to `true`. You can also use [`defer_foreign_keys`](https://sqlite.org/pragma.html#pragma_defer_foreign_keys) to defer them depending on your transaction.

Refer to the SQLite [foreign keys](https://sqlite.org/foreignkeys.html) documentation for details.

## Nested Types

| Type |
|------|
| `annotation` [`ForeignKey.Action`](foreign-key-action.md) — constants definition for values that can be used in [`onDelete`](#ondelete) and [`onUpdate`](#onupdate). |

## Constants

### CASCADE

> Added in 2.5.0

```
const val CASCADE = 5: Int
```

Possible value for [`onDelete`](#ondelete) or [`onUpdate`](#onupdate).

A "CASCADE" action propagates the delete or update operation on the parent key to each dependent child key. For an [`onDelete`](#ondelete) action, this means each row in the child entity that was associated with the deleted parent row is also deleted. For an [`onUpdate`](#onupdate) action, it means the values stored in each dependent child key are modified to match the new parent key values.

### NO_ACTION

> Added in 2.5.0

```
const val NO_ACTION = 1: Int
```

Possible value for [`onDelete`](#ondelete) or [`onUpdate`](#onupdate).

When a parent key is modified or deleted from the database, no special action is taken. This means SQLite will not make any effort to fix the constraint failure; instead, it rejects the change.

### RESTRICT

> Added in 2.5.0

```
const val RESTRICT = 2: Int
```

Possible value for [`onDelete`](#ondelete) or [`onUpdate`](#onupdate).

The RESTRICT action means the application is prohibited from deleting (for [`onDelete`](#ondelete)) or modifying (for [`onUpdate`](#onupdate)) a parent key when there exists one or more child keys mapped to it. The difference between the effect of a RESTRICT action and normal foreign key constraint enforcement is that the RESTRICT action processing happens as soon as the property is updated — not at the end of the current statement as it would with an immediate constraint, or at the end of the current transaction as it would with a [`deferred`](#deferred) constraint.

Even if the foreign key constraint it is attached to is [`deferred`](#deferred), configuring a RESTRICT action causes SQLite to return an error immediately if a parent key with dependent child keys is deleted or modified.

### SET_DEFAULT

> Added in 2.5.0

```
const val SET_DEFAULT = 4: Int
```

Possible value for [`onDelete`](#ondelete) or [`onUpdate`](#onupdate).

The "SET DEFAULT" actions are similar to [`SET_NULL`](#set_null), except that each of the child key columns is set to contain the column's default value instead of `NULL`.

### SET_NULL

> Added in 2.5.0

```
const val SET_NULL = 3: Int
```

Possible value for [`onDelete`](#ondelete) or [`onUpdate`](#onupdate).

If the configured action is "SET NULL", then when a parent key is deleted (for [`onDelete`](#ondelete)) or modified (for [`onUpdate`](#onupdate)), the child key columns of all rows in the child table that mapped to the parent key are set to contain `NULL` values.

## Public Constructors

### ForeignKey

> Added in 2.8.4

```
ForeignKey(
    entity: KClass<*>,
    parentColumns: Array<String>,
    childColumns: Array<String>,
    onDelete: Int = NO_ACTION,
    onUpdate: Int = NO_ACTION,
    deferred: Boolean = false
)
```

## Public Properties

### childColumns

```
val childColumns: Array<String>
```

The list of column names in the current [`@Entity`](entity.md). The number of columns must match the number of columns specified in [`parentColumns`](#parentcolumns).

### deferred

```
val deferred: Boolean
```

A foreign key constraint can be deferred until the transaction is complete. This is useful if you are doing bulk inserts into the database in a single transaction. By default, foreign key constraints are immediate, but you can change this by setting this property to `true`. You can also use the [`defer_foreign_keys`](https://sqlite.org/pragma.html#pragma_defer_foreign_keys) PRAGMA to defer them depending on your transaction. Defaults to `false`.

### entity

```
val entity: KClass<*>
```

The parent entity to reference. It must be a class annotated with [`@Entity`](entity.md) and referenced in the same database.

### onDelete

```
val onDelete: Int
```

Action to take when the parent [`@Entity`](entity.md) is deleted from the database. By default, [`NO_ACTION`](#no_action) is used.

### onUpdate

```
val onUpdate: Int
```

Action to take when the parent [`@Entity`](entity.md) is updated in the database. By default, [`NO_ACTION`](#no_action) is used.

### parentColumns

```
val parentColumns: Array<String>
```

The list of column names in the parent [`@Entity`](entity.md). The number of columns must match the number of columns specified in [`childColumns`](#childcolumns).
