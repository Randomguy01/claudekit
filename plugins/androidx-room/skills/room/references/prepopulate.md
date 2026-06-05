# Prepopulating

**Requires Room 2.2.0+**

Prepopulating a database starts the app with a database that is already loaded with a specific set of data.

**In-memory Room databases don't support prepopulating the database using `createFromAsset()` or `createFromFile()`**

## Prepopulate from an App Asset

The `createFromAsset()` method accepts a string argument that contains a relative path from the `assets/` directory to the prepackaged database file.

Call the `createFromAsset()` method from your `RoomDatabase.Builder` with a prepackaged database file that is located anywhere in the app's `assets/` directory, before calling `build()`.

```kotlin
Room.databaseBuilder(appContext, AppDatabase::class.java, "Sample.db")
    .createFromAsset("database/myapp.db")
    .build()
```

**Room validates the schema of the prepackaged database to ensure that its schema matches the database**

## Prepopulate from the File System

The `createFromFile()` method accepts a `File` argument for the prepackaged database file. Room creates a copy of the designated file rather than opening it directly.

**The app must have read permissions on the file**

Call the `createFromFile()` method from your `RoomDatabase.Builder` with a prepackaged database file that is located anywhere in the device's file system *except* your app's `assets/` directory, before calling `build()`.

```kotlin
Room.databaseBuilder(appContext, AppDatabase::class.java, "Sample.db")
    .createFromFile(File("mypath"))
    .build()
```

## Handle Migrations That Include Prepackaged Databases

Prepackaged database files can change the way your Room database handles fallback migrations.

If you include a prepackaged database file with the same number as the target version, Room attempts to populate the newly recreated database with the contents of the prepackaged database file after performing the destructive migration.

For more information on Room database migrations, see [Migrating Room databases](migrate.md).
