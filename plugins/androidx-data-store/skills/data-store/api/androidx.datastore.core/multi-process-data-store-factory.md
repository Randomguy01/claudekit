# API Reference

> Last updated 2026-06-10

# MultiProcessDataStoreFactory

> Added in 1.1.0

**Android**

```
object MultiProcessDataStoreFactory
```

Factory for creating [`DataStore`](data-store.md) instances that provide cross-process eventual consistency.

## Public Functions

### create

**Android**

```
fun <T : Any?> create(
    storage: Storage<T>,
    corruptionHandler: ReplaceFileCorruptionHandler<T>? = null,
    migrations: List<DataMigration<T>> = listOf(),
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
): DataStore<T>
```

Creates a MultiProcessDataStore backed by the given [`Storage`](storage.md), providing cross-process eventual consistency. Never create more than one instance for a given file in the same process — doing so breaks all DataStore functionality, and DataStore throws `IllegalStateException` when reading or updating if multiple instances are active for the same file in the same process. Multiple instances for different files in the same process is fine.

- `storage` — the [`Storage`](storage.md) handling file reads and writes; must operate on the same file as `produceFile`.
- `corruptionHandler` — the [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md), invoked on a [`CorruptionException`](corruption-exception.md) while reading.
- `migrations` — run before any data access; must be idempotent.
- `scope` — the scope in which IO operations and transform functions execute.

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

Same as the [`Storage`](storage.md) overload, but takes a [`Serializer`](serializer.md) and a `produceFile` lambda directly.

- `serializer` — the [`Serializer`](serializer.md) for the immutable type `T`.
- `corruptionHandler` — invoked on a [`CorruptionException`](corruption-exception.md) while reading.
- `migrations` — run before any data access; must be idempotent.
- `scope` — the scope in which IO operations and transform functions execute.
- `produceFile` — returns the file the DataStore acts on. Must return the same path every time; no two instances may act on the same file simultaneously in the same process.
