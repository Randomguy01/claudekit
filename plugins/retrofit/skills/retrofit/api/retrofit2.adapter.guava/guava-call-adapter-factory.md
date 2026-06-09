# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# GuavaCallAdapterFactory

Package `retrofit2.adapter.guava` · Artifact `com.squareup.retrofit2:adapter-guava`

```java
public final class GuavaCallAdapterFactory extends retrofit2.CallAdapter.Factory
```

A [`CallAdapter.Factory`](../retrofit2/call-adapter-factory.md) which creates Guava futures. Adding it to `Retrofit` allows service methods to return `ListenableFuture`.

```java
interface MyService {
  @GET("user/me")
  ListenableFuture<User> getUser();
}
```

Two configurations are supported for the `ListenableFuture` type parameter:

- **Direct body** (e.g. `ListenableFuture<User>`) returns the deserialized body for 2XX responses, fails with [`HttpException`](../retrofit2/http-exception.md) for non-2XX responses, and `IOException` for network errors.
- **Response-wrapped body** (e.g. `ListenableFuture<Response<User>>`) returns a [`Response`](../retrofit2/response.md) for all HTTP responses and fails with `IOException` only for network errors.

## Public Methods

### create

```java
static GuavaCallAdapterFactory create()
```

### get

```java
@Nullable
retrofit2.CallAdapter<?, ?> get(java.lang.reflect.Type returnType,
                                java.lang.annotation.Annotation[] annotations,
                                retrofit2.Retrofit retrofit)
```

Specified by [`CallAdapter.Factory.get`](../retrofit2/call-adapter-factory.md#get).
