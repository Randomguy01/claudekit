# API Reference

> Last updated 2026-06-10

# Serializer

> Added in 1.0.0

**Android**

```
interface Serializer<T : Any?>
```

The serializer determines the on-disk format and the API for accessing it. The type `T` **must** be immutable — mutable types result in broken DataStore functionality.

## Known Direct Subtypes

| | |
|---|---|
| [`PreferencesFileSerializer`](../androidx.datastore.preferences.core/preferences-file-serializer.md) | Proto-based serializer for `Preferences`. |

## Public Functions

### readFrom

**Android**

```
suspend fun readFrom(input: InputStream): T
```

Unmarshal an object from a stream.

- `input` — the `InputStream` with the data to deserialize.

Throws [`CorruptionException`](corruption-exception.md) if the data from `input` is corrupted or unparseable (e.g. `InvalidProtocolBufferException` when `T` is a protobuf message). Other unrecoverable [`IOException`](io-exception.md)s from the file system should **not** be thrown as `CorruptionException`.

### writeTo

> Added in 1.0.0

**Android**

```
suspend fun writeTo(t: T, output: OutputStream): Unit
```

Marshal an object to a stream. Closing the provided `OutputStream` is a no-op.

- `t` — the data to write to `output`.
- `output` — the `OutputStream` to serialize data to.

## Public Properties

### defaultValue

> Added in 1.0.0

**Android**

```
val defaultValue: T
```

Value to return if there is no data on disk.
