# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# HTTP

Package `retrofit2.http`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface HTTP
```

Use a custom HTTP verb for a request.

```java
interface Service {
  @HTTP(method = "CUSTOM", path = "custom/endpoint/")
  Call<ResponseBody> customEndpoint();
}
```

This annotation can also be used for sending `DELETE` with a request body:

```java
interface Service {
  @HTTP(method = "DELETE", path = "remove/", hasBody = true)
  Call<ResponseBody> deleteObject(@Body RequestBody object);
}
```

## Elements

### method

```java
String method
```

The HTTP method/verb. (Required.)

### path

```java
String path default ""
```

A relative or absolute path, or full URL of the endpoint. Optional if the first parameter of the method is annotated with [`@Url`](url.md).

See [base URL](../retrofit2/retrofit-builder.md#baseurl) for how this is resolved against a base URL to create the full endpoint URL.

### hasBody

```java
boolean hasBody default false
```

Whether the request has a body.
