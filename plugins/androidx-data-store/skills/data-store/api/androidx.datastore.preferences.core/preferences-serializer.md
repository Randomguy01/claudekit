# API Reference

> Last updated 2026-06-10

# PreferencesSerializer

> Added in 1.1.0

```
object PreferencesSerializer : OkioSerializer
```

Proto-based `OkioSerializer` for [`Preferences`](preferences.md), operating on okio `BufferedSource`/`BufferedSink`. Can be used to manually create a `DataStore` with [`DataStoreFactory.create`](../androidx.datastore.core/data-store-factory.md#create).

## Public Functions

### readFrom

```
open suspend fun readFrom(source: BufferedSource): Preferences
```

Unmarshal a [`Preferences`](preferences.md) object from an okio `BufferedSource`.

- `source` — the `BufferedSource` with the data to deserialize.

Throws [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) if the data is corrupted or unparseable. Other unrecoverable `IOException`s should not be thrown as `CorruptionException`.

### writeTo

> Added in 1.1.0

```
open suspend fun writeTo(t: Preferences, sink: BufferedSink): Unit
```

Marshal a [`Preferences`](preferences.md) object to an okio `BufferedSink`.

- `t` — the data to write.
- `sink` — the `BufferedSink` to serialize data to.

## Public Properties

### defaultValue

> Added in 1.1.0

```
open val defaultValue: Preferences
```

Value to return if there is no data on disk.
