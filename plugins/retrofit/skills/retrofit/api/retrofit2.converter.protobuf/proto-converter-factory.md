# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# ProtoConverterFactory

Package `retrofit2.converter.protobuf` · Artifact `com.squareup.retrofit2:converter-protobuf`

```java
public final class ProtoConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Protocol Buffers. This converter only applies for types which extend from `MessageLite` (or one of its subclasses).

## Public Methods

### create

```java
static ProtoConverterFactory create()
```

### createWithRegistry

```java
static ProtoConverterFactory createWithRegistry(@Nullable com.google.protobuf.ExtensionRegistryLite registry)
```

Create an instance which uses `registry` when deserializing.

### withStreaming

```java
ProtoConverterFactory withStreaming()
```

Return a new factory which streams serialization of request messages to bytes on the HTTP thread — either the calling thread for `Call.execute()`, or one of OkHttp's background threads for `Call.enqueue()`. Response bytes are always converted on a background thread.

### responseBodyConverter / requestBodyConverter

```java
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] annotations, retrofit2.Retrofit retrofit)

retrofit2.Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations, retrofit2.Retrofit retrofit)
```

Override [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter) and [`requestBodyConverter`](../retrofit2/converter-factory.md#requestbodyconverter).
