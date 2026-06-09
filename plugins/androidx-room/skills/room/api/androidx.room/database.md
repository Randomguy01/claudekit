# API Reference

> Last updated 2026-06-05

# Database

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation Database
```

Marks a class as a [`RoomDatabase`](room-database.md).

The class must be an abstract class and extend [`RoomDatabase`](room-database.md).

```kotlin
// Song and Album are classes annotated with @Entity.
@Database(version = 1, entities = [Song::class, Album::class])
abstract class MusicDatabase : RoomDatabase {
  // SongDao is a class annotated with @Dao.
  abstract fun getSongDao(): SongDao

  // AlbumDao is a class annotated with @Dao.
  abstract fun getArtistDao(): ArtistDao

  // SongAlbumDao is a class annotated with @Dao.
  abstract fun getSongAlbumDao(): SongAlbumDao
}
```

**There is no limit on the number of [Entity](entity.md) or [Dao](dao.md) classes but they must be unique within the Database**

Create [Dao](dao.md) classes instead of running queries on the database directly. Dao classes will allow you to abstract the database communication, which will be much easier to mock in tests. It automatically converts `Cursor` to your application data classes. 

**Room verifies all queries in the [Dao](dao.md) classes at compile time**

Automatically generate a migration between two versions of the database using [`AutoMigration`](auto-migration.md) annotations. Note that if an autoMigration is defined in a database, `exportSchema` must be `true` and you must have the schema for both database versions.

|         See also         |
|--------------------------|
| [Dao](dao.md)            |
| [Entity](entity.md)      |
| [`AutoMigration`](auto-migration.md)      |
| [`RoomDatabase`](room-database.md)       |
| [`ConstructedBy`](constructed-by.md) |

## Public Constructors

### Database

```
Database(
    entities: Array<KClass<*>> = [],
    views: Array<KClass<*>> = [],
    version: Int,
    exportSchema: Boolean = true,
    autoMigrations: Array<AutoMigration> = []
)
```

## Public Properties

### autoMigrations

```
val autoMigrations: Array<AutoMigration>
```

List of [`AutoMigration`](auto-migration.md) that can be performed on this Database.

See [`AutoMigration`](auto-migration.md) for example code usage.

For more complicated cases not covered by [`AutoMigration`](auto-migration.md), runtime defined [`Migration`](../androidx.room.migration/migration.md) added with [`RoomDatabase.Builder.addMigrations`](room-database-builder.md) can still be used.

### entities

```
val entities: Array<KClass<*>>
```

The list of entities included in the database. Each entity turns into a table in the database.

### exportSchema

```
val exportSchema: Boolean
```

**Defaults to true**

Set the annotation processor argument (`room.schemaLocation`) to tell Room where export the database schema. Keep a version history of the schema in the codebase and commit the schema files into your version control system (but don't ship them with your app!).

When `room.schemaLocation` is set and `exportSchema` is true, the database schema will be exported into the given folder.

Set to `false` for databases which you don't want to keep history of versions (like an in-memory only database).

### version

```
val version: Int
```

The database version.

### views

```
val views: Array<KClass<*>>
```

The list of database views included in the database. Each class turns into a view in the database.
