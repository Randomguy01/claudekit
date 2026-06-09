# Migrate

Preserve the user data already in the on-device database when an app update changes the schema.

Room supports both automated and manual options for incremental migration. Automatic migrations work for most basic schema changes, but you might need to manually define migration paths for more complex changes.

## Automated Migrations

**Requires Room 2.4.0-alpha01+**

To declare an automated migration between two database versions, add an `@AutoMigration` annotation to the `autoMigrations` property in `@Database`:

```kotlin
// Database class before the version update.
@Database(
  version = 1,
  entities = [User::class]
)
abstract class AppDatabase : RoomDatabase() {
  ...
}

// Database class after the version update.
@Database(
  version = 2,
  entities = [User::class],
  autoMigrations = [
    AutoMigration (from = 1, to = 2)
  ]
)
abstract class AppDatabase : RoomDatabase() {
  ...
}
```

> [!NOTE]
> Automated Room migrations rely on the generated database schema for both the old and new versions. If `exportSchema` is set to `false`, or if you haven't yet compiled the database with the new version number, automated migrations fail.

### Automatic Migration Specifications

If Room detects ambiguous schema changes and it can't generate a migration plan without more input, it throws a compile-time error. Then, you must implement an [`AutoMigrationSpec`](../api/androidx.room.migration/auto-migration-spec.md). This occurs when a migration involves one of the following:
- Deleting or renaming a table.
- Deleting or renaming a column.

Use `AutoMigrationSpec` to give Room the additional information that it needs to correctly generate migration paths. Define a static class that implements `AutoMigrationSpec` in your `RoomDatabase` class and annotate it with one or more of the following:
- [`@DeleteTable`](../api/androidx.room/delete-table.md)
- [`@RenameTable`](../api/androidx.room/rename-table.md)
- [`@DeleteColumn`](../api/androidx.room/delete-column.md)
- [`@RenameColumn`](../api/androidx.room/rename-column.md)

To use the `AutoMigrationSpec` implementation for an automated migration, set the `spec` property in the corresponding `@AutoMigration` annotation:

```kotlin
@Database(
  version = 2,
  entities = [User::class],
  autoMigrations = [
    AutoMigration (
      from = 1,
      to = 2,
      spec = AppDatabase.MyAutoMigration::class
    )
  ]
)
abstract class AppDatabase : RoomDatabase() {
  @RenameTable(fromTableName = "User", toTableName = "AppUser")
  class MyAutoMigration : AutoMigrationSpec
  ...
}
```

If you need to do more work after the automated migration completes, implement [`onPostMigrate()`](../api/androidx.room.migration/auto-migration-spec.md). If you implement this method in your `AutoMigrationSpec`, Room calls it after the automated migration completes.

> [!NOTE]
> In Kotlin, if you have multiple migrations of the same type, use a container annotation such as [`@RenameTable.Entries`](../api/androidx.room/rename-table.md).

## Manual Migrations

For complex schema changes, Room might not be able to generate a migration path automatically. If you decide to split the data in a table into two tables, Room can't tell how to perform this split. In cases like these, you must manually define a migration path by implementing a [`Migration`](../api/androidx.room.migration/migration.md) class.

A `Migration` class explicitly defines a migration path between a `startVersion` and an `endVersion` by overriding the [`Migration.migrate()`](../api/androidx.room.migration/migration.md) method. Add the `Migration` classes to the database builder using the [`addMigrations()`](../api/androidx.room/database.md) method:

```kotlin
val MIGRATION_1_2 = object : Migration(1, 2) {
  override fun migrate(database: SupportSQLiteDatabase) {
    database.execSQL("CREATE TABLE `Fruit` (`id` INTEGER, `name` TEXT, " +
      "PRIMARY KEY(`id`))")
  }
}

val MIGRATION_2_3 = object : Migration(2, 3) {
  override fun migrate(database: SupportSQLiteDatabase) {
    database.execSQL("ALTER TABLE Book ADD COLUMN pub_year INTEGER")
  }
}

Room.databaseBuilder(applicationContext, MyDb::class.java, "database-name")
  .addMigrations(MIGRATION_1_2, MIGRATION_2_3).build()
```

> [!CAUTION]
> To keep your migration logic working as expected, use full queries instead of referencing constants that represent the queries.

You can use automated migrations for some versions and manual migrations for others. If you define both for the same version, Room uses the manual migration.

## Test Migrations

An incorrectly defined migration can cause your app to crash. To preserve your app's stability, test your migrations. Room provides a `room-testing` Maven artifact to assist with the testing process for both automated and manual migrations. For this artifact to work, you must first export your database's schema.

### Export Schemas

Room can export your database's schema information into a JSON file at compile time. The exported JSON files represent your database's schema history. Store these files in your version control system so Room can create lower versions of the database for testing purposes and to enable auto-migration generation.

#### Set Schema Location Using Room Gradle Plugin

**Requires Room 2.6.0+**

Apply the [Room Gradle Plugin](https://developer.android.com/jetpack/androidx/releases/room#gradle-plugin) and use the `room` extension to specify the schema directory.

```kotlin
plugins {
  id("androidx.room")
}

room {
  schemaDirectory("$projectDir/schemas")
}
```

If your database schema differs based on the variant, flavor, or build type, you must specify different locations by using the `schemaDirectory()` configuration multiple times, each with a `variantMatchName` as the first argument. Each configuration can match one or more variants based on simple comparison with the variant name.

Make sure these are exhaustive and cover all variants. You can also include a `schemaDirectory()` without a `variantMatchName` to handle variants not matched by any of the other configurations. For example, in an app with two build flavors `demo` and `full` and two build types `debug` and `release`, the following are valid configurations:

```kotlin
room {
  // Applies to 'demoDebug' only
  schemaDirectory("demoDebug", "$projectDir/schemas/demoDebug")

  // Applies to 'demoDebug' and 'demoRelease'
  schemaDirectory("demo", "$projectDir/schemas/demo")

  // Applies to 'demoDebug' and 'fullDebug'
  schemaDirectory("debug", "$projectDir/schemas/debug")

  // Applies to variants that aren't matched by other configurations.
  schemaDirectory("$projectDir/schemas")
}
```

#### Set Schema Location Using Annotation Processor Option

If you are using version 2.5.2 or lower of Room, or if you aren't using the Room Gradle Plugin, set the schema location using the `room.schemaLocation` annotation processor option.

For correctness and performance of incremental and cached builds, you must use Gradle's [`CommandLineArgumentProvider`](https://docs.gradle.org/current/javadoc/org/gradle/process/CommandLineArgumentProvider.html) to inform Gradle about this directory.

First, copy the `RoomSchemaArgProvider` class shown below into your module's Gradle build file. The `asArguments()` method in the sample class passes `room.schemaLocation=${schemaDir.path}` to `KSP`. If you're using `KAPT` and `javac`, change this value to `-Aroom.schemaLocation=${schemaDir.path}` instead.

```kotlin
class RoomSchemaArgProvider(
  @get:InputDirectory
  @get:PathSensitive(PathSensitivity.RELATIVE)
  val schemaDir: File
) : CommandLineArgumentProvider {

  override fun asArguments(): Iterable<String> {
    // Note: If you're using KAPT and javac, change the line below to
    // return listOf("-Aroom.schemaLocation=${schemaDir.path}").
    return listOf("room.schemaLocation=${schemaDir.path}")
  }
}
```

Then configure the compile options to use the `RoomSchemaArgProvider` with the specified schema directory:

```kotlin
// For KSP, configure using KSP extension:
ksp {
  arg(RoomSchemaArgProvider(File(projectDir, "schemas")))
}

// For javac or KAPT, configure using android DSL:
android {
  ...
  defaultConfig {
    javaCompileOptions {
      annotationProcessorOptions {
        compilerArgumentProviders(
          RoomSchemaArgProvider(File(projectDir, "schemas"))
        )
      }
    }
  }
}
```

### Test a Single Migration

Add the `androidx.room:room-testing` Maven artifact from Room into your test dependencies and add the location of the exported schema as an asset folder:

```kotlin
android {
    ...
    sourceSets {
        // Adds exported schema location as test app assets.
        getByName("androidTest").assets.srcDir("$projectDir/schemas")
    }
}

dependencies {
    ...
    androidTestImplementation("androidx.room:room-testing:2.8.4")
}
```

The testing package provides a [`MigrationTestHelper`](../api/androidx.room.testing/migration-test-helper.md) class, which can read exported schema files. The package also implements the JUnit4 `TestRule` interface, so it can manage created databases.

The following example demonstrates a test for a single migration:

```kotlin
@RunWith(AndroidJUnit4::class)
class MigrationTest {
    private val TEST_DB = "migration-test"

    @get:Rule
    val helper: MigrationTestHelper = MigrationTestHelper(
            InstrumentationRegistry.getInstrumentation(),
            MigrationDb::class.java.canonicalName,
            FrameworkSQLiteOpenHelperFactory()
    )

    @Test
    @Throws(IOException::class)
    fun migrate1To2() {
        var db = helper.createDatabase(TEST_DB, 1).apply {
            // Database has schema version 1. Insert some data using SQL queries.
            // You can't use DAO classes because they expect the latest schema.
            execSQL(...)

            // Prepare for the next version.
            close()
        }

        // Re-open the database with version 2 and provide
        // MIGRATION_1_2 as the migration process.
        db = helper.runMigrationsAndValidate(TEST_DB, 2, true, MIGRATION_1_2)

        // MigrationTestHelper automatically verifies the schema changes,
        // but you need to validate that the data was migrated properly.
    }
}
```

### Test All Migrations

Include a test that covers all the migrations defined for your app's database. This helps ensure there is no discrepancy between a recently created database instance and an older instance that followed the defined migration paths.

The following example demonstrates a test for all defined migrations:

```kotlin
@RunWith(AndroidJUnit4::class)
class MigrationTest {
    private val TEST_DB = "migration-test"

    // Array of all migrations.
    private val ALL_MIGRATIONS = arrayOf(
            MIGRATION_1_2, MIGRATION_2_3, MIGRATION_3_4)

    @get:Rule
    val helper: MigrationTestHelper = MigrationTestHelper(
            InstrumentationRegistry.getInstrumentation(),
            AppDatabase::class.java.canonicalName,
            FrameworkSQLiteOpenHelperFactory()
    )

    @Test
    @Throws(IOException::class)
    fun migrateAll() {
        // Create earliest version of the database.
        helper.createDatabase(TEST_DB, 1).apply {
            close()
        }

        // Open latest version of the database. Room validates the schema
        // once all migrations execute.
        Room.databaseBuilder(
            InstrumentationRegistry.getInstrumentation().targetContext,
            AppDatabase::class.java,
            TEST_DB
        ).addMigrations(*ALL_MIGRATIONS).build().apply {
            openHelper.writableDatabase.close()
        }
    }
}
```

## Gracefully Handle Missing Migration Paths

If Room can't find a migration path to upgrade an existing database on a device to the current version, an [`IllegalStateException`](https://developer.android.com/reference/java/lang/IllegalStateException) occurs. If it is acceptable to lose existing data when a migration path is missing, call the [`fallbackToDestructiveMigration()`](https://developer.android.com/reference/kotlin/androidx/room/RoomDatabase.Builder#fallbacktodestructivemigration) builder method when you create the database:

```kotlin
Room.databaseBuilder(applicationContext, MyDb::class.java, "database-name")
        .fallbackToDestructiveMigration()
        .build()
```

This method tells Room to destructively recreate the tables in your app's database when it needs to perform an incremental migration and there is no defined migration path.

> [!WARNING]
> Setting this option in your app's database builder means Room *permanently deletes all data* from the tables in the user's database when it attempts a migration and there is no defined migration path.

If you only want Room to fall back to destructive recreation in certain situations, there are a few alternatives to `fallbackToDestructiveMigration()`:
- If specific versions of your schema history cause errors that you can't solve with migration paths, use [`fallbackToDestructiveMigrationFrom()`](https://developer.android.com/reference/kotlin/androidx/room/RoomDatabase.Builder#fallbacktodestructivemigrationfrom) instead. This method indicates that you want Room to fall back to destructive recreation only when migrating from specific versions.
- If you want Room to fall back to destructive recreation only when migrating from a higher database version to a lower one, use [`fallbackToDestructiveMigrationOnDowngrade()`](https://developer.android.com/reference/kotlin/androidx/room/RoomDatabase.Builder#fallbacktodestructivemigrationondowngrade) instead.

> [!NOTE]
> In Room 2.2.0 and higher, Room can use a prepackaged database file in some fallback migration cases instead of leaving an empty database. See [Prepopulating](prepopulate.md#handle-migrations-that-include-prepackaged-databases).

## Handle Column Default Values When Upgrading to Room 2.2.0

In Room 2.2.0 and higher, you can define a default value for a column by using the annotation [`@ColumnInfo(defaultValue = "...")`](../api/androidx.room/column-info.md). In versions lower than 2.2.0, the only way to define a default value for a column is by defining it directly in an executed SQL statement, which creates a default value that Room does not know about. This means that if a database is originally created by a version of Room lower than 2.2.0, upgrading your app to use Room 2.2.0 might require you to provide a special migration path for existing default values that you defined without using Room APIs.

For example, suppose that version 1 of a database defines a `Song` entity:

```kotlin
// Song entity, database version 1, Room 2.1.0.
@Entity
data class Song(
    @PrimaryKey
    val id: Long,
    val title: String,
)
```

Suppose also that version 2 of the same database adds a new `NOT NULL` column and defines a migration path from version 1 to version 2:

```kotlin
// Song entity, database version 2, Room 2.1.0.
@Entity
data class Song(
    @PrimaryKey
    val id: Long,
    val title: String,
    val tag: String, // Added in version 2.
)

// Migration from 1 to 2, Room 2.1.0.
val MIGRATION_1_2 = object : Migration(1, 2) {
    override fun migrate(database: SupportSQLiteDatabase) {
        database.execSQL(
            "ALTER TABLE Song ADD COLUMN tag TEXT NOT NULL DEFAULT ''")
    }
}
```

This causes a discrepancy in the underlying table between updates and fresh installs of the app. Because the default value for the `tag` column is only declared in the migration path from version 1 to version 2, any users who install the app starting from version 2 don't have the default value for `tag` in their database schema.

In versions of Room lower than 2.2.0, this discrepancy is harmless. However, if the app later upgrades to use Room 2.2.0 or higher and changes the `Song` entity class to include a default value for `tag` using the [`@ColumnInfo`](../api/androidx.room/column-info.md) annotation, Room can then see this discrepancy. This results in failed schema validations.

To help ensure that the database schema is consistent across all users when column default values are declared in your earlier migration paths, do the following the first time you upgrade your app to use Room 2.2.0 or higher:
1. Declare column default values in their respective entity classes using the `@ColumnInfo` annotation.
2. Increase the database version number by 1.
3. Define a migration path to the new version that implements the [drop and recreate strategy](https://www.sqlite.org/lang_altertable.html#otheralter) to add the necessary default values to the existing columns.

> [!NOTE]
> If your app's database falls back to destructive migrations, or if no migration paths add a column with a default value, this process is not required.

The following example demonstrates this process:

```kotlin
// Migration from 2 to 3, Room 2.2.0.
val MIGRATION_2_3 = object : Migration(2, 3) {
    override fun migrate(database: SupportSQLiteDatabase) {
        database.execSQL("""
                CREATE TABLE new_Song (
                    id INTEGER PRIMARY KEY NOT NULL,
                    name TEXT,
                    tag TEXT NOT NULL DEFAULT ''
                )
                """.trimIndent())
        database.execSQL("""
                INSERT INTO new_Song (id, name, tag)
                SELECT id, name, tag FROM Song
                """.trimIndent())
        database.execSQL("DROP TABLE Song")
        database.execSQL("ALTER TABLE new_Song RENAME TO Song")
    }
}
```
