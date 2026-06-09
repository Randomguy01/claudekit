# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# RxJava2CallAdapterFactory

Package `retrofit2.adapter.rxjava2` · Artifact `com.squareup.retrofit2:adapter-rxjava2`

```java
public final class RxJava2CallAdapterFactory extends retrofit2.CallAdapter.Factory
```

A [`CallAdapter.Factory`](../retrofit2/call-adapter-factory.md) which uses RxJava 2 for creating observables. Adding it to `Retrofit` allows service methods to return `Observable`, `Flowable`, `Single`, `Completable`, or `Maybe`.

```java
interface MyService {
  @GET("user/me")
  Observable<User> getUser();
}
```

Three configurations are supported for the type parameter:

- **Direct body** (e.g. `Observable<User>`) calls `onNext` with the deserialized body for 2XX responses, and `onError` with [`HttpException`](http-exception.md) for non-2XX responses or `IOException` for network errors.
- **Response-wrapped body** (e.g. `Observable<Response<User>>`) calls `onNext` with a [`Response`](../retrofit2/response.md) for all HTTP responses, and `onError` with `IOException` for network errors.
- **Result-wrapped body** (e.g. `Observable<Result<User>>`) calls `onNext` with a [`Result`](result.md) for all HTTP responses and errors.

## Public Methods

### create

```java
static RxJava2CallAdapterFactory create()
```

Returns an instance which creates synchronous observables that do not operate on any scheduler by default.

### createAsync

```java
static RxJava2CallAdapterFactory createAsync()
```

Returns an instance which creates asynchronous observables.

### createWithScheduler

```java
static RxJava2CallAdapterFactory createWithScheduler(io.reactivex.Scheduler scheduler)
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
