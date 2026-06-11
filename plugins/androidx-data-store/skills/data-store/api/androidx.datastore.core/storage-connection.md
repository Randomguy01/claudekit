# API Reference

> Last updated 2026-06-10

# StorageConnection

> Added in 1.1.0

```
interface StorageConnection<T : Any?> : Closeable
```

Provides a way to read and write a particular type of data. StorageConnections are created from [`Storage`](storage.md) objects. Extends [`Closeable`](closeable.md).

## Public Functions

### readScope

```
suspend fun <R : Any?> readScope(
    block: suspend ReadScope<T>.(locked: Boolean) -> R
): R
```

Creates a [`ReadScope`](read-scope.md) for storage reads, trying to obtain a read lock.

- `block` — the code performed within this scope; receives a `locked` parameter that is true if the lock was acquired.

Throws [`IOException`](io-exception.md) on unrecoverable read error.

### writeScope

> Added in 1.1.0

```
suspend fun writeScope(block: suspend WriteScope<T>.() -> Unit): Unit
```

Creates a [`WriteScope`](write-scope.md) guaranteed to have a single writer, also ensuring any reads within the scope see the most current data.

Throws [`IOException`](io-exception.md) on unrecoverable write error.

## Public Properties

### coordinator

> Added in 1.1.0

```
val coordinator: InterProcessCoordinator
```

Provides an [`InterProcessCoordinator`](inter-process-coordinator.md) to guarantee data consistency across multiple threads and processes.

## Extension Functions

[`StorageConnection.readData`](package-functions.md#storageconnectionreaddata) and [`StorageConnection.writeData`](package-functions.md#storageconnectionwritedata) — see [package functions](package-functions.md).

## Inherited Functions

From [`Closeable`](closeable.md): `close()`.
