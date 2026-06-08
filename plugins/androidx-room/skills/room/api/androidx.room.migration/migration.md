# API Reference

> Last updated 2026-06-08

# Migration

> Added in 2.0.0

```
abstract class Migration
```

Base class for a database migration.

Each migration can move between 2 versions defined by [`startVersion`](#startversion) and [`endVersion`](#endversion).

A migration can handle more than one version (e.g. if you have a faster path to choose when going from version 3 to 5 without going to version 4). If Room opens a database at version 3 and the latest version is 5, Room will use the migration object that can migrate from 3 to 5 instead of 3 to 4 and 4 to 5.

If there are not enough migrations provided to move from the current version to the latest version, Room might clear the database and recreate it if destructive migrations are enabled.

## Public Constructors

### Migration

**Common · Android · Native** · Added in 2.0.0
```
Migration(startVersion: Int, endVersion: Int)
```

Creates a new migration between [`startVersion`](#startversion) and [`endVersion`](#endversion) inclusive.

## Public Functions

### migrate

**Common · Android · Native** · Added in 2.7.0
```
open fun migrate(connection: SQLiteConnection): Unit
```

Should run the necessary migrations.

This function is already called inside a transaction, and that transaction might actually be a composite transaction of all necessary `Migration`s.

- `connection` — The database connection.

### migrate

**Android** · Added in 2.0.0
```
open fun migrate(db: SupportSQLiteDatabase): Unit
```

Should run the necessary migrations. The `Migration` class cannot access any generated DAO in this method.

This method is already called inside a transaction, and that transaction might actually be a composite transaction of all necessary `Migration`s.

This function is only called when Room is configured without a driver. If a driver is set using [`RoomDatabase.Builder.setDriver`](../androidx.room/room-database-builder.md#setdriver), then only the version that receives a `SQLiteConnection` is called. Throws `NotImplementedError` if `migrate(SQLiteConnection)` is not overridden.

- `db` — The database instance.

## Public Properties

### endVersion

**Common · Android · Native** · Added in 2.0.0
```
val endVersion: Int
```

### startVersion

**Common · Android · Native** · Added in 2.0.0
```
val startVersion: Int
```
