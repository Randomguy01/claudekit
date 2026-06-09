# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# QueryMap

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface QueryMap
```

Query parameter keys and values appended to the URL.

Values are converted to strings using [`Retrofit.stringConverter`](../retrofit2/retrofit.md#stringconverter) (or `Object.toString()`, if no matching string converter is installed).

```java
@GET("/friends")
Call<ResponseBody> friends(@QueryMap Map<String, String> filters);
```

Calling with `foo.friends(ImmutableMap.of("group", "coworker", "age", "42"))` yields `/friends?group=coworker&age=42`.

Map keys and values are URL encoded by default. Specify [`encoded=true`](#encoded) to change this behavior.

```java
@GET("/friends")
Call<ResponseBody> friends(@QueryMap(encoded = true) Map<String, String> filters);
```

Calling with `foo.friends(ImmutableMap.of("group", "coworker+bowling"))` yields `/friends?group=coworker+bowling`.

A `null` value for the map, as a key, or as a value is not allowed.

See also [`@Query`](query.md), [`@QueryName`](query-name.md).

## Elements

### encoded

```java
boolean encoded default false
```

Specifies whether parameter names and values are already URL encoded.
