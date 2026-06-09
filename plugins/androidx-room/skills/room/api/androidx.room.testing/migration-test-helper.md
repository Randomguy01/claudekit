# API Reference

> Last updated 2026-06-08

# MigrationTestHelper

> Added in 2.0.0

**Common**
```
class MigrationTestHelper
```

**Android**
```
open class MigrationTestHelper
```

A class that can help test and verify database creation and migration at different versions with different schemas.

Common usage is to create a database at an older version first and then attempt a migration and validation:

```kotlin
@Test
fun migrationTest() {
    val migrationTestHelper = getMigrationTestHelper()
    // Create the database at version 1
    val newConnection = migrationTestHelper.createDatabase(1)
    // Insert some data that should be preserved
    newConnection.execSQL("INSERT INTO Pet (id, name) VALUES (1, 'Tom')")
    newConnection.close()

    // Migrate the database to version 2
    val migratedConnection =
        migrationTestHelper.runMigrationsAndValidate(2, listOf(MIGRATION_1_2))
    migratedConnection.prepare("SELECT * FROM Pet").use { stmt ->
        // Validates data is preserved between migrations.
        assertThat(stmt.step()).isTrue()
        assertThat(stmt.getText(1)).isEqualTo("Tom")
    }
    migratedConnection.close()
}
```

The helper relies on exported schemas, so [`Database.exportSchema`](../androidx.room/database.md#exportschema) should be enabled. The schema location is configured via Room's Gradle Plugin (id `androidx.room`):

```kotlin
room {
    schemaDirectory("$projectDir/schemas")
}
```

The helper is then instantiated to use the same schema location the schemas are exported to. See platform-specific documentation for further configuration.

This type is provided by the `androidx.room:room-testing` artifact. On Android the class extends JUnit's `TestWatcher`, so it can be registered as a `@Rule` to automatically close databases opened during a test (see [`closeWhenFinished`](#closewhenfinished)). The [`apply`](#apply), [`starting`](#starting), [`succeeded`](#succeeded), [`failed`](#failed), [`finished`](#finished_1), and [`skipped`](#skipped) members below are the JUnit rule overrides that implement that behavior.

## Public Constructors

### MigrationTestHelper

**Android** · Added in 2.4.0
```
MigrationTestHelper(
    instrumentation: Instrumentation,
    databaseClass: Class<RoomDatabase>
)
```

Creates a new migration helper. It uses the instrumentation context to load the schema (falls back to the app resources) and the target context to create the database.

When the helper is created with this configuration, only [`createDatabase(name, version)`](#createdatabase_1) and [`runMigrationsAndValidate(name, version, validateDroppedTables, migrations)`](#runmigrationsandvalidate_1) that return a `SupportSQLiteDatabase` can be used.

- `instrumentation` — The instrumentation instance.
- `databaseClass` — The `@Database` annotated class to be tested.

### MigrationTestHelper

**Android** · Added in 2.0.0 · Deprecated in 2.4.0
```
MigrationTestHelper(
    instrumentation: Instrumentation,
    assetsFolder: String,
    openFactory: SupportSQLiteOpenHelper.Factory = FrameworkSQLiteOpenHelperFactory()
)
```

**Deprecated — cannot be used to run migration tests involving auto migrations. To test an auto migration, use a constructor that receives the database class as a parameter.**

Creates a new migration helper. It uses the instrumentation context to load the schema (falls back to the app resources) and the target context to create the database.

- `instrumentation` — The instrumentation instance.
- `assetsFolder` — The asset folder in the assets directory.
- `openFactory` — Factory for creating a `SupportSQLiteOpenHelper`.

### MigrationTestHelper

**Android** · Added in 2.4.0
```
MigrationTestHelper(
    instrumentation: Instrumentation,
    databaseClass: Class<RoomDatabase>,
    specs: List<AutoMigrationSpec>,
    openFactory: SupportSQLiteOpenHelper.Factory = FrameworkSQLiteOpenHelperFactory()
)
```

Creates a new migration helper. Instances of classes annotated with [`@ProvidedAutoMigrationSpec`](../androidx.room/provided-auto-migration-spec.md) are provided through this constructor; the helper maps auto-migration spec classes to their provided instances before running and validating the migrations.

- `instrumentation` — The instrumentation instance.
- `databaseClass` — The `@Database` annotated class to be tested.
- `specs` — The list of available auto-migration specs that will be provided to the `RoomDatabase` at runtime.
- `openFactory` — Factory for creating a `SupportSQLiteOpenHelper`.

### MigrationTestHelper

**Android**
```
MigrationTestHelper(
    instrumentation: Instrumentation,
    file: File,
    driver: SQLiteDriver,
    databaseClass: KClass<RoomDatabase>,
    databaseFactory: () -> RoomDatabase = {
        findAndInstantiateDatabaseImpl(databaseClass.java)
    },
    autoMigrationSpecs: List<AutoMigrationSpec> = emptyList()
)
```

Creates a new migration helper driven by an `androidx.sqlite` `SQLiteDriver`. When created with this configuration, only [`createDatabase(version)`](#createdatabase) and [`runMigrationsAndValidate(version, migrations)`](#runmigrationsandvalidate) that return a `SQLiteConnection` can be used.

- `instrumentation` — The instrumentation instance.
- `file` — The database file.
- `driver` — A driver that opens a connection to a file database. A driver that opens connections to an in-memory database would be meaningless.
- `databaseClass` — The [`@Database`](../androidx.room/database.md) annotated class.
- `databaseFactory` — An optional factory function to create an instance of the database. Should be the same factory used when building the database via [`Room.databaseBuilder`](../androidx.room/room.md#databasebuilder).
- `autoMigrationSpecs` — The list of [`@ProvidedAutoMigrationSpec`](../androidx.room/provided-auto-migration-spec.md) instances for [`@AutoMigration`](../androidx.room/auto-migration.md)s that require them.

### MigrationTestHelper

**Android**
```
MigrationTestHelper(
    schemaDirectoryPath: Path,
    databasePath: Path,
    driver: SQLiteDriver,
    databaseClass: KClass<RoomDatabase>,
    databaseFactory: () -> RoomDatabase = { findAndInstantiateDatabaseImpl(databaseClass.java) },
    autoMigrationSpecs: List<AutoMigrationSpec> = emptyList()
)
```

- `schemaDirectoryPath` — The schema directory where schema files are exported.
- `databasePath` — Path of the database.
- `driver` — A driver that opens a connection to a file database.
- `databaseClass` — The [`@Database`](../androidx.room/database.md) annotated class.
- `databaseFactory` — An optional factory function to create an instance of the database.
- `autoMigrationSpecs` — The list of [`@ProvidedAutoMigrationSpec`](../androidx.room/provided-auto-migration-spec.md) instances for [`@AutoMigration`](../androidx.room/auto-migration.md)s that require them.

### MigrationTestHelper

**Native**
```
MigrationTestHelper(
    schemaDirectoryPath: String,
    fileName: String,
    driver: SQLiteDriver,
    databaseClass: KClass<RoomDatabase>,
    databaseFactory: () -> RoomDatabase = {
        findDatabaseConstructorAndInitDatabaseImpl(databaseClass)
    },
    autoMigrationSpecs: List<AutoMigrationSpec> = emptyList()
)
```

- `schemaDirectoryPath` — The schema directory where schema files are exported.
- `fileName` — Name of the database.
- `driver` — A driver that opens a connection to a file database.
- `databaseClass` — The [`@Database`](../androidx.room/database.md) annotated class.
- `databaseFactory` — The factory function to create an instance of the database.
- `autoMigrationSpecs` — The list of [`@ProvidedAutoMigrationSpec`](../androidx.room/provided-auto-migration-spec.md) instances for [`@AutoMigration`](../androidx.room/auto-migration.md)s that require them.

## Public Functions

### apply

**Android**
```
open fun apply(base: Statement, description: Description): Statement
```

JUnit `TestRule` override. Wraps the test `Statement` so the helper participates in the test lifecycle when registered with `@Rule`.

### closeWhenFinished

**Android** · Added in 2.0.0
```
open fun closeWhenFinished(db: RoomDatabase): Unit
```

Registers a database connection to be automatically closed when the test finishes. This only works if the helper is registered as a JUnit test rule via the `@Rule` annotation.

- `db` — The `RoomDatabase` instance which holds the database.

### closeWhenFinished

**Android** · Added in 2.0.0
```
open fun closeWhenFinished(db: SupportSQLiteDatabase): Unit
```

Registers a database connection to be automatically closed when the test finishes. This only works if the helper is registered as a JUnit test rule via the `@Rule` annotation.

- `db` — The database connection that should be closed after the test finishes.

### createDatabase

**Common · Android · Native** · Added in 2.7.0
```
fun createDatabase(version: Int): SQLiteConnection
```

Creates the database at the given version. Once created it can be further validated with [`runMigrationsAndValidate(version, migrations)`](#runmigrationsandvalidate). Throws `IllegalStateException` if a new database was not created.

- `version` — The version of the schema at which the database should be created.

Returns a database connection of the newly created database.

### createDatabase

**Android** · Added in 2.0.0
```
open fun createDatabase(name: String, version: Int): SupportSQLiteDatabase
```

Creates the database in the given version. If the database file already exists, it tries to delete it first; if delete fails, throws an exception.

- `name` — The name of the database.
- `version` — The version in which the database should be created.

Returns a database connection which has the schema in the requested version.

### finished

**Native**
```
fun finished(): Unit
```

Releases resources held by the helper. Called automatically when the helper is used as a test rule.

### runMigrationsAndValidate

**Common · Android · Native**
```
fun runMigrationsAndValidate(
    version: Int,
    migrations: List<Migration> = emptyList()
): SQLiteConnection
```

Runs the given set of migrations on the existing database once created via [`createDatabase(version)`](#createdatabase).

This uses the same algorithm Room performs to choose migrations, so the [`Migration`](../androidx.room.migration/migration.md) instances provided must be sufficient to bring the database from its current version to the desired version. If the database contains [`@AutoMigration`](../androidx.room/auto-migration.md)s, those are already included in the list of migrations to execute if necessary; provided manual migrations take precedence over auto migrations when their paths overlap.

Once migrations are done, this validates the database schema to ensure the migration resulted in the expected schema. Throws `IllegalStateException` if schema validation fails.

- `version` — The final version the database should migrate to.
- `migrations` — The list of migrations used to attempt the database migration.

Returns a database connection of the migrated database.

### runMigrationsAndValidate

**Android** · Added in 2.0.0
```
open fun runMigrationsAndValidate(
    name: String,
    version: Int,
    validateDroppedTables: Boolean,
    vararg migrations: Migration
): SupportSQLiteDatabase
```

Runs the given set of migrations on the provided database. Handling of dropped tables depends on `validateDroppedTables`: if `true`, verification fails on any table not registered in the database; if `false`, extra tables are ignored (matching the runtime library behavior). Throws `IllegalStateException` if schema validation fails.

- `name` — The database name. You must first create this database via [`createDatabase(name, version)`](#createdatabase_1).
- `version` — The final version after applying the migrations.
- `validateDroppedTables` — If `true`, validation fails if the database has unknown tables.
- `migrations` — The list of available migrations.

## Protected Functions

These are JUnit `TestWatcher` lifecycle overrides, invoked by the rule framework rather than called directly.

### failed

**Android**
```
protected open fun failed(e: Throwable, description: Description): Unit
```

### finished

**Android**
```
protected open fun finished(description: Description?): Unit
```

### skipped

**Android**
```
protected open fun skipped(e: AssumptionViolatedException, description: Description): Unit
```

**Deprecated — deprecated in Java.**

### starting

**Android**
```
protected open fun starting(description: Description?): Unit
```

### succeeded

**Android**
```
protected open fun succeeded(description: Description): Unit
```
