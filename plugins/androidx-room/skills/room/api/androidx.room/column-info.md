# API Reference

> Last updated 2026-06-05

# ColumnInfo

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FIELD, AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation ColumnInfo
```

Allows specific customization about the column associated with this property.

For example, you can specify a column name for the property or change the column's type affinity.

## Nested Types

| Type |
|------|
| `annotation` [`ColumnInfo.Collate`](column-info-collate.md) |
| `annotation` [`ColumnInfo.SQLiteTypeAffinity`](column-info-sqlite-type-affinity.md) — The SQLite column type constants that can be used in [`typeAffinity`](#typeaffinity). |

## Constants

### BINARY

> Added in 2.5.0

```
const val BINARY = 2: Int
```

Collation sequence for case-sensitive match.

### BLOB

> Added in 2.5.0

```
const val BLOB = 5: Int
```

Column affinity constant for binary data.

### INHERIT_FIELD_NAME

> Added in 2.5.0

```
const val INHERIT_FIELD_NAME: String
```

Constant to let Room inherit the property name as the column name. If used, Room will use the property name as the column name.

### INTEGER

> Added in 2.5.0

```
const val INTEGER = 3: Int
```

Column affinity constant for integers or booleans.

### LOCALIZED

> Added in 2.5.0

```
const val LOCALIZED = 5: Int
```

Collation sequence that uses system's current locale.

### NOCASE

> Added in 2.5.0

```
const val NOCASE = 3: Int
```

Collation sequence for case-insensitive match.

### REAL

> Added in 2.5.0

```
const val REAL = 4: Int
```

Column affinity constant for floats or doubles.

### RTRIM

> Added in 2.5.0

```
const val RTRIM = 4: Int
```

Collation sequence for case-sensitive match except that trailing space characters are ignored.

### TEXT

> Added in 2.5.0

```
const val TEXT = 2: Int
```

Column affinity constant for strings.

### UNDEFINED

> Added in 2.5.0

```
const val UNDEFINED = 1: Int
```

Undefined type affinity. Will be resolved based on the type.

### UNICODE

> Added in 2.5.0

```
const val UNICODE = 6: Int
```

Collation sequence that uses Unicode Collation Algorithm.

### UNSPECIFIED

> Added in 2.5.0

```
const val UNSPECIFIED = 1: Int
```

Collation sequence is not specified. The match will behave like [`BINARY`](#binary).

### VALUE_UNSPECIFIED

> Added in 2.5.0

```
const val VALUE_UNSPECIFIED: String
```

A constant for [`defaultValue`](#defaultvalue) that makes the column to have no default value.

## Public Constructors

### ColumnInfo

> Added in 2.8.4

```
ColumnInfo(
    name: String = INHERIT_FIELD_NAME,
    typeAffinity: Int = UNDEFINED,
    index: Boolean = false,
    collate: Int = UNSPECIFIED,
    defaultValue: String = VALUE_UNSPECIFIED
)
```

## Public Properties

### collate

```
val collate: Int
```

The collation sequence for the column, which will be used when constructing the database.

The default value is [`UNSPECIFIED`](#unspecified). In that case, Room does not add any collation sequence to the column, and SQLite treats it like [`BINARY`](#binary).

### defaultValue

```
val defaultValue: String
```

The default value for this column.

```kotlin
@ColumnInfo(defaultValue = "No name")
public name: String

@ColumnInfo(defaultValue = "0")
public flag: Int
```

Note that the default value you specify here will *NOT* be used if you simply insert the [`Entity`](entity.md) with [`Insert`](insert.md). In that case, any value assigned in Java/Kotlin will be used. Use [`Query`](query.md) with an `INSERT` statement and skip this column there in order to use this default value.

NULL, CURRENT_TIMESTAMP and other SQLite constant values are interpreted as such. If you want to use them as strings for some reason, surround them with single-quotes.

```kotlin
@ColumnInfo(defaultValue = "NULL")
public description: String?

@ColumnInfo(defaultValue = "'NULL'")
public name: String
```

You can also use constant expressions by surrounding them with parentheses.

```kotlin
@ColumnInfo(defaultValue = "('Created at' || CURRENT_TIMESTAMP)")
public notice: String
```

### index

```
val index: Boolean
```

Convenience method to index the property.

If you would like to create a composite index instead, see: [`Index`](index.md).

### name

```
val name: String
```

Name of the column in the database. Defaults to the property name if not set.

### typeAffinity

```
val typeAffinity: Int
```

The type affinity for the column, which will be used when constructing the database.

If it is not specified, the value defaults to [`UNDEFINED`](#undefined) and Room resolves it based on the property's type and available TypeConverters.
