# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# ScalarsConverterFactory

Package `retrofit2.converter.scalars` · Artifact `com.squareup.retrofit2:converter-scalars`

```java
public final class ScalarsConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) for strings and both primitives and their boxed types to `text/plain` bodies.

## Public Methods

### create

```java
static ScalarsConverterFactory create()
```

### responseBodyConverter / requestBodyConverter

```java
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] annotations, retrofit2.Retrofit retrofit)

retrofit2.Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations, retrofit2.Retrofit retrofit)
```

Override [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter) and [`requestBodyConverter`](../retrofit2/converter-factory.md#requestbodyconverter).
