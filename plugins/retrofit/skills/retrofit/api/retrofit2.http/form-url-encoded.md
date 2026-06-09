# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# FormUrlEncoded

Package `retrofit2.http`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface FormUrlEncoded
```

Denotes that the request body will use form URL encoding. Fields should be declared as parameters and annotated with [`@Field`](field.md).

Requests made with this annotation will have `application/x-www-form-urlencoded` MIME type. Field names and values will be UTF-8 encoded before being URI-encoded in accordance to [RFC-3986](https://datatracker.ietf.org/doc/html/rfc3986).
