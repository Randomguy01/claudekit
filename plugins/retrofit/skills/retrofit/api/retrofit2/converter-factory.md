# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Converter.Factory

Package `retrofit2` · Enclosing interface [`Converter`](converter.md)

```java
public abstract static class Converter.Factory
```

Creates [`Converter`](converter.md) instances based on a type and target usage.

Direct known subclasses: [`OptionalConverterFactory`](optional-converter-factory.md).

## Public Constructors

### Factory

```java
Factory()
```

## Public Methods

### responseBodyConverter

```java
@Nullable
Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations,
    Retrofit retrofit)
```

Returns a [`Converter`](converter.md) for converting an HTTP response body to `type`, or null if `type` cannot be handled by this factory. Used to create converters for response types such as `SimpleResponse` from a `Call<SimpleResponse>` declaration.

### requestBodyConverter

```java
@Nullable
Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations,
    Retrofit retrofit)
```

Returns a [`Converter`](converter.md) for converting `type` to an HTTP request body, or null if `type` cannot be handled by this factory. Used to create converters for types specified by [`@Body`](../retrofit2.http/body.md), [`@Part`](../retrofit2.http/part.md), and [`@PartMap`](../retrofit2.http/part-map.md) values.

### stringConverter

```java
@Nullable
Converter<?, java.lang.String> stringConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations,
    Retrofit retrofit)
```

Returns a [`Converter`](converter.md) for converting `type` to a `String`, or null if `type` cannot be handled by this factory. Used to create converters for types specified by [`@Field`](../retrofit2.http/field.md), [`@FieldMap`](../retrofit2.http/field-map.md), [`@Header`](../retrofit2.http/header.md), [`@HeaderMap`](../retrofit2.http/header-map.md), [`@Path`](../retrofit2.http/path.md), [`@Query`](../retrofit2.http/query.md), and [`@QueryMap`](../retrofit2.http/query-map.md) values.

### getParameterUpperBound

```java
protected static java.lang.reflect.Type getParameterUpperBound(
    int index,
    java.lang.reflect.ParameterizedType type)
```

Extract the upper bound of the generic parameter at `index` from `type`. For example, index 1 of `Map<String, ? extends Runnable>` returns `Runnable`.

### getRawType

```java
protected static java.lang.Class<?> getRawType(java.lang.reflect.Type type)
```

Extract the raw class type from `type`. For example, the type representing `List<? extends Runnable>` returns `List.class`.
