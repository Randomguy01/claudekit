# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Converter

Package `retrofit2`

```java
public interface Converter<F, T>
```

Convert objects to and from their representation in HTTP. Instances are created by [a factory](converter-factory.md) which is installed into the [`Retrofit`](retrofit.md) instance.

## Nested Types

| Type | Description |
|------|-------------|
| [`Converter.Factory`](converter-factory.md) | Creates `Converter` instances based on a type and target usage. |

## Public Methods

### convert

```java
@Nullable
T convert(F value) throws java.io.IOException
```

Convert `value` from type `F` to type `T`. Throws `java.io.IOException`.
