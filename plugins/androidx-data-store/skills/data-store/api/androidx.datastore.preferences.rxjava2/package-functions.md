# API Reference

> Last updated 2026-06-10

# androidx.datastore.preferences.rxjava2 — Top-Level Functions

The package-level helper in `androidx.datastore.preferences.rxjava2`.

## Top-Level Functions

### rxPreferencesDataStore

```
fun rxPreferencesDataStore(
    name: String,
    corruptionHandler: ReplaceFileCorruptionHandler<Preferences>? = null,
    produceMigrations: (Context) -> List<DataMigration<Preferences>> = { listOf() },
    scheduler: Scheduler = Schedulers.io()
): ReadOnlyProperty<Context, RxDataStore<Preferences>>
```

Creates a property delegate for a single-process Preferences [`RxDataStore`](../androidx.datastore.rxjava2/rx-data-store.md). Call this only once per file (at the top level); all usages of the DataStore should reference the same instance. The receiver type for the property delegate must be a `Context`. Use only from a single application in a single classloader in a single process.

```kotlin
val Context.myRxDataStore by rxPreferencesDataStore("filename")

class SomeClass(val context: Context) {
   fun update(): Single<Preferences> = context.myRxDataStore.updateDataAsync {...}
}
```

- `name` — the name of the preferences. The preferences are stored in a file in the `datastore/` subdirectory of the application context's files directory, generated using [`Context.preferencesDataStoreFile`](../androidx.datastore.preferences/package-functions.md#contextpreferencesdatastorefile).
- `corruptionHandler` — the [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md) invoked if DataStore encounters a [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) when reading data.
- `produceMigrations` — produces the [`DataMigration`](../androidx.datastore.core/data-migration.md)s; the application `Context` is passed in. Migrations run before any data access. Each producer and migration may run more than once.
- `scheduler` — the `Scheduler` on which IO operations and transform functions execute.

Returns a property delegate that manages the DataStore as a singleton.
