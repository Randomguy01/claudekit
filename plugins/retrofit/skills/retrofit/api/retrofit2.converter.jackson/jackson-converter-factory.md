# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# JacksonConverterFactory

Package `retrofit2.converter.jackson` · Artifact `com.squareup.retrofit2:converter-jackson`

```java
public final class JacksonConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Jackson.

Because Jackson is so flexible in the types it supports, this converter assumes that it can handle all types. If you are mixing JSON serialization with something else (such as protocol buffers), you must add this instance last to allow the other converters a chance to see their types.

## Public Methods

### create

```java
static JacksonConverterFactory create()
static JacksonConverterFactory create(com.fasterxml.jackson.databind.ObjectMapper mapper)
static JacksonConverterFactory create(com.fasterxml.jackson.databind.ObjectMapper mapper, okhttp3.MediaType mediaType)
```

Create an instance for conversion. The no-arg overload uses a default `ObjectMapper`; the others use the supplied `mapper` (and optional `mediaType`).

### withStreaming

```java
JacksonConverterFactory withStreaming()
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
