# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# asConverterFactory

Package `retrofit2.converter.kotlinx.serialization` · Artifact `com.squareup.retrofit2:converter-kotlinx-serialization`

This module exposes no factory class. Instead it provides `asConverterFactory` extension functions that turn a kotlinx.serialization format into a [`Converter.Factory`](../retrofit2/converter-factory.md). Add the result via `Retrofit.Builder.addConverterFactory`.

```kotlin
val contentType = "application/json".toMediaType()
val retrofit = Retrofit.Builder()
    .baseUrl("https://api.example.com/")
    .addConverterFactory(Json.asConverterFactory(contentType))
    .build()
```

Because Kotlin serialization is so flexible in the types it supports, this converter assumes that it can handle all types. If you are mixing it with another converter, add this instance last to allow the others a chance to see their types.

## Extension Functions

### asConverterFactory

```kotlin
@JvmName(name = "create")
fun StringFormat.asConverterFactory(contentType: MediaType): Converter.Factory
```

Return a [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Kotlin serialization for string-based payloads (e.g. `Json`).

```kotlin
@JvmName(name = "create")
fun BinaryFormat.asConverterFactory(contentType: MediaType): Converter.Factory
```

Return a [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Kotlin serialization for byte-based payloads (e.g. `ProtoBuf`, `Cbor`).

Both are exposed to Java as a static `create` method (via `@JvmName`). `MediaType` is `okhttp3.MediaType`; `StringFormat` and `BinaryFormat` are `kotlinx.serialization` formats.
