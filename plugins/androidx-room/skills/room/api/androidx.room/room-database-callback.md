# API Reference

> Last updated 2026-06-08

# RoomDatabase.Callback

> Added in 2.0.0

```
abstract class RoomDatabase.Callback
```

Callback for [`RoomDatabase`](room-database.md).

## Public Constructors

### Callback

```
Callback()
```

## Public Functions

### onCreate

> Added in 2.7.0
```
open fun onCreate(connection: SQLiteConnection): Unit
```

Called when the database is created for the first time, after all the tables are created.

- `connection` — The database connection.

**Android**
> Added in 2.0.0
```
open fun onCreate(db: SupportSQLiteDatabase): Unit
```

Called when the database is created for the first time, after all the tables are created.

This function is only called when Room is configured without a driver. If a driver is set using `Builder.setDriver`, then only the version that receives a `SQLiteConnection` is called.

- `db` — The database.

### onDestructiveMigration

> Added in 2.7.0
```
open fun onDestructiveMigration(connection: SQLiteConnection): Unit
```

Called after the database was destructively migrated.

- `connection` — The database connection.

**Android**
> Added in 2.2.0
```
open fun onDestructiveMigration(db: SupportSQLiteDatabase): Unit
```

Called after the database was destructively migrated.

This function is only called when Room is configured without a driver. If a driver is set using `Builder.setDriver`, then only the version that receives a `SQLiteConnection` is called.

- `db` — The database.

### onOpen

> Added in 2.7.0
```
open fun onOpen(connection: SQLiteConnection): Unit
```

Called when the database has been opened.

- `connection` — The database connection.

**Android**
> Added in 2.0.0
```
open fun onOpen(db: SupportSQLiteDatabase): Unit
```

Called when the database has been opened.

This function is only called when Room is configured without a driver. If a driver is set using `Builder.setDriver`, then only the version that receives a `SQLiteConnection` is called.

- `db` — The database.
