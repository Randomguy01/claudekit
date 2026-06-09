# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# GsonConverterFactory

Package `retrofit2.converter.gson` · Artifact `com.squareup.retrofit2:converter-gson`

```java
public final class GsonConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Gson for JSON.

Because Gson is so flexible in the types it supports, this converter assumes that it can handle all types. If you are mixing JSON serialization with something else (such as protocol buffers), you must add this instance last to allow the other converters a chance to see their types.

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.example.com/")
    .addConverterFactory(GsonConverterFactory.create())
    .build();
```

## Public Methods

### create

```java
static GsonConverterFactory create()
static GsonConverterFactory create(com.google.gson.Gson gson)
```

Create an instance for conversion. The no-arg overload uses a default `Gson` instance; the other uses the supplied `gson`. Encoding to JSON and decoding from JSON (when no charset is specified by a header) will use UTF-8.

### withStreaming

```java
GsonConverterFactory withStreaming()
```

Return a new factory which streams serialization of request messages to bytes on the HTTP thread — either the calling thread for [`Call.execute()`](../retrofit2/call.md#execute), or one of OkHttp's background threads for [`Call.enqueue()`](../retrofit2/call.md#enqueue). Response bytes are always converted to message instances on one of OkHttp's background threads.

### responseBodyConverter

```java
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations,
    retrofit2.Retrofit retrofit)
```

Overrides [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter).

### requestBodyConverter

```java
retrofit2.Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations,
    retrofit2.Retrofit retrofit)
```

Overrides [`Converter.Factory.requestBodyConverter`](../retrofit2/converter-factory.md#requestbodyconverter).
