# API Reference

> Last updated 2026-06-10

# DataStoreFactory

> Added in 1.0.0

```
object DataStoreFactory
```

Public factory for creating [`DataStore`](data-store.md) instances.

## Public Functions

### create

```
fun <T : Any?> create(
    storage: Storage<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    migrations: List<DataMigration<T>> = listOf(),
    scope: CoroutineScope = CoroutineScope(ioDispatcher() + SupervisorJob())
): DataStore<T>
```

Creates a [`DataStore`](data-store.md) backed by the given [`Storage`](storage.md).

### create

**Android**

```
fun <T : Any?> create(
    serializer: Serializer<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    migrations: List<DataMigration<T>> = listOf(),
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob()),
    produceFile: () -> File
): DataStore<T>
```

Creates a single-process DataStore. Never create more than one instance for a given file — doing so breaks all DataStore functionality, and DataStore throws `IllegalStateException` when reading or updating if multiple instances are active for the same file. Manage your instance as a singleton. A DataStore is active as long as its scope is active.

`T` must be immutable; mutating a type used in DataStore invalidates its guarantees. Protocol buffers are strongly recommended.

If `produceFile` returns a file in User-Encrypted (UE) storage via a `Context`, that file is not available during direct boot and may fail with a `DirectBootUsageException`/`FileNotFoundException` or silently. For direct-boot use, use [`createInDeviceProtectedStorage`](#createindeviceprotectedstorage).

- `serializer` — the [`Serializer`](serializer.md) for the immutable type `T`.
- `corruptionHandler` — invoked when DataStore hits a [`CorruptionException`](corruption-exception.md) while reading; see [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md).
- `migrations` — run before any data access; must be idempotent.
- `scope` — the scope in which IO operations and transform functions execute.
- `produceFile` — returns the file the DataStore acts on. Must return the same path every time; no two instances may act on the same file simultaneously.

### createInDeviceProtectedStorage

**Android**

```
@RequiresApi(value = 24)
fun <T : Any?> createInDeviceProtectedStorage(
    context: Context,
    fileName: String,
    serializer: Serializer<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    migrations: List<DataMigration<T>> = listOf(),
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
): DataStore<T>
```

Creates a single-process DataStore usable during direct boot. Always creates the DataStore in Device-Encrypted storage.

- `context` — the device-protected storage `Context` used to create the file.
- `fileName` — the filename, relative to `Context.createDeviceProtectedStorageContext().filesDir`, that DataStore acts on. The `File` is obtained from [`Context.deviceProtectedDataStoreFile`](package-functions.md#contextdeviceprotecteddatastorefile), in the `datastore/` subdirectory of device-encrypted storage.
- `serializer` — the [`Serializer`](serializer.md) for the immutable type `T`.
- `corruptionHandler` — invoked on a [`CorruptionException`](corruption-exception.md) while reading.
- `migrations` — run before any data access; must be idempotent.
- `scope` — the scope in which IO operations and transform functions execute.
