# API Reference

> Last updated 2026-06-10

# WebSerializer

**JavaScript**

```
class WebSerializer<T : Any?> : OkioSerializer
```

An [`OkioSerializer`](okio-serializer.md) that uses `kotlinx.serialization.json` to convert any `@Serializable` data class `T` to and from a byte stream using Okio. `T` must be annotated with `@Serializable`.

## Public Constructors

### WebSerializer

**JavaScript**

```
<T : Any?> WebSerializer(kSerializer: KSerializer<T>, defaultValue: T)
```

- `kSerializer` — the `KSerializer` for type `T`, usually accessed via `T.serializer()`.
- `defaultValue` — the default instance of `T` to return if data is corrupted or doesn't exist.

## Public Functions

### readFrom

**JavaScript**

```
open suspend fun readFrom(source: BufferedSource): T
```

Reads a UTF-8 string from the source, then parses it back into an object of type `T` using JSON.

### writeTo

**JavaScript**

```
open suspend fun writeTo(t: T, sink: BufferedSink): Unit
```

Encodes the object of type `T` into a JSON string, and writes that UTF-8 string to the sink.

## Public Properties

### defaultValue

**JavaScript**

```
open val defaultValue: T
```

The default instance of `T` to return if data is corrupted or doesn't exist.
