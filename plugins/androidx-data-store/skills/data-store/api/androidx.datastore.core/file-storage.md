# API Reference

> Last updated 2026-06-10

# FileStorage

> Added in 1.1.0

**Android**

```
class FileStorage<T : Any?> : Storage
```

The Java IO `File` version of the [`Storage`](storage.md) interface. Reads and writes to a given file location.

## Public Constructors

### FileStorage

**Android**

```
<T : Any?> FileStorage(
    serializer: Serializer<T>,
    coordinatorProducer: (File) -> InterProcessCoordinator = {
        createSingleProcessCoordinator(it)
    },
    produceFile: () -> File
)
```

- `serializer` — the [`Serializer`](serializer.md) that reads and writes `T` to and from a byte array.
- `coordinatorProducer` — produces the [`InterProcessCoordinator`](inter-process-coordinator.md) that coordinates IO operations across processes if needed. Defaults to a single-process coordinator, which does not support cross-process use cases.
- `produceFile` — the file producer that returns the file to be read and written.

## Public Functions

### createConnection

**Android**

```
open fun createConnection(): StorageConnection<T>
```

Creates a [`StorageConnection`](storage-connection.md) for reading and writing the underlying storage. Should be closed after usage.

Throws [`IOException`](io-exception.md) on unrecoverable IO error when trying to access the underlying storage.
