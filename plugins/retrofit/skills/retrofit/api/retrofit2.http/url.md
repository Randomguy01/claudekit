# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Url

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface Url
```

URL resolved against the [base URL](../retrofit2/retrofit.md#baseurl).

```java
@GET
Call<ResponseBody> list(@Url String url);
```

See [base URL](../retrofit2/retrofit-builder.md#baseurl) for how the value will be resolved against a base URL to create the full endpoint URL.
