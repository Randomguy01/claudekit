# API Reference

> Last updated 2026-06-10

# WebStorage

**JavaScript**

```
class WebStorage<T : Any?> : Storage
```

A web ([`Storage`](../androidx.datastore.core/storage.md)) implementation backed by the browser's `localStorage`/`sessionStorage`, selected via [`WebStorageType`](web-storage-type.md).

## Public Constructors

### WebStorage

**JavaScript**

```
<T : Any?> WebStorage(
    serializer: OkioSerializer<T>,
    name: String,
    storageType: WebStorageType
)
```

- `serializer` — the [`OkioSerializer`](okio-serializer.md) for `T`.
- `name` — the storage key name.
- `storageType` — the [`WebStorageType`](web-storage-type.md) (local or session).

## Public Functions

### createConnection

**JavaScript**

```
open fun createConnection(): StorageConnection<T>
```

Creates a [`StorageConnection`](../androidx.datastore.core/storage-connection.md) for reading and writing the underlying storage. Should be closed after usage.

Throws an `IOException` on unrecoverable IO error when trying to access the underlying storage.
