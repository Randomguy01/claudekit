# API Reference

> Last updated 2026-06-08

# RoomDatabase.Builder

> Added in 2.0.0

**Common**
```
class RoomDatabase.Builder<T : RoomDatabase>
```

**Android**
```
open class RoomDatabase.Builder<T : RoomDatabase>
```

Builder for [`RoomDatabase`](room-database.md). The type parameter `T` is the abstract database class.

Obtain a builder via [`Room.databaseBuilder`](room.md#databasebuilder) or [`Room.inMemoryDatabaseBuilder`](room.md#inmemorydatabasebuilder). Each configuration function returns this builder instance for chaining.

## Public Functions

### addAutoMigrationSpec

> Added in 2.4.0
```
fun addAutoMigrationSpec(autoMigrationSpec: AutoMigrationSpec): RoomDatabase.Builder<T>
```

Adds an auto migration spec instance to the builder.

- `autoMigrationSpec` — The auto migration object that is annotated with [`@ProvidedAutoMigrationSpec`](provided-auto-migration-spec.md) and is declared in an [`@AutoMigration`](auto-migration.md) annotation.

### addCallback

> Added in 2.0.0
```
fun addCallback(callback: RoomDatabase.Callback): RoomDatabase.Builder<T>
```

Adds a [`RoomDatabase.Callback`](room-database-callback.md) to this database.

- `callback` — The callback.

### addMigrations

> Added in 2.0.0
```
fun addMigrations(vararg migrations: Migration): RoomDatabase.Builder<T>
```

Adds a migration to the builder.

Each [`Migration`](../androidx.room.migration/migration.md) has start and end versions, and Room runs these migrations to bring the database to the latest version. A migration can handle more than one version (e.g. a faster path from version 3 to 5 without going through version 4). If Room opens a database at version 3 and the latest version is >= 5, it uses the 3-to-5 migration instead of 3-to-4 and 4-to-5.

- `migrations` — The migration objects that modify the database schema with the necessary changes for a version change.

### addTypeConverter

> Added in 2.3.0
```
fun addTypeConverter(typeConverter: Any): RoomDatabase.Builder<T>
```

Adds a type converter instance to the builder.

- `typeConverter` — The converter instance that is annotated with [`@ProvidedTypeConverter`](provided-type-converter.md).

### allowMainThreadQueries

**Android**
> Added in 2.0.0
```
open fun allowMainThreadQueries(): RoomDatabase.Builder<T>
```

Disables the main thread query check for Room.

Room ensures the database is never accessed on the main thread because it may lock the main thread and trigger an ANR. If you need to access the database from the main thread, use async alternatives or manually move the call to a background thread. You may want to turn this check off for testing.

### build

> Added in 2.0.0
```
fun build(): T
```

Creates the database and initializes it. Throws `IllegalArgumentException` if the builder was misconfigured.

### createFromAsset

**Android**
> Added in 2.2.0
```
open fun createFromAsset(databaseFilePath: String): RoomDatabase.Builder<T>
```

Configures Room to create and open the database using a pre-packaged database located in the application `assets/` folder.

Room does not open the pre-packaged database; it copies it into the internal app database folder and then opens it. The file must be located in the `assets/` folder of your application — for example, a file at `assets/databases/products.db` has the path `databases/products.db`. The pre-packaged schema is validated. This method is not supported for an in-memory database builder.

- `databaseFilePath` — The file path within the `assets/` directory where the database file is located.

**Android**
> Added in 2.3.0
```
open fun createFromAsset(
    databaseFilePath: String,
    callback: RoomDatabase.PrepackagedDatabaseCallback
): RoomDatabase.Builder<T>
```

As above, with a [`RoomDatabase.PrepackagedDatabaseCallback`](room-database-prepackaged-database-callback.md).

- `databaseFilePath` — The file path within the `assets/` directory where the database file is located.
- `callback` — The pre-packaged callback.

### createFromFile

**Android**
> Added in 2.2.0
```
open fun createFromFile(databaseFile: File): RoomDatabase.Builder<T>
```

Configures Room to create and open the database using a pre-packaged database file.

Room does not open the pre-packaged database; it copies it into the internal app database folder and then opens it. The given file must be accessible with the right permissions for Room to copy it. The pre-packaged schema is validated. The [`RoomDatabase.Callback.onOpen()`](room-database-callback.md#onopen) method can be used as an indicator that the pre-packaged database was successfully opened and can be cleaned up. This method is not supported for an in-memory database builder.

- `databaseFile` — The database file.

**Android**
> Added in 2.3.0
```
open fun createFromFile(
    databaseFile: File,
    callback: RoomDatabase.PrepackagedDatabaseCallback
): RoomDatabase.Builder<T>
```

As above, with a [`RoomDatabase.PrepackagedDatabaseCallback`](room-database-prepackaged-database-callback.md).

- `databaseFile` — The database file.
- `callback` — The pre-packaged callback.

### createFromInputStream

**Android**
> Added in 2.3.0
```
open fun createFromInputStream(inputStreamCallable: Callable<InputStream>): RoomDatabase.Builder<T>
```

Configures Room to create and open the database using a pre-packaged database via an `InputStream`. This is useful for processing compressed database files. Room copies the stream into the internal app database folder and then opens it; the `InputStream` is closed once Room is done consuming it. This method is not supported for an in-memory database builder.

- `inputStreamCallable` — A callable that returns an `InputStream` from which to copy the database. Invoked on a thread from the executor set via `setQueryExecutor()`, only if Room needs to create and open the database from the pre-packaged database.

**Android**
> Added in 2.3.0
```
open fun createFromInputStream(
    inputStreamCallable: Callable<InputStream>,
    callback: RoomDatabase.PrepackagedDatabaseCallback
): RoomDatabase.Builder<T>
```

As above, with a [`RoomDatabase.PrepackagedDatabaseCallback`](room-database-prepackaged-database-callback.md).

- `inputStreamCallable` — A callable that returns an `InputStream` from which to copy the database.
- `callback` — The pre-packaged callback.

### enableMultiInstanceInvalidation

**Android**
> Added in 2.1.0
```
open fun enableMultiInstanceInvalidation(): RoomDatabase.Builder<T>
```

Sets whether table invalidation in this instance of `RoomDatabase` should be broadcast and synchronized with other instances of the same `RoomDatabase`, including those in a separate process. To enable multi-instance invalidation, this has to be turned on at both ends. Not enabled by default. Does not work for in-memory databases or between database instances targeting different database files.

### fallbackToDestructiveMigration

**Android**
> Added in 2.0.0 · Deprecated in 2.7.0
```
open fun fallbackToDestructiveMigration(): RoomDatabase.Builder<T>
```

**Deprecated — replaced by the overload with a parameter indicating whether all tables should be dropped.**

Allows Room to destructively recreate database tables if the [`Migration`](../androidx.room.migration/migration.md)s needed to migrate old schemas to the latest version are not found. Without this, Room throws an `IllegalStateException` when the migration set is incomplete. If the database was created from an asset or a file, Room tries to re-create it from the same source; otherwise it deletes all data in the Room-managed tables.

**Common**
> Added in 2.7.0
```
fun fallbackToDestructiveMigration(dropAllTables: Boolean): RoomDatabase.Builder<T>
```

Allows Room to destructively recreate database tables if the [`Migration`](../androidx.room.migration/migration.md)s needed to migrate old schemas to the latest version are not found.

- `dropAllTables` — Set to `true` if all tables should be dropped during destructive migration, including those not managed by Room. Recommended value is `true`, as otherwise Room could leave obsolete data when table names or existence change between versions.

### fallbackToDestructiveMigrationFrom

**Android**
> Added in 2.0.0 · Deprecated in 2.7.0
```
open fun fallbackToDestructiveMigrationFrom(vararg startVersions: Int): RoomDatabase.Builder<T>
```

**Deprecated — replaced by the overload with a parameter indicating whether all tables should be dropped.**

Informs Room that it is allowed to destructively recreate database tables from specific starting schema versions. Preferable to `fallbackToDestructiveMigration()` when you want destructive migrations from some versions while still getting exceptions for unintentionally missing migrations. No version passed here may also exist as a starting or ending version in the migrations provided to `addMigrations()`.

- `startVersions` — The set of schema versions from which Room should use a destructive migration.

**Common**
> Added in 2.7.0
```
fun fallbackToDestructiveMigrationFrom(
    dropAllTables: Boolean,
    vararg startVersions: Int
): RoomDatabase.Builder<T>
```

As above.

- `dropAllTables` — Set to `true` if all tables should be dropped during destructive migration, including those not managed by Room. Recommended value is `true`.
- `startVersions` — The set of schema versions from which Room should use a destructive migration.

### fallbackToDestructiveMigrationOnDowngrade

**Android**
> Added in 2.1.0 · Deprecated in 2.7.0
```
open fun fallbackToDestructiveMigrationOnDowngrade(): RoomDatabase.Builder<T>
```

**Deprecated — replaced by the overload with a parameter indicating whether all tables should be dropped.**

Allows Room to destructively recreate database tables if migrations are not available when downgrading to old schema versions. For details, see `fallbackToDestructiveMigration()`.

**Common**
> Added in 2.7.0
```
fun fallbackToDestructiveMigrationOnDowngrade(dropAllTables: Boolean): RoomDatabase.Builder<T>
```

Allows Room to destructively recreate database tables if migrations are not available when downgrading to old schema versions.

- `dropAllTables` — Set to `true` if all tables should be dropped during destructive migration, including those not managed by Room. Recommended value is `true`.

### openHelperFactory

**Android**
> Added in 2.0.0
```
open fun openHelperFactory(factory: SupportSQLiteOpenHelper.Factory?): RoomDatabase.Builder<T>
```

Sets the database factory. If not set, it defaults to `FrameworkSQLiteOpenHelperFactory`.

- `factory` — The factory to use to access the database.

### setAutoCloseTimeout

**Android**
> Added in 2.3.0
```
@ExperimentalRoomApi
open fun setAutoCloseTimeout(
    autoCloseTimeout: @IntRange(from = 0) Long,
    autoCloseTimeUnit: TimeUnit
): RoomDatabase.Builder<T>
```

Enables auto-closing for the database to free up unused resources. The underlying database is closed after the specified timeout elapses since its last use, and re-opened automatically the next time it is accessed. See [`@ExperimentalRoomApi`](experimental-room-api.md).

Not compatible with in-memory databases. Temp tables and temp triggers are cleared each time the database is auto-closed; if you need them, include them in your [`RoomDatabase.Callback.onOpen()`](room-database-callback.md#onopen). The database is not re-opened if closed manually via `RoomDatabase.close()`.

- `autoCloseTimeout` — The amount of time after the last usage before closing the database. Must be greater than or equal to zero.
- `autoCloseTimeUnit` — The time unit for `autoCloseTimeout`.

### setDriver

> Added in 2.7.0
```
fun setDriver(driver: SQLiteDriver): RoomDatabase.Builder<T>
```

Sets the `SQLiteDriver` implementation to be used by Room to open database connections.

- `driver` — The driver.

### setInMemoryTrackingMode

**Android**
> Added in 2.7.0
```
@ExperimentalRoomApi
fun setInMemoryTrackingMode(inMemory: Boolean): RoomDatabase.Builder<T>
```

Sets whether Room will use an in-memory table or a persisted table to track invalidation. An in-memory table is used by default; it is more performant and reduces journal file size but increases the memory footprint. See [`@ExperimentalRoomApi`](experimental-room-api.md).

- `inMemory` — `true` if in-memory tables should be used, `false` otherwise.

### setJournalMode

> Added in 2.0.0
```
fun setJournalMode(journalMode: RoomDatabase.JournalMode): RoomDatabase.Builder<T>
```

Sets the journal mode for this database. The value is ignored for an in-memory database. The journal mode should be consistent across multiple instances of `RoomDatabase` for a single SQLite database file. The default is [`RoomDatabase.JournalMode.WRITE_AHEAD_LOGGING`](room-database-journal-mode.md#write_ahead_logging).

- `journalMode` — The journal mode.

### setMultiInstanceInvalidationServiceIntent

**Android**
> Added in 2.4.0
```
@ExperimentalRoomApi
open fun setMultiInstanceInvalidationServiceIntent(
    invalidationServiceIntent: Intent
): RoomDatabase.Builder<T>
```

Sets whether table invalidation should be broadcast and synchronized with other instances of the same `RoomDatabase`, including those in a separate process, pointing to the same `MultiInstanceInvalidationService`. Must be turned on at both ends. Not enabled by default. Does not work for in-memory databases or between instances targeting different files. See [`@ExperimentalRoomApi`](experimental-room-api.md).

- `invalidationServiceIntent` — Intent to bind to the `MultiInstanceInvalidationService`.

### setQueryCallback

**Android**
> Added in 2.7.0
```
fun setQueryCallback(
    context: CoroutineContext,
    queryCallback: RoomDatabase.QueryCallback
): RoomDatabase.Builder<T>
```

Sets a [`RoomDatabase.QueryCallback`](room-database-query-callback.md) to be invoked when queries are executed. The callback has a small cost and should be avoided in production builds unless needed. A typical use case is logging executed queries, for which `Unconfined` is recommended. Overrides any previously set callback, including removing a previously set executor.

- `context` — The coroutine context on which the query callback is invoked.
- `queryCallback` — The query callback.

**Android**
> Added in 2.3.0
```
open fun setQueryCallback(
    queryCallback: RoomDatabase.QueryCallback,
    executor: Executor
): RoomDatabase.Builder<T>
```

As above, using an `Executor` instead of a coroutine context. An immediate executor is recommended for logging. Overrides any previously set callback, including removing a previously set coroutine context.

- `queryCallback` — The query callback.
- `executor` — The executor on which the query callback is invoked.

### setQueryCoroutineContext

> Added in 2.7.0
```
fun setQueryCoroutineContext(context: CoroutineContext): RoomDatabase.Builder<T>
```

Sets the `CoroutineContext` used to execute all asynchronous queries and tasks, such as `Flow` emissions and `InvalidationTracker` notifications. Throws `IllegalArgumentException` if no `CoroutineDispatcher` is present in the context. On native targets, if no context is provided Room defaults to `Dispatchers.IO`.

- `context` — The context.

### setQueryExecutor

**Android**
> Added in 2.0.0
```
open fun setQueryExecutor(executor: Executor): RoomDatabase.Builder<T>
```

Sets the `Executor` used to execute all non-blocking asynchronous queries and tasks, including `LiveData` invalidation, `Flowable` scheduling, and `ListenableFuture` tasks.

When both the query and transaction executors are unset, a default shared `Executor` is used. If only the transaction executor is set via `setTransactionExecutor()`, the same executor is used for queries. For best performance the executor should be bounded, and it cannot run tasks on the UI thread. Throws `IllegalArgumentException` if the builder was already configured with a `CoroutineContext`.

### setTransactionExecutor

**Android**
> Added in 2.1.0
```
open fun setTransactionExecutor(executor: Executor): RoomDatabase.Builder<T>
```

Sets the `Executor` used to execute all non-blocking asynchronous transaction queries and tasks.

When both the transaction and query executors are unset, a default shared `Executor` is used. If only the query executor is set via `setQueryExecutor()`, the same executor is used for transactions. A shared executor should be unbounded to avoid deadlock; Room uses at most one thread at a time from it since only one transaction runs at a time. It cannot run tasks on the UI thread. Throws `IllegalArgumentException` if the builder was already configured with a `CoroutineContext`.
