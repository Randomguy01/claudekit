# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# MoshiConverterFactory

Package `retrofit2.converter.moshi` · Artifact `com.squareup.retrofit2:converter-moshi`

```java
public final class MoshiConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Moshi for JSON.

Because Moshi is so flexible in the types it supports, this converter assumes that it can handle all types. If you are mixing JSON serialization with something else (such as protocol buffers), you must add this instance last to allow the other converters a chance to see their types.

Any `@JsonQualifier`-annotated annotations on the parameter will be used when looking up a request body converter and those on the method when looking up a response body converter.

## Public Methods

### create

```java
static MoshiConverterFactory create()
static MoshiConverterFactory create(com.squareup.moshi.Moshi moshi)
```

Create an instance for conversion. The no-arg overload uses a default `Moshi`; the other uses the supplied `moshi`.

### asLenient

```java
MoshiConverterFactory asLenient()
```

Return a new factory which uses lenient adapters.

### failOnUnknown

```java
MoshiConverterFactory failOnUnknown()
```

Return a new factory which uses `JsonAdapter.failOnUnknown()` adapters.

### withNullSerialization

```java
MoshiConverterFactory withNullSerialization()
```

Return a new factory which includes null values in the serialized JSON.

### withStreaming

```java
MoshiConverterFactory withStreaming()
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
