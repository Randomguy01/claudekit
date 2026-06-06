# API Reference

> Last updated 2026-06-05

# DeleteColumn

> Added in 2.4.0

**Common**
```
@Repeatable
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
@OptionalExpectation
annotation DeleteColumn
```

**Android**
```
@Repeatable(value = DeleteColumn.Entries)
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation DeleteColumn
```

Repeatable annotation declaring the deleted columns in the [`AutoMigration.to`](auto-migration.md#to) version of an auto migration.

|        See also         |
|-------------------------|
| [`AutoMigration`](auto-migration.md) |

## Nested Types

| Type |
|------|
| `annotation` [`DeleteColumn.Entries`](delete-column-entries.md) — Container annotation for the repeatable annotation [`DeleteColumn`](delete-column.md). |

## Public Constructors

### DeleteColumn

> Added in 2.8.4

```
DeleteColumn(tableName: String, columnName: String)
```

## Public Properties

### columnName

```
val columnName: String
```

Name of the column deleted in the [`AutoMigration.to`](auto-migration.md#to) version of the database.

### tableName

```
val tableName: String
```

Name of the table in the [`AutoMigration.from`](auto-migration.md#from) version of the database the column was deleted from.
