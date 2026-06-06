# API Reference

> Last updated 2026-06-05

# AutoMigration

> Added in 2.4.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation AutoMigration
```

Declares an automatic migration on a Database.

An automatic migration is a [`Migration`](migration.md) that is generated via the use of database schema files at two versions of a [`RoomDatabase`](room-database.md). Room automatically detects changes on the database between these two schemas, and constructs a [`Migration`](migration.md) to migrate between the two versions. In case of ambiguous scenarios (e.g. column/table rename/deletes), additional information is required, and can be provided via the [`AutoMigrationSpec`](auto-migration-spec.md) property.

An auto migration must define the 'from' and 'to' versions of the schema for which a migration implementation will be generated. A class that implements AutoMigrationSpec can be declared in the [`AutoMigrationSpec`](auto-migration-spec.md) property to either provide more information for ambiguous scenarios or execute callbacks during the migration.

If there are any column/table renames/deletes between the two versions of the database provided then it is said that there are ambiguous scenarios in the migration. In such scenarios then an [`AutoMigrationSpec`](auto-migration-spec.md) is required and the class provided must be annotated with the relevant change annotation(s): [`RenameColumn`](rename-column.md), [`RenameTable`](rename-table.md), [`DeleteColumn`](delete-column.md) or [`DeleteTable`](delete-table.md). When no ambiguous scenario is present, then the [`AutoMigrationSpec`](auto-migration-spec.md) property is optional.

If an auto migration is defined for a database, then [`Database.exportSchema`](database.md#exportschema) must be set to true.

Example:
```kotlin
@Database(
   version = MusicDatabase.LATEST_VERSION,
   entities = [
       Song::class,
       Artist::class
   ],
   autoMigrations = [
       AutoMigration (
           from = 1,
           to = 2
       ),
       AutoMigration (
           from = 2,
           to = 3,
           spec = MusicDatabase.MyExampleAutoMigration::class
       )
   ],
   exportSchema = true
)
abstract class MusicDatabase  : RoomDatabase() {
   const val LATEST_VERSION = 3

   @DeleteTable(tableName = "Album")
   @RenameTable(fromTableName = "Singer", toTableName = "Artist")
   @RenameColumn(
       tableName = "Song",
       fromColumnName = "songName",
       toColumnName = "songTitle"
    )
   @DeleteColumn(tableName = "Song", columnName = "genre")
   class MyExampleAutoMigration : AutoMigrationSpec {
       override fun onPostMigrate(db: SupportSQLiteDatabase) {
           // Invoked once auto migration is done
       }
    }
}
```

|        See also         |
|-------------------------|
| [`RoomDatabase`](room-database.md) |
| [`AutoMigrationSpec`](auto-migration-spec.md) |

## Public Constructors

### AutoMigration

> Added in 2.8.4

```
AutoMigration(from: Int, to: Int, spec: KClass<*> = Any::class)
```

## Public Properties

### from

```
val from: Int
```

Version of the database schema to migrate from.

### spec

```
val spec: KClass<*>
```

User implemented custom auto migration spec.

### to

```
val to: Int
```

Version of the database schema to migrate to.
