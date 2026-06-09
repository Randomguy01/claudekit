# API Reference

> Last updated 2026-06-08

# DatabaseConfiguration

> Added in 2.0.0

**Common**
```
class DatabaseConfiguration
```

**Android**
```
open class DatabaseConfiguration
```

Configuration class for a [`RoomDatabase`](room-database.md).

## Public Constructors

### DatabaseConfiguration

**Native**
```
DatabaseConfiguration(
    name: String?,
    migrationContainer: RoomDatabase.MigrationContainer,
    callbacks: List<RoomDatabase.Callback>?,
    journalMode: RoomDatabase.JournalMode,
    requireMigration: Boolean,
    allowDestructiveMigrationOnDowngrade: Boolean,
    migrationNotRequiredFrom: Set<Int>?,
    typeConverters: List<Any>,
    autoMigrationSpecs: List<AutoMigrationSpec>,
    allowDestructiveMigrationForAllTables: Boolean,
    sqliteDriver: SQLiteDriver?,
    queryCoroutineContext: CoroutineContext?
)
```

## Public Functions

### isMigrationRequired

**Android**
> Added in 2.1.0
```
open fun isMigrationRequired(fromVersion: Int, toVersion: Int): Boolean
```

Returns whether a migration is required between two versions. Returns `true` if a valid migration is required.

- `fromVersion` — The old schema version.
- `toVersion` — The new schema version.

### isMigrationRequiredFrom

**Android**
> Added in 2.0.0 · Deprecated in 2.1.0
```
open fun isMigrationRequiredFrom(version: Int): Boolean
```

**Deprecated — use [`isMigrationRequired(fromVersion, toVersion)`](#ismigrationrequired), which takes [`allowDestructiveMigrationOnDowngrade`](#allowdestructivemigrationondowngrade) into account.**

Returns whether a migration is required from the specified version. Returns `true` if a valid migration is required.

- `version` — The schema version.

## Public Properties

### allowDestructiveMigrationForAllTables

> Added in 2.7.0
```
val allowDestructiveMigrationForAllTables: Boolean
```

### allowDestructiveMigrationOnDowngrade

> Added in 2.1.0
```
val allowDestructiveMigrationOnDowngrade: Boolean
```

### allowMainThreadQueries

**Android**
> Added in 2.0.0
```
val allowMainThreadQueries: Boolean
```

### autoMigrationSpecs

> Added in 2.4.0
```
val autoMigrationSpecs: List<AutoMigrationSpec>
```

### callbacks

> Added in 2.0.0
```
val callbacks: List<RoomDatabase.Callback>?
```

### context

**Android**
> Added in 2.0.0
```
val context: Context
```

### copyFromAssetPath

**Android**
> Added in 2.2.0
```
val copyFromAssetPath: String?
```

### copyFromFile

**Android**
> Added in 2.2.0
```
val copyFromFile: File?
```

### copyFromInputStream

**Android**
> Added in 2.3.0
```
val copyFromInputStream: Callable<InputStream>?
```

### journalMode

> Added in 2.0.0
```
val journalMode: RoomDatabase.JournalMode
```

### migrationContainer

> Added in 2.0.0
```
val migrationContainer: RoomDatabase.MigrationContainer
```

### multiInstanceInvalidation

**Android**
> Added in 2.1.0
```
val multiInstanceInvalidation: Boolean
```

If `true`, table invalidation in an instance of `RoomDatabase` is broadcast and synchronized with other instances of the same `RoomDatabase` file, including those in a separate process.

### name

> Added in 2.0.0
```
val name: String?
```

### prepackagedDatabaseCallback

**Android**
> Added in 2.3.0
```
val prepackagedDatabaseCallback: RoomDatabase.PrepackagedDatabaseCallback?
```

### queryCoroutineContext

> Added in 2.7.0
```
val queryCoroutineContext: CoroutineContext?
```

### queryExecutor

**Android**
> Added in 2.0.0
```
val queryExecutor: Executor
```

### requireMigration

> Added in 2.0.0
```
val requireMigration: Boolean
```

### sqliteDriver

> Added in 2.7.0
```
val sqliteDriver: SQLiteDriver?
```

### sqliteOpenHelperFactory

**Android**
> Added in 2.0.0
```
val sqliteOpenHelperFactory: SupportSQLiteOpenHelper.Factory?
```

### transactionExecutor

**Android**
> Added in 2.1.0
```
val transactionExecutor: Executor
```

### typeConverters

> Added in 2.3.0
```
val typeConverters: List<Any>
```
