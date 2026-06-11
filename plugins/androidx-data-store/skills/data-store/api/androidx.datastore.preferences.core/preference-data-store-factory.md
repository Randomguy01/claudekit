# API Reference

> Last updated 2026-06-10

# PreferenceDataStoreFactory

> Added in 1.0.0

```
object PreferenceDataStoreFactory
```

Factory for creating `DataStore<Preferences>` instances. Never create more than one instance for a given file — doing so can break all DataStore functionality. Manage your instance as a singleton.

## Public Functions

### create

```
fun create(
    storage: Storage<Preferences>,
    corruptionHandler: ReplaceFileCorruptionHandler<Preferences>? = null,
    migrations: List<DataMigration<Preferences>> = listOf(),
    scope: CoroutineScope = CoroutineScope(ioDispatcher() + SupervisorJob())
): DataStore<Preferences>
```

Creates a `DataStore<Preferences>` backed by the given [`Storage`](../androidx.datastore.core/storage.md).

- `storage` — defines where and how the preferences are stored.
- `corruptionHandler` — invoked on a [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) while reading; see [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md).
- `migrations` — run before any data access; must be idempotent.
- `scope` — the scope in which IO operations and transform functions execute.

### create

**Android**

```
fun create(
    corruptionHandler: ReplaceFileCorruptionHandler<Preferences>? = null,
    migrations: List<DataMigration<Preferences>> = listOf(),
    scope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob()),
    produceFile: () -> File
): DataStore<Preferences>
```

Creates a `DataStore<Preferences>` acting on the file returned by `produceFile`.

- `produceFile` — returns the file the DataStore acts on. Must return the same path every time and have the `preferences_pb` extension; the file is created if it doesn't exist. No two instances may act on the same file simultaneously.
- `corruptionHandler`, `migrations`, `scope` — as in the [`Storage`](#create) overload.

### createWithPath

```
fun createWithPath(
    corruptionHandler: ReplaceFileCorruptionHandler<Preferences>? = null,
    migrations: List<DataMigration<Preferences>> = listOf(),
    scope: CoroutineScope = CoroutineScope(ioDispatcher() + SupervisorJob()),
    produceFile: () -> Path
): DataStore<Preferences>
```

Creates a `DataStore<Preferences>` using an okio `Path`.

- `produceFile` — returns the okio `Path` the DataStore acts on. Must return the same path every time and have the `preferences_pb` extension; created if it doesn't exist.
- `corruptionHandler`, `migrations`, `scope` — as above.
