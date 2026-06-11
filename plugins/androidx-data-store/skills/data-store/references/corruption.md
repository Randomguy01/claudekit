# Handling File Corruption

On rare occasions DataStore's on-disk file can become corrupted. By default DataStore does not recover from this — a read throws a `CorruptionException`. This is the same exception a `Serializer` throws from `readFrom` when it cannot parse the file's contents (as in `json-datastore.md` and `proto-datastore.md`).

A corruption handler recovers gracefully instead of letting the exception propagate: it replaces the corrupted file with a new one containing a predefined default value.

## Configure a Corruption Handler

Pass a `corruptionHandler` when constructing the DataStore. `ReplaceFileCorruptionHandler` produces the default value that replaces the corrupted file:

```kotlin
val dataStore: DataStore<Settings> = DataStoreFactory.create(
    serializer = SettingsSerializer,
    produceFile = {
        File("${context.filesDir.path}/settings.json")
    },
    corruptionHandler = ReplaceFileCorruptionHandler { Settings(exampleCounter = 0) }
)
```

> [!NOTE]
> `corruptionHandler` is a parameter on every way of constructing a DataStore — the `preferencesDataStore` and `dataStore` property delegates (see the variant references), `DataStoreFactory.create`, and `MultiProcessDataStoreFactory.create` (see `multiprocess.md`). Add it wherever the store is created.

> [!WARNING]
> Recovery discards the corrupted file: its previous contents are gone, replaced by the default value the handler returns.
