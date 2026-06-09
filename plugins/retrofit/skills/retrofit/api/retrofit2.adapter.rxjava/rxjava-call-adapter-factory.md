# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# RxJavaCallAdapterFactory

Package `retrofit2.adapter.rxjava` · Artifact `com.squareup.retrofit2:adapter-rxjava`

```java
public final class RxJavaCallAdapterFactory extends retrofit2.CallAdapter.Factory
```

A [`CallAdapter.Factory`](../retrofit2/call-adapter-factory.md) which uses RxJava (1.x) for creating observables. Adding it to `Retrofit` allows service methods to return `Observable`, `Single`, or `Completable`.

```java
interface MyService {
  @GET("user/me")
  Observable<User> getUser();
}
```

Three configurations are supported for the `Observable` or `Single` type parameter:

- **Direct body** (e.g. `Observable<User>`) calls `onNext` with the deserialized body for 2XX responses, and `onError` with [`HttpException`](http-exception.md) for non-2XX responses or `IOException` for network errors.
- **Response-wrapped body** (e.g. `Observable<Response<User>>`) calls `onNext` with a [`Response`](../retrofit2/response.md) for all HTTP responses, and `onError` with `IOException` for network errors.
- **Result-wrapped body** (e.g. `Observable<Result<User>>`) calls `onNext` with a [`Result`](result.md) for all HTTP responses and errors.

*Note:* support for `Single` and `Completable` is experimental and subject to backwards-incompatible changes at any time, since neither is considered stable by RxJava.

## Public Methods

### create

```java
static RxJavaCallAdapterFactory create()
```

Returns an instance which creates synchronous observables that do not operate on any scheduler by default.

### createAsync

```java
static RxJavaCallAdapterFactory createAsync()
```

Returns an instance which creates asynchronous observables.

### createWithScheduler

```java
static RxJavaCallAdapterFactory createWithScheduler(rx.Scheduler scheduler)
```

Returns an instance which creates synchronous observables that subscribe on `scheduler` by default.

### get

```java
@Nullable
retrofit2.CallAdapter<?, ?> get(java.lang.reflect.Type returnType,
                                java.lang.annotation.Annotation[] annotations,
                                retrofit2.Retrofit retrofit)
```

Specified by [`CallAdapter.Factory.get`](../retrofit2/call-adapter-factory.md#get).
