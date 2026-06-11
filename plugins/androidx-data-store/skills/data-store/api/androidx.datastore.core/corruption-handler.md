# API Reference

> Last updated 2026-06-10

# CorruptionHandler

> Added in 1.2.0

```
interface CorruptionHandler<T : Any?>
```

CorruptionHandlers allow recovery from corruption that prevents reading data from the file, as indicated by a [`CorruptionException`](corruption-exception.md).

## Known Direct Subtypes

| | |
|---|---|
| [`ReThrowCorruptionHandler`](../androidx.datastore.core.handlers/re-throw-corruption-handler.md) | Default corruption handler which does nothing but rethrow the exception. |
| [`ReplaceFileCorruptionHandler`](../androidx.datastore.core.handlers/replace-file-corruption-handler.md) | A corruption handler that attempts to replace the on-disk data with data from `produceNewData`. |

## Public Functions

### handleCorruption

```
suspend fun handleCorruption(ex: CorruptionException): T
```

Called by DataStore when it encounters corruption. If this function throws, the exception is propagated to the original DataStore call; otherwise the returned data is written to disk.

This function must not interact with any DataStore API — doing so can deadlock.

- `ex` — the [`CorruptionException`](corruption-exception.md) encountered when attempting to deserialize data from disk.

Returns the value that DataStore should attempt to write to disk.
