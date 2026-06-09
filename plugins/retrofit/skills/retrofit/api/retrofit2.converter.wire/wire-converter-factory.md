# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# WireConverterFactory

Package `retrofit2.converter.wire` · Artifact `com.squareup.retrofit2:converter-wire`

```java
public final class WireConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) that uses Wire for protocol buffers. This converter only applies for types which extend from `Message`.

## Public Methods

### create

```java
static WireConverterFactory create()
```

Create an instance which serializes request messages to bytes eagerly on the caller thread when either `Call.execute()` or `Call.enqueue()` is called. Response bytes are always converted on one of OkHttp's background threads.

### withStreaming

```java
WireConverterFactory withStreaming()
```

Return a new factory which instead streams serialization of request messages to bytes on the HTTP thread — either the calling thread for `Call.execute()`, or one of OkHttp's background threads for `Call.enqueue()`.

### responseBodyConverter / requestBodyConverter

```java
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] annotations, retrofit2.Retrofit retrofit)

retrofit2.Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations, retrofit2.Retrofit retrofit)
```

Override [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter) and [`requestBodyConverter`](../retrofit2/converter-factory.md#requestbodyconverter).
