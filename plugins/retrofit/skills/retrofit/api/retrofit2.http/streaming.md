# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Streaming

Package `retrofit2.http`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface Streaming
```

Treat the response body on methods returning `ResponseBody` as is, i.e. without converting the body to `byte[]`.
