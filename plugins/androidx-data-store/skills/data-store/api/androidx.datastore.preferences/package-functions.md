# API Reference

> Last updated 2026-06-10

# androidx.datastore.preferences — Top-Level & Extension Functions

The `androidx.datastore.preferences` package contains no types of its own — only the package-level helpers that build a Preferences DataStore and migrate from `SharedPreferences`. The [`Preferences`](../androidx.datastore.preferences.core/preferences.md) type and its `Key`/`MutablePreferences` API live in [`androidx.datastore.preferences.core`](../androidx.datastore.preferences.core/preferences.md).

## Top-Level Functions

### SharedPreferencesMigration

```
fun SharedPreferencesMigration(
    produceSharedPreferences: () -> SharedPreferences,
    keysToMigrate: Set<String> = MIGRATE_ALL_KEYS
): SharedPreferencesMigration<Preferences>
```

Creates a [`SharedPreferencesMigration`](../androidx.datastore.migrations/shared-preferences-migration.md) for a Preferences DataStore.

This migration only supports the basic `SharedPreferences` types: boolean, float, int, long, string, and string set. Other types returned by `getAll` are ignored.

- `produceSharedPreferences` — returns the `SharedPreferences` instance to migrate from.
- `keysToMigrate` — the keys to migrate, mapped to `Preferences` with the same values. A key already present in the new `Preferences` is not migrated again; a key absent from `SharedPreferences` is not migrated. Defaults to `MIGRATE_ALL_KEYS` (all keys).

### SharedPreferencesMigration

> Added in 1.0.0

```
fun SharedPreferencesMigration(
    context: Context,
    sharedPreferencesName: String,
    keysToMigrate: Set<String> = MIGRATE_ALL_KEYS
): SharedPreferencesMigration<Preferences>
```

Creates a [`SharedPreferencesMigration`](../androidx.datastore.migrations/shared-preferences-migration.md) for a Preferences DataStore. If the `SharedPreferences` is empty once the migration completes, this migration attempts to delete it.

- `context` — context used to get the `SharedPreferences`.
- `sharedPreferencesName` — the name of the `SharedPreferences`.
- `keysToMigrate` — the keys to migrate (see the overload above). Defaults to `MIGRATE_ALL_KEYS`.

### preferencesDataStore

```
fun preferencesDataStore(
    name: String,
    corruptionHandler: ReplaceFileCorruptionHandler<Preferences>? = null,
    produceMigrations: (Context) -> List<DataMigration<Preferences>> = { listOf() },
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
): ReadOnlyProperty<Context, DataStore<Preferences>>
```

Creates a property delegate for a single-process Preferences DataStore. Call this only once per file, at the top level; every usage of the DataStore must reference the same instance. The receiver of the property delegate must be a `Context`. Use it only from a single application, in a single classloader, in a single process.

```kotlin
val Context.myDataStore by preferencesDataStore("filename")

class SomeClass(val context: Context) {
    suspend fun update() = context.myDataStore.edit { ... }
}
```

The returned [`ReadOnlyProperty`](https://kotlinlang.org/api/core/kotlin-stdlib/kotlin.properties/-read-only-property/index.html) manages the [`DataStore`](../androidx.datastore.core/data-store.md) as a singleton.

- `name` — the name of the preferences. Stored in a file in the `datastore/` subdirectory of the application context's files directory, generated via [`Context.preferencesDataStoreFile`](#contextpreferencesdatastorefile).
- `corruptionHandler` — invoked when DataStore encounters a [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) while reading data; see [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md).
- `produceMigrations` — produces the [`DataMigration`](../androidx.datastore.core/data-migration.md)s to run before any data access. The application `Context` is passed to the callback. Each producer and migration may run more than once on failure.
- `scope` — the scope in which IO operations and transform functions execute.

## Extension Functions

### Context.preferencesDataStoreFile

> Added in 1.0.0

```
fun Context.preferencesDataStoreFile(name: String): File
```

Generates the `File` object for a Preferences DataStore from the given context and name, in the `datastore/` subdirectory of the application context's files directory. Public to allow testing and backwards compatibility — for example when moving from the `preferencesDataStore` delegate or `context.createDataStore` to `PreferencesDataStoreFactory`.

Do **not** use the file outside of DataStore.

- `name` — the name of the preferences.
