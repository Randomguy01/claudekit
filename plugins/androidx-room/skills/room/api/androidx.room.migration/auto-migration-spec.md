# API Reference

> Last updated 2026-06-08

# AutoMigrationSpec

> Added in 2.4.0

```
interface AutoMigrationSpec
```

Interface for defining an automatic migration specification for Room databases.

The functions defined in this interface are called on a background thread from the executor set in Room's builder. Note that the functions are all run inside a transaction when called.

See also [`@AutoMigration`](../androidx.room/auto-migration.md).

## Public Functions

### onPostMigrate

**Common · Android · Native** · Added in 2.7.0
```
fun onPostMigrate(connection: SQLiteConnection): Unit
```

Invoked after the migration is completed.

- `connection` — The database connection.

### onPostMigrate

**Android** · Added in 2.4.0
```
open fun onPostMigrate(db: SupportSQLiteDatabase): Unit
```

Invoked after the migration is completed.

This function is only called when Room is configured without a driver. If a driver is set using [`RoomDatabase.Builder.setDriver`](../androidx.room/room-database-builder.md#setdriver), then only the version that receives a `SQLiteConnection` is called.

- `db` — The SQLite database.
