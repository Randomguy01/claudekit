# API Reference

> Last updated 2026-06-08

# InvalidationTracker

> Added in 2.0.0

**Common**
```
class InvalidationTracker
```

**Android**
```
open class InvalidationTracker
```

The invalidation tracker keeps track of tables modified by queries and notifies its created `Flow`s about such modifications.

A `Flow` tracking one or more tables can be created via [`createFlow`](#createflow). Once the `Flow` stream starts being collected, if a database operation changes one of the tables that the `Flow` was created from, then that table is considered "invalidated" and the `Flow` emits a new value.

## Nested Types

| Type |
|------|
| `abstract class` [`InvalidationTracker.Observer`](invalidation-tracker-observer.md) — An observer that can listen for changes in the database by subscribing to an `InvalidationTracker`. |

## Public Functions

### addObserver

**Android**
> Added in 2.0.0
```
@WorkerThread
open fun addObserver(observer: InvalidationTracker.Observer): Unit
```

Adds the given observer to the observers list; it is notified if any table it observes changes.

Database changes are pulled on another thread, so in some race conditions the observer might be invoked for changes that were done before it was added. If the observer already exists, this is a no-op call. Throws `IllegalArgumentException` if one of the tables in the observer does not exist in the database. This method should be called on a background/worker thread as it performs database operations.

- `observer` — The observer which listens to the database for changes.

### createFlow

```
fun createFlow(vararg tables: String, emitInitialState: Boolean = true): Flow<Set<String>>
```

Creates a `Flow` that tracks modifications in the database and emits sets of the tables that were invalidated.

The `Flow` emits at least one value — a set of all the tables registered for observation — to kick-start the stream, unless `emitInitialState` is set to `false`. Throws `IllegalArgumentException` if one of the tables to observe does not exist in the database.

```kotlin
fun getArtistTours(from: Date, to: Date): Flow<Map<Artist, TourState>> {
  return db.invalidationTracker.createFlow("Artist").map { _ ->
    val artists = artistsDao.getAllArtists()
    val tours = tourService.fetchStates(artists.map { it.id })
    associateTours(artists, tours, from, to)
  }
}
```

- `tables` — The names of the tables or views to track.
- `emitInitialState` — Set to `false` if no initial emission is desired. Default is `true`.

### refreshAsync

> Added in 2.7.0
```
fun refreshAsync(): Unit
```

Refreshes created `Flow`s asynchronously, emitting new values on those whose tables have been invalidated.

Call this after any write operation performed on the database, so tracked tables and their associated flows are notified if invalidated. In most cases Room calls this automatically, but if a write operation is performed via another connection or through `RoomDatabase.useConnection`, you might need to invoke it manually to trigger invalidation.

### refreshVersionsAsync

**Android**
> Added in 2.0.0
```
open fun refreshVersionsAsync(): Unit
```

Enqueues a task to refresh the list of updated tables.

This is automatically called when [`RoomDatabase.endTransaction`](room-database.md#endtransaction) is called, but if you have another connection to the database or directly use `SupportSQLiteDatabase`, you may need to call this manually.

|       See also       |
| -------------------- |
| [`refreshAsync`](#refreshasync) |

### removeObserver

**Android**
> Added in 2.0.0
```
@WorkerThread
open fun removeObserver(observer: InvalidationTracker.Observer): Unit
```

Removes the observer from the observers list. This method should be called on a background/worker thread as it performs database operations.

- `observer` — The observer to remove.
