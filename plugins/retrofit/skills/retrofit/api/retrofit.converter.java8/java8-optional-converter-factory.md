# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Java8OptionalConverterFactory

Package `retrofit.converter.java8` · Artifact `com.squareup.retrofit2:converter-java8`

```java
@Deprecated
public final class Java8OptionalConverterFactory extends retrofit2.Converter.Factory
```

**Deprecated** — Retrofit includes support for `Optional` out of the box (see [`OptionalConverterFactory`](../retrofit2/optional-converter-factory.md)); this no longer needs to be added to the Retrofit instance explicitly.

A converter for `Optional<T>` which delegates to another converter to deserialize `T` and then wraps it into `Optional`.

## Public Methods

### create

```java
static Java8OptionalConverterFactory create()
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
