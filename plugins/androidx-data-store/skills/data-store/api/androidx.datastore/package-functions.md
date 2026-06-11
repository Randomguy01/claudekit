# API Reference

> Last updated 2026-06-10

# androidx.datastore — Top-Level & Extension Functions

The `androidx.datastore` package contains no types of its own — only the package-level helpers that wire a typed DataStore to an Android `Context`. The DataStore types themselves (`DataStore`, `Serializer`, `DataMigration`, and the corruption handlers) live in [`androidx.datastore.core`](../androidx.datastore.core/data-store.md).

## Top-Level Functions

### dataStore

```
fun <T : Any?> dataStore(
    fileName: String,
    serializer: Serializer<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    produceMigrations: (Context) -> List<DataMigration<T>> = { listOf() },
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
): ReadOnlyProperty<Context, DataStore<T>>
```

Creates a property delegate for a single-process DataStore. Call this only once per file, at the top level; every usage of the DataStore must reference the same instance. The receiver of the property delegate must be a `Context`. Use it only from a single application, in a single classloader, in a single process.

```kotlin
val Context.myDataStore by dataStore("filename", serializer)

class SomeClass(val context: Context) {
    suspend fun update() = context.myDataStore.updateData { ... }
}
```

The returned [`ReadOnlyProperty`](https://kotlinlang.org/api/core/kotlin-stdlib/kotlin.properties/-read-only-property/index.html) manages the DataStore as a singleton.

- `fileName` — the filename, relative to `Context.applicationContext.filesDir`, that DataStore acts on. The `File` is obtained from [`Context.dataStoreFile`](#contextdatastorefile) and created in the `datastore/` subdirectory of user-encrypted storage.
- `serializer` — the [`Serializer`](../androidx.datastore.core/serializer.md) for `T`.
- `corruptionHandler` — invoked when DataStore encounters a [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) while reading data. Serializers throw `CorruptionException` when data cannot be de-serialized.
- `produceMigrations` — produces the [`DataMigration`](../androidx.datastore.core/data-migration.md)s to run before any data access. The application `Context` is passed to the callback. Each producer and migration may run more than once, whether or not it already succeeded (e.g. because another migration or a disk write failed).
- `scope` — the scope in which IO operations and transform functions execute.

### deviceProtectedDataStore

```
@RequiresApi(value = 24)
fun <T : Any?> deviceProtectedDataStore(
    fileName: String,
    serializer: Serializer<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    produceMigrations: (Context) -> List<DataMigration<T>> = { listOf() },
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
): ReadOnlyProperty<Context, DataStore<T>>
```

Creates a property delegate for a single-process DataStore to be used in direct boot. Same contract as [`dataStore`](#datastore), but backed by device-protected storage so it is available before the user unlocks the device. Requires API 24.

The parameters match [`dataStore`](#datastore).

## Extension Functions

### Context.dataStoreFile

> Added in 1.0.0

```
fun Context.dataStoreFile(fileName: String): File
```

Generates the `File` object for a DataStore from the given context and name, as `File(context.applicationContext.filesDir, "datastore/$fileName")`. Public to allow testing and backwards compatibility — for example when moving from the `dataStore` delegate or `context.createDataStore` to `DataStoreFactory`.

Do **not** use the file outside of DataStore.

- `fileName` — the file name.
