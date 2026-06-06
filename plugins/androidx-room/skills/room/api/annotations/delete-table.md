# API Reference

> Last updated 2026-06-05

# DeleteTable

> Added in 2.4.0

**Common**
```
@Repeatable
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
@OptionalExpectation
annotation DeleteTable
```

**Android**
```
@Repeatable(value = DeleteTable.Entries)
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation DeleteTable
```

Repeatable annotation declaring the deleted tables in the [`AutoMigration.to`](auto-migration.md#to) version of an auto migration.

|        See also         |
|-------------------------|
| [`AutoMigration`](auto-migration.md) |

## Nested Types

| Type |
|------|
| `annotation` [`DeleteTable.Entries`](delete-table-entries.md) — Container annotation for the repeatable annotation [`DeleteTable`](delete-table.md). |

## Public Constructors

### DeleteTable

> Added in 2.8.4

```
DeleteTable(tableName: String)
```

## Public Properties

### tableName

```
val tableName: String
```

Name of the table in the [`AutoMigration.from`](auto-migration.md#from) version of the database to be deleted.
