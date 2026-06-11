# API Reference

> Last updated 2026-06-10

# Storage

> Added in 1.1.0

```
interface Storage<T : Any?>
```

Storage provides a way to create [`StorageConnection`](storage-connection.md)s that read and write a particular type of data. Storage is used to construct DataStore objects and encapsulates all the specifics of the data format and persistence. Implementers provide the specifics of how and where the data is stored.

## Known Direct Subtypes

| | |
|---|---|
| [`FileStorage`](file-storage.md) | The Java IO `File` version of the `Storage` interface. |
| [`OkioStorage`](../androidx.datastore.core.okio/okio-storage.md) | Okio implementation of `Storage`, providing cross-platform IO using the Okio library. |
| [`WebStorage`](../androidx.datastore.core.okio/web-storage.md) | |

## Public Functions

### createConnection

> Added in 1.1.0

```
fun createConnection(): StorageConnection<T>
```

Creates a [`StorageConnection`](storage-connection.md) for reading and writing the underlying storage. Should be closed after usage.

Throws [`IOException`](io-exception.md) on unrecoverable IO error when trying to access the underlying storage.
