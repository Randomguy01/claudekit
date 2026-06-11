# API Reference

> Last updated 2026-06-10

# OkioStorage

> Added in 1.1.0

```
class OkioStorage<T : Any?> : Storage
```

Okio implementation of the [`Storage`](../androidx.datastore.core/storage.md) interface, providing cross-platform IO using the Okio library.

## Public Constructors

### OkioStorage

```
<T : Any?> OkioStorage(
    fileSystem: FileSystem,
    serializer: OkioSerializer<T>,
    coordinatorProducer: (Path, FileSystem) -> InterProcessCoordinator = { path, _ ->
        createSingleProcessCoordinator(path)
    },
    producePath: () -> Path
)
```

- `fileSystem` — the okio `FileSystem` to perform IO operations on.
- `serializer` — the [`OkioSerializer`](okio-serializer.md) for `T`.
- `coordinatorProducer` — produces the [`InterProcessCoordinator`](../androidx.datastore.core/inter-process-coordinator.md) that coordinates IO operations across processes if needed. Defaults to a [single-process coordinator](package-functions.md#createsingleprocesscoordinator), which does not support cross-process use cases.
- `producePath` — the file producer that returns the okio `Path` to be read and written.

## Public Functions

### createConnection

> Added in 1.1.0

```
open fun createConnection(): StorageConnection<T>
```

Creates a [`StorageConnection`](../androidx.datastore.core/storage-connection.md) for reading and writing the underlying storage. Should be closed after usage.

Throws an okio `IOException` on unrecoverable IO error when trying to access the underlying storage.
