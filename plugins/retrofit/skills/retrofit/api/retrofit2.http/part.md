# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Part

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface Part
```

Denotes a single part of a multi-part request.

The parameter type on which this annotation exists will be processed in one of three ways:

- If the type is `MultipartBody.Part` the contents will be used directly. Omit the name from the annotation (i.e., `@Part MultipartBody.Part part`).
- If the type is `RequestBody` the value will be used directly with its content type. Supply the part name in the annotation (e.g., `@Part("foo") RequestBody foo`).
- Other object types will be converted to an appropriate representation by using [a converter](../retrofit2/converter.md). Supply the part name in the annotation (e.g., `@Part("foo") Image photo`).

```java
@Multipart
@POST("/")
Call<ResponseBody> example(
    @Part("description") String description,
    @Part(value = "image", encoding = "8-bit") RequestBody image);
```

Part parameters may not be `null`.

## Elements

### value

```java
String value default ""
```

The name of the part. Required for all parameter types except `MultipartBody.Part`.

### encoding

```java
String encoding default "binary"
```

The `Content-Transfer-Encoding` of this part.
