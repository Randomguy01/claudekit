# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Multipart

Package `retrofit2.http`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface Multipart
```

Denotes that the request body is multi-part. Parts should be declared as parameters and annotated with [`@Part`](part.md).
