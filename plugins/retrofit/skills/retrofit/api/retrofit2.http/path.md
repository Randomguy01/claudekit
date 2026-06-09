# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Path

Package `retrofit2.http`

```java
@Documented
@Retention(value=RUNTIME)
@Target(value=PARAMETER)
public @interface Path
```

Named replacement in a URL path segment. Values are converted to strings using [`Retrofit.stringConverter`](../retrofit2/retrofit.md#stringconverter) (or `Object.toString()`, if no matching string converter is installed) and then URL encoded.

```java
@GET("/image/{id}")
Call<ResponseBody> example(@Path("id") int id);
```

Calling with `foo.example(1)` yields `/image/1`.

Values are URL encoded by default. Disable with `encoded=true`.

```java
@GET("/user/{name}")
Call<ResponseBody> encoded(@Path("name") String name);

@GET("/user/{name}")
Call<ResponseBody> notEncoded(@Path(value = "name", encoded = true) String name);
```

Calling `foo.encoded("John%Doe")` yields `/user/John%25Doe` whereas `foo.notEncoded("John%Doe")` yields `/user/John%Doe`.

Path parameters may not be `null`.

## Elements

### value

```java
String value
```

The name of the path segment placeholder to replace. (Required.)

### encoded

```java
boolean encoded default false
```

Specifies whether the argument value to the annotated method parameter is already URL encoded.
