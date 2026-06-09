# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Query

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface Query
```

Query parameter appended to the URL.

Values are converted to strings using [`Retrofit.stringConverter`](../retrofit2/retrofit.md#stringconverter) (or `Object.toString()`, if no matching string converter is installed) and then URL encoded. `null` values are ignored. Passing a `List` or array will result in a query parameter for each non-`null` item.

```java
@GET("/friends")
Call<ResponseBody> friends(@Query("page") int page);
```

Calling with `foo.friends(1)` yields `/friends?page=1`. Calling a nullable variant with `null` omits the parameter entirely. With varargs, `foo.friends("coworker", "bowling")` yields `/friends?group=coworker&group=bowling`.

Parameter names and values are URL encoded by default. Specify [`encoded=true`](#encoded) to change this behavior.

```java
@GET("/friends")
Call<ResponseBody> friends(@Query(value = "group", encoded = true) String group);
```

Calling with `foo.friends("foo+bar")` yields `/friends?group=foo+bar`.

See also [`@QueryMap`](query-map.md), [`@QueryName`](query-name.md).

## Elements

### value

```java
String value
```

The query parameter name. (Required.)

### encoded

```java
boolean encoded default false
```

Specifies whether the parameter [name](#value) and value are already URL encoded.
