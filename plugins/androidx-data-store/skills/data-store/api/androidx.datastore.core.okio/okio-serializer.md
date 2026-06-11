# API Reference

> Last updated 2026-06-10

# OkioSerializer

> Added in 1.1.0

```
interface OkioSerializer<T : Any?>
```

The `OkioSerializer` determines the on-disk format and the API for accessing it, using okio `BufferedSource`/`BufferedSink` for cross-platform IO. The type `T` **must** be immutable — mutable types result in broken DataStore functionality.

## Known Direct Subtypes

| | |
|---|---|
| [`PreferencesSerializer`](../androidx.datastore.preferences.core/preferences-serializer.md) | Proto-based serializer for `Preferences`. |
| [`WebSerializer`](web-serializer.md) | A serializer that uses `kotlinx.serialization.json` to convert any `@Serializable` data class to and from a byte stream using Okio. |

## Public Functions

### readFrom

```
suspend fun readFrom(source: BufferedSource): T
```

Unmarshal an object from an okio `BufferedSource`.

- `source` — the `BufferedSource` with the data to deserialize.

Throws [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) if the data is corrupted or unparseable. Other unrecoverable [`IOException`](../androidx.datastore.core/io-exception.md)s should not be thrown as `CorruptionException`.

### writeTo

> Added in 1.1.0

```
suspend fun writeTo(t: T, sink: BufferedSink): Unit
```

Marshal an object to an okio `BufferedSink`.

- `t` — the data to write.
- `sink` — the `BufferedSink` to serialize data to.

## Public Properties

### defaultValue

> Added in 1.1.0

```
val defaultValue: T
```

Value to return if there is no data on disk.
