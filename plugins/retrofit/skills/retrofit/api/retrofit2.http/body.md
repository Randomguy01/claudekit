# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Body

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface Body
```

Use this annotation on a service method param when you want to directly control the request body of a POST/PUT request (instead of sending in as request parameters or form-style request body). The object will be serialized using the [`Retrofit`](../retrofit2/retrofit.md) instance [`Converter`](../retrofit2/converter.md) and the result will be set directly as the request body.

Body parameters may not be `null`.
