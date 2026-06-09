# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# QueryName

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface QueryName
```

Query parameter appended to the URL that has no value.

Passing a `List` or array will result in a query parameter for each non-`null` item.

```java
@GET("/friends")
Call<ResponseBody> friends(@QueryName String filter);
```

Calling with `foo.friends("contains(Bob)")` yields `/friends?contains(Bob)`. With varargs, `foo.friends("contains(Bob)", "age(42)")` yields `/friends?contains(Bob)&age(42)`.

Parameter names are URL encoded by default. Specify [`encoded=true`](#encoded) to change this behavior.

```java
@GET("/friends")
Call<ResponseBody> friends(@QueryName(encoded = true) String filter);
```

Calling with `foo.friends("name+age")` yields `/friends?name+age`.

See also [`@Query`](query.md), [`@QueryMap`](query-map.md).

## Elements

### encoded

```java
boolean encoded default false
```

Specifies whether the parameter is already URL encoded.
