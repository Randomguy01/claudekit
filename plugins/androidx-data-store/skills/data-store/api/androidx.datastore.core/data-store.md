# API Reference

> Last updated 2026-06-10

# DataStore

> Added in 1.0.0

```
interface DataStore<T : Any?>
```

DataStore provides a safe and durable way to store small amounts of data, such as preferences and application state. It does **not** support partial updates — if any field is modified, the whole object is serialized and persisted to disk. For partial updates, consider Room (SQLite).

DataStore provides ACID guarantees, is thread-safe, and is non-blocking. It addresses these design shortcomings of `SharedPreferences`:

1. The synchronous API encourages StrictMode violations.
2. `apply()` and `commit()` have no mechanism for signalling errors.
3. `apply()` blocks the UI thread on `fsync()`.
4. Not durable — it can return state that is not yet persisted.
5. No consistency or transactional semantics.
6. Throws runtime exceptions on parsing errors.
7. Exposes mutable references to its internal state.

## Nested Types

| | |
|---|---|
| [`DataStore.Builder`](data-store-builder.md) | Builder for `DataStore`. |

## Public Functions

### updateData

```
suspend fun updateData(transform: suspend (t) -> T): T
```

Updates the data transactionally in an atomic read-modify-write operation. All operations are serialized, and the transform itself is a coroutine, so it can perform heavy work such as RPCs.

The coroutine completes once the data has been persisted durably to disk (after which [`data`](#data) reflects the update). If the transform or write fails, the transaction is aborted and an exception is thrown.

Returns the snapshot returned by the transform. Throws [`IOException`](io-exception.md) when writing to disk fails, or any `Exception` thrown by the transform.

## Public Properties

### data

> Added in 1.0.0

```
val data: Flow<T>
```

Provides efficient, cached (when possible) access to the latest durably persisted state. The flow always either emits a value or throws an exception encountered while reading from disk; if it throws, collecting again retries the read.

Do not layer a cache on top of this API — it makes consistency impossible to guarantee. Use `data.first()` to access a single snapshot.

Throws [`IOException`](io-exception.md) when reading data fails.

## Extension Functions

[`DataStore<Preferences>.edit`](../androidx.datastore.preferences.core/package-functions.md#datastoreedit) — transactional edit helper for a Preferences DataStore, from `androidx.datastore.preferences.core`.
