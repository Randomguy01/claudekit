# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# OptionalConverterFactory

Package `retrofit2`

```java
@IgnoreJRERequirement
public final class OptionalConverterFactory extends Converter.Factory
```

A [`Converter.Factory`](converter-factory.md) which supports Java's `Optional` to wrap null values from another converter.

This factory is installed by default on the JVM and Android API 24+. If you are using another converter which tries to serialize all types, such as Moshi or Gson, the default installation of this factory never gets a chance to run. To work around this, explicitly install this factory before your serialization library converter.

## Public Methods

### create

```java
static OptionalConverterFactory create()
```

### responseBodyConverter

```java
@Nullable
Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations,
    Retrofit retrofit)
```

Returns a [`Converter`](converter.md) for converting an HTTP response body to `type`, or null if `type` cannot be handled by this factory. Overrides [`Converter.Factory.responseBodyConverter`](converter-factory.md#responsebodyconverter).
