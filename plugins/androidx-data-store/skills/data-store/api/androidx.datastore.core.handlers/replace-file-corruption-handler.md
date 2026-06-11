# API Reference

> Last updated 2026-06-10

# ReplaceFileCorruptionHandler

> Added in 1.0.0

```
class ReplaceFileCorruptionHandler<T : Any?>
```

A [`CorruptionHandler`](../androidx.datastore.core/corruption-handler.md) that attempts to replace the on-disk data with data from `produceNewData`.

If the handler successfully replaces the data, the original exception is swallowed. If the handler itself throws while replacing data, that new exception is added as a suppressed exception to the original, and the original is thrown.

## Public Constructors

### ReplaceFileCorruptionHandler

```
<T : Any?> ReplaceFileCorruptionHandler(
    produceNewData: (CorruptionException) -> T
)
```

- `produceNewData` — produces the replacement data, given the [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) that was encountered.

## Public Functions

### handleCorruption

```
open suspend fun handleCorruption(ex: CorruptionException): T
```

Called by DataStore when it encounters corruption. If this implementation throws, the exception is propagated to the original DataStore call; otherwise the returned data is written to disk. Must not interact with any DataStore API — doing so can deadlock.

- `ex` — the [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) encountered when attempting to deserialize data from disk.

Returns the value DataStore should attempt to write to disk.
