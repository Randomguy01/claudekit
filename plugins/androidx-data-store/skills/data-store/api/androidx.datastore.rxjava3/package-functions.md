# API Reference

> Last updated 2026-06-10

# androidx.datastore.rxjava3 — Top-Level Functions

The package-level helper in `androidx.datastore.rxjava3`.

## Top-Level Functions

### rxDataStore

> Added in 1.0.0

```
fun <T : Any> rxDataStore(
    fileName: String,
    serializer: Serializer<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    produceMigrations: (Context) -> List<DataMigration<T>> = { listOf() },
    scheduler: Scheduler = Schedulers.io()
): ReadOnlyProperty<Context, RxDataStore<T>>
```

Creates a property delegate for a single-process [`RxDataStore`](rx-data-store.md). Call this only once per file (at the top level); all usages of the DataStore should reference the same instance. The receiver type for the property delegate must be a `Context`. Use only from a single application in a single classloader in a single process.

```kotlin
val Context.myRxDataStore by rxDataStore("filename", serializer)

class SomeClass(val context: Context) {
   fun update(): Single<Settings> = context.myRxDataStore.updateDataAsync {...}
}
```

- `fileName` — the filename relative to `Context.filesDir` that DataStore acts on; the file is `File(context.filesDir, "datastore/$fileName")`. No two DataStore instances should act on the same file at the same time.
- `serializer` — the [`Serializer`](../androidx.datastore.core/serializer.md) to serialize and deserialize on-disk data to type `T`.
- `corruptionHandler` — the [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md) invoked if DataStore encounters a [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) when reading data.
- `produceMigrations` — produces the [`DataMigration`](../androidx.datastore.core/data-migration.md)s; the application `Context` is passed in. Migrations run before any data access. Each producer and migration may run more than once.
- `scheduler` — the `Scheduler` on which IO operations and transform functions execute.

Returns a property delegate that manages the DataStore as a singleton.
