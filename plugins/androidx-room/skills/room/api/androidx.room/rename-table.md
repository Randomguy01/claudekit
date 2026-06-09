# API Reference

> Last updated 2026-06-05

# RenameTable

> Added in 2.4.0

**Common**
```
@Repeatable
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
@OptionalExpectation
annotation RenameTable
```

**Android**
```
@Repeatable(value = RenameTable.Entries)
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation RenameTable
```

Repeatable annotation declaring the renamed tables in the new version of an auto migration.

|        See also         |
|-------------------------|
| [`AutoMigration`](auto-migration.md) |

## Nested Types

| Type |
|------|
| `annotation` [`RenameTable.Entries`](rename-table-entries.md) — Container annotation for the repeatable annotation [`RenameTable`](rename-table.md). |

## Public Constructors

### RenameTable

> Added in 2.8.4

```
RenameTable(fromTableName: String, toTableName: String)
```

## Public Properties

### fromTableName

```
val fromTableName: String
```

Name of the table in the [`AutoMigration.from`](auto-migration.md#from) version of the database.

### toTableName

```
val toTableName: String
```

Name of the table in the [`AutoMigration.to`](auto-migration.md#to) version of the database.
