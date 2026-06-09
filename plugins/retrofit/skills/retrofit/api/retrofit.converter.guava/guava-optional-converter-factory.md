# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# GuavaOptionalConverterFactory

Package `retrofit.converter.guava` · Artifact `com.squareup.retrofit2:converter-guava`

```java
public final class GuavaOptionalConverterFactory extends retrofit2.Converter.Factory
```

A converter for Guava's `Optional<T>` which delegates to another converter to deserialize `T` and then wraps it into `Optional`. Add it before your main serialization converter.

## Public Methods

### create

```java
static GuavaOptionalConverterFactory create()
```

### responseBodyConverter

```java
@Nullable
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations,
    retrofit2.Retrofit retrofit)
```

Overrides [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter).
