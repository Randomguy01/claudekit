# API Reference

> Last updated 2026-06-08

# RoomDatabase.PrepackagedDatabaseCallback

> Added in 2.3.0

**Android**
```
abstract class RoomDatabase.PrepackagedDatabaseCallback
```

Callback for [`Builder.createFromAsset`](room-database-builder.md#createfromasset), [`Builder.createFromFile`](room-database-builder.md#createfromfile), and [`Builder.createFromInputStream`](room-database-builder.md#createfrominputstream).

This callback is invoked after the pre-packaged database is copied but before Room has a chance to open it — therefore before the [`RoomDatabase.Callback`](room-database-callback.md) methods are invoked. It can be useful for updating the pre-packaged database schema to satisfy Room's schema validation.

## Public Constructors

### PrepackagedDatabaseCallback

> Added in 2.3.0
```
PrepackagedDatabaseCallback()
```

## Public Functions

### onOpenPrepackagedDatabase

**Android**
> Added in 2.3.0
```
open fun onOpenPrepackagedDatabase(db: SupportSQLiteDatabase): Unit
```

Called when the pre-packaged database has been copied.

- `db` — The database.
