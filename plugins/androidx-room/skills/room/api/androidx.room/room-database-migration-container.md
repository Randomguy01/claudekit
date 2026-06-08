# API Reference

> Last updated 2026-06-08

# RoomDatabase.MigrationContainer

> Added in 2.0.0

**Common**
```
class RoomDatabase.MigrationContainer
```

**Android**
```
open class RoomDatabase.MigrationContainer
```

A container to hold migrations. It also allows querying its contents to find migrations between two versions.

## Public Constructors

### MigrationContainer

> Added in 2.0.0
```
MigrationContainer()
```

## Public Functions

### addMigrations

> Added in 2.4.0
```
fun addMigrations(migrations: List<Migration>): Unit
```

Adds the given migrations to the list of available migrations. If two migrations have the same start-end versions, the latter migration overrides the previous one.

- `migrations` — List of available migrations.

**Android**
> Added in 2.0.0
```
open fun addMigrations(vararg migrations: Migration): Unit
```

Adds the given migrations to the list of available migrations. If two migrations have the same start-end versions, the latter migration overrides the previous one.

- `migrations` — List of available migrations.

### contains

> Added in 2.5.0
```
fun contains(startVersion: Int, endVersion: Int): Boolean
```

Indicates if the given migration is contained within the `MigrationContainer` based on its start-end versions. Returns `true` if it contains a migration with the same start-end version.

- `startVersion` — Start version of the migration.
- `endVersion` — End version of the migration.

### findMigrationPath

**Android**
> Added in 2.0.0
```
open fun findMigrationPath(start: Int, end: Int): List<Migration>?
```

Finds the list of migrations that should be run to move from `start` version to `end` version. Returns an ordered list of [`Migration`](../androidx.room.migration/migration.md) objects, or `null` if a migration path cannot be found.

- `start` — The current database version.
- `end` — The target database version.

### getMigrations

> Added in 2.4.0
```
fun getMigrations(): Map<Int, Map<Int, Migration>>
```

Returns the map of available migrations, keyed by the start version of the migration; the value is a map of (end version → [`Migration`](../androidx.room.migration/migration.md)).
