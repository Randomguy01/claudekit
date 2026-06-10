# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Java8CallAdapterFactory

Package `retrofit2.adapter.java8` · Artifact `com.squareup.retrofit2:adapter-java8`

```java
@Deprecated
public final class Java8CallAdapterFactory extends retrofit2.CallAdapter.Factory
```

**Deprecated** — Retrofit includes support for `CompletableFuture` out of the box; this no longer needs to be added to the Retrofit instance explicitly.

A [`CallAdapter.Factory`](../retrofit2/call-adapter-factory.md) which creates Java 8 futures, allowing service methods to return `CompletableFuture`.

```java
interface MyService {
  @GET("user/me")
  CompletableFuture<User> getUser();
}
```

Two configurations are supported for the `CompletableFuture` type parameter:

- **Direct body** (e.g. `CompletableFuture<User>`) returns the deserialized body for 2XX responses, fails with [`HttpException`](../retrofit2/http-exception.md) for non-2XX responses, and `IOException` for network errors.
- **Response-wrapped body** (e.g. `CompletableFuture<Response<User>>`) returns a [`Response`](../retrofit2/response.md) for all HTTP responses and fails with `IOException` only for network errors.

## Public Methods

### create

```java
static Java8CallAdapterFactory create()
```

### get

```java
@Nullable
retrofit2.CallAdapter<?, ?> get(java.lang.reflect.Type returnType,
                                java.lang.annotation.Annotation[] annotations,
                                retrofit2.Retrofit retrofit)
```

Specified by [`CallAdapter.Factory.get`](../retrofit2/call-adapter-factory.md#get).
