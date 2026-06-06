# API Reference

> Last updated 2026-06-05

# RenameColumn

> Added in 2.4.0

**Common**
```
@Repeatable
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
@OptionalExpectation
annotation RenameColumn
```

**Android**
```
@Repeatable(value = RenameColumn.Entries)
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation RenameColumn
```

Repeatable annotation declaring the renamed columns in the [`AutoMigration.to`](auto-migration.md#to) version of an auto migration.

|        See also         |
|-------------------------|
| [`AutoMigration`](auto-migration.md) |

## Nested Types

| Type |
|------|
| `annotation` [`RenameColumn.Entries`](rename-column-entries.md) — Container annotation for the repeatable annotation [`RenameColumn`](rename-column.md). |

## Public Constructors

### RenameColumn

> Added in 2.8.4

```
RenameColumn(
    tableName: String,
    fromColumnName: String,
    toColumnName: String
)
```

## Public Properties

### fromColumnName

```
val fromColumnName: String
```

Name of the column in the [`AutoMigration.from`](auto-migration.md#from) version of the database.

### tableName

```
val tableName: String
```

Name of the table in the [`AutoMigration.from`](auto-migration.md#from) version of the database the renamed column is found in. The name in [`AutoMigration.from`](auto-migration.md#from) version is used in case the table was renamed in the [`AutoMigration.to`](auto-migration.md#to) version.

### toColumnName

```
val toColumnName: String
```

Name of the column in the [`AutoMigration.to`](auto-migration.md#to) version of the database.
