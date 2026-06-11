# API Reference

> Last updated 2026-06-10

# PreferencesFileSerializer

> Added in 1.2.0

**Android**

```
object PreferencesFileSerializer : Serializer
```

Proto-based [`Serializer`](../androidx.datastore.core/serializer.md) for [`Preferences`](preferences.md), operating on `java.io` streams. Can be used to manually create a `DataStore` with [`DataStoreFactory.create`](../androidx.datastore.core/data-store-factory.md#create).

## Public Functions

### readFrom

**Android**

```
open suspend fun readFrom(input: InputStream): Preferences
```

Unmarshal a [`Preferences`](preferences.md) object from a stream.

- `input` — the `InputStream` with the data to deserialize.

Throws [`CorruptionException`](../androidx.datastore.core/corruption-exception.md) if the data is corrupted or unparseable. Other unrecoverable [`IOException`](../androidx.datastore.core/io-exception.md)s should not be thrown as `CorruptionException`.

### writeTo

> Added in 1.2.0

**Android**

```
open suspend fun writeTo(t: Preferences, output: OutputStream): Unit
```

Marshal a [`Preferences`](preferences.md) object to a stream. Closing the provided `OutputStream` is a no-op.

- `t` — the data to write.
- `output` — the `OutputStream` to serialize data to.

## Public Properties

### defaultValue

> Added in 1.2.0

**Android**

```
open val defaultValue: Preferences
```

Value to return if there is no data on disk.
