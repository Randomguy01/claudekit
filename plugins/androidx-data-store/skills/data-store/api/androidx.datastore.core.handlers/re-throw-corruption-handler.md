# API Reference

> Last updated 2026-06-10

# ReThrowCorruptionHandler

> Added in 1.3.0-alpha09

```
class ReThrowCorruptionHandler<T : Any?> : CorruptionHandler
```

Default [`CorruptionHandler`](../androidx.datastore.core/corruption-handler.md) which does nothing but rethrow the exception.

## Public Constructors

### ReThrowCorruptionHandler

```
<T : Any?> ReThrowCorruptionHandler()
```

## Public Functions

### handleCorruption

```
open suspend fun handleCorruption(ex: CorruptionException): T
```

Called by DataStore when it encounters corruption. This implementation rethrows `ex`, propagating it to the original DataStore call. (In general, if this function throws, the exception is propagated; otherwise the returned data is written to disk.) Must not interact with any DataStore API — doing so can deadlock.

- `ex` — the [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) encountered when attempting to deserialize data from disk.

Returns the value DataStore should attempt to write to disk.
