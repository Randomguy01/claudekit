# API Reference

> Last updated 2026-06-10

# InterProcessCoordinator

> Added in 1.1.0

```
interface InterProcessCoordinator
```

Provides functionality that lets DataStore instances coordinate concurrent work across multiple threads and processes to guarantee data consistency. Typically you use the default coordinators provided by the library — [`createSingleProcessCoordinator`](package-functions.md#createsingleprocesscoordinator) when DataStore is used in a single process, and [`createMultiProcessCoordinator`](package-functions.md#createmultiprocesscoordinator) for a DataStore accessed in multiple processes.

## Public Functions

### getVersion

```
suspend fun getVersion(): Int
```

Atomically get the current version. [`DataStore`](data-store.md) instances for the same data use this to access the shared version for their cached data and internal state; concurrent access must guarantee data consistency.

### incrementAndGetVersion

```
suspend fun incrementAndGetVersion(): Int
```

Atomically increment the version and return the new value. The number of calls is an internal DataStore implementation detail — implementers must not make assumptions based on the increment count.

### lock

```
suspend fun <T : Any?> lock(block: suspend () -> T): T
```

Get the exclusive lock shared by the coordinators of DataStore instances (even across processes) to run a suspending `block` returning `T`, guaranteeing one-at-a-time execution. If another process or thread holds the lock, this waits until it is available.

- `block` — the code performed while holding the lock.

### tryLock

```
suspend fun <T : Any?> tryLock(block: suspend (Boolean) -> T): T
```

Attempt to get the exclusive lock and run `block` regardless of the result. `block` receives a `Boolean` that is true if the attempt succeeded. On failure, `block` runs immediately without waiting for the lock.

- `block` — the code performed after attempting to acquire the lock; receives whether the attempt succeeded.

## Public Properties

### updateNotifications

> Added in 1.1.0

```
val updateNotifications: Flow<Unit>
```

A flow that emits `Unit` when the data for the DataStore changes. [`DataStore`](data-store.md) collects this flow as the signal to invalidate its cache and re-read data from disk.
