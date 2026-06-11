# API Reference

> Last updated 2026-06-10

# RxDataStore

> Added in 1.0.0

```
class RxDataStore<T : Any> : Disposable
```

A [`DataStore`](../androidx.datastore.core/data-store.md) that exposes RxJava 3 operations. Build one with [`RxDataStoreBuilder`](rx-data-store-builder.md). Implements RxJava's `Disposable`.

## Public Functions

### data

```
@ExperimentalCoroutinesApi
fun data(): Flowable<T>
```

Gets a `Flowable` of the data from DataStore — see [`DataStore.data`](../androidx.datastore.core/data-store.md#data). Provides efficient, cached (when possible) access to the latest durably persisted state; the flow always either emits a value or throws the exception hit while reading from disk, and collecting again retries the read. Do not layer a cache on top of this — use `data().firstOrError()` to access a single snapshot. The `Flowable` completes with an `IOException` when an exception is encountered while reading data.

### updateDataAsync

```
@ExperimentalCoroutinesApi
fun updateDataAsync(transform: Function<T, Single<T>>): Single<T>
```

See [`DataStore.updateData`](../androidx.datastore.core/data-store.md#updatedata). Updates the data transactionally in an atomic read-modify-write operation. All operations are serialized, and the `transform` is itself async so it can perform heavy work such as RPCs. The returned `Single` emits the transformed snapshot once it has been persisted durably to disk (after which `data()` reflects the update); if the transform or write fails, the transaction is aborted and the `Single` completes with the error. The transform runs on the scheduler the DataStore was constructed with. Emits the error thrown by the transform function if any.

### dispose

```
open fun dispose(): Unit
```

Disposes of the DataStore. Wait for the `Completable` returned by `shutdownComplete()` to confirm shutdown.

### isDisposed

```
open fun isDisposed(): Boolean
```

Returns whether this DataStore is closed.

### shutdownComplete

```
fun shutdownComplete(): Completable
```

Returns a `Completable` that completes once the DataStore has fully shut down. It is not safe to create a new DataStore with the same file name until this completes.

## Public Properties

### isDisposed

```
open val isDisposed: Boolean
```

Whether this DataStore is closed.
