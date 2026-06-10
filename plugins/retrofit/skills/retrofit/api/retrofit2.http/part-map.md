# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# PartMap

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface PartMap
```

Denotes name and value parts of a multi-part request.

Values of the map on which this annotation exists will be processed in one of two ways:

- If the type is `RequestBody` the value will be used directly with its content type.
- Other object types will be converted to an appropriate representation by using [a converter](../retrofit2/converter.md).

```java
@Multipart
@POST("/upload")
Call<ResponseBody> upload(
    @Part("file") RequestBody file,
    @PartMap Map<String, RequestBody> params);
```

A `null` value for the map, as a key, or as a value is not allowed.

See also [`@Multipart`](multipart.md), [`@Part`](part.md).

## Elements

### encoding

```java
String encoding default "binary"
```

The `Content-Transfer-Encoding` of the parts.
