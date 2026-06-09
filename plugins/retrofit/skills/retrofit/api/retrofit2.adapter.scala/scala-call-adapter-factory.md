# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# ScalaCallAdapterFactory

Package `retrofit2.adapter.scala` · Artifact `com.squareup.retrofit2:adapter-scala`

```java
public final class ScalaCallAdapterFactory extends retrofit2.CallAdapter.Factory
```

A [`CallAdapter.Factory`](../retrofit2/call-adapter-factory.md) which creates Scala futures. Adding it to `Retrofit` allows service methods to return `Future`.

```java
interface MyService {
  @GET("user/me")
  Future<User> getUser();
}
```

Two configurations are supported for the `Future` type parameter:

- **Direct body** (e.g. `Future<User>`) returns the deserialized body for 2XX responses, fails with [`HttpException`](../retrofit2/http-exception.md) for non-2XX responses, and `IOException` for network errors.
- **Response-wrapped body** (e.g. `Future<Response<User>>`) returns a [`Response`](../retrofit2/response.md) for all HTTP responses and fails with `IOException` only for network errors.

## Public Methods

### create

```java
static ScalaCallAdapterFactory create()
```

### get

```java
@Nullable
retrofit2.CallAdapter<?, ?> get(java.lang.reflect.Type returnType,
                                java.lang.annotation.Annotation[] annotations,
                                retrofit2.Retrofit retrofit)
```

Specified by [`CallAdapter.Factory.get`](../retrofit2/call-adapter-factory.md#get).
