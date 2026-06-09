# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# DELETE

Package `retrofit2.http`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface DELETE
```

Make a DELETE request.

## Elements

### value

```java
String value default ""
```

A relative or absolute path, or full URL of the endpoint. Optional if the first parameter of the method is annotated with [`@Url`](url.md).

See [base URL](../retrofit2/retrofit-builder.md#baseurl) for how this is resolved against a base URL to create the full endpoint URL.
