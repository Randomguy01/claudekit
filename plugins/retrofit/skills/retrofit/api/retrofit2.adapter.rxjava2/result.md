# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Result

Package `retrofit2.adapter.rxjava2` · Artifact `com.squareup.retrofit2:adapter-rxjava2`

```java
public final class Result<T>
```

The result of executing an HTTP request — either a [`Response`](../retrofit2/response.md) or an error. Emitted by service methods returning `Observable<Result<T>>` (see [`RxJava2CallAdapterFactory`](rxjava2-call-adapter-factory.md)).

## Public Methods

### response

```java
static <T> Result<T> response(retrofit2.Response<T> response)
```

```java
@Nullable retrofit2.Response<T> response()
```

The static factory wraps a response; the instance accessor returns the received [`Response`](../retrofit2/response.md). Only present when [`isError`](#iserror) is false, null otherwise.

### error

```java
static <T> Result<T> error(java.lang.Throwable error)
```

```java
@Nullable java.lang.Throwable error()
```

The static factory wraps an error; the instance accessor returns the error experienced while attempting to execute the request. Only present when [`isError`](#iserror) is true, null otherwise.

If the error is an `IOException` there was a problem with the transport to the remote server. Any other exception type indicates an unexpected, fatal failure (configuration error, programming error, etc.).

### isError

```java
boolean isError()
```

`true` if the request resulted in an error. See [`error`](#error) for the cause.
