# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# FieldMap

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface FieldMap
```

Named key/value pairs for a form-encoded request.

```java
@FormUrlEncoded
@POST("/things")
Call<ResponseBody> things(@FieldMap Map<String, String> fields);
```

Calling with `foo.things(ImmutableMap.of("foo", "bar", "kit", "kat"))` yields a request body of `foo=bar&kit=kat`.

A `null` value for the map, as a key, or as a value is not allowed.

See also [`@FormUrlEncoded`](form-url-encoded.md), [`@Field`](field.md).

## Elements

### encoded

```java
boolean encoded default false
```

Specifies whether the names and values are already URL encoded.
