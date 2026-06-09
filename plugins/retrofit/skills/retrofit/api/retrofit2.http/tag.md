# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Tag

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface Tag
```

Adds the argument instance as a request tag using the type as the key.

```java
@GET("/")
Call<ResponseBody> foo(@Tag String tag);
```

Tag arguments may be `null`, which will omit them from the request. Passing a parameterized type will use the raw type as the key (e.g., `List<String>` uses `List.class`). Primitive types will be boxed and stored using the boxed type (e.g., `long` uses `Long.class`). Duplicate tag types are not allowed.

The tag is retrievable from the request, e.g. via `Invocation` or OkHttp's `Request.tag(Class)`.
