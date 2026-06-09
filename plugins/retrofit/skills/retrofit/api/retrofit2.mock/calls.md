# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Calls

Package `retrofit2.mock` · Artifact `com.squareup.retrofit2:retrofit-mock`

```java
public final class Calls
```

Factory methods for creating [`Call`](../retrofit2/call.md) instances which immediately respond or fail. Useful for stubbing service methods in tests, often paired with [`BehaviorDelegate.returning`](behavior-delegate.md#returning).

## Public Methods

### response

```java
static <T> Call<T> response(T successValue)
static <T> Call<T> response(retrofit2.Response<T> response)
```

Create a [`Call`](../retrofit2/call.md) that immediately succeeds with `successValue` as the deserialized body, or with a full [`Response`](../retrofit2/response.md).

### failure

```java
static <T> Call<T> failure(java.io.IOException failure)
static <T> Call<T> failure(java.lang.Throwable failure)
```

Create a failed [`Call`](../retrofit2/call.md) from `failure`.

Note: when invoking `execute()` on the returned `Call`, if `failure` is a `RuntimeException`, `Error`, or `IOException` subtype it is thrown directly. Otherwise it is "sneaky thrown" despite not being declared.

### defer

```java
static <T> Call<T> defer(java.util.concurrent.Callable<retrofit2.Call<T>> callable)
```

Invokes `callable` once for the returned [`Call`](../retrofit2/call.md) and once for each instance obtained from cloning the returned `Call`.
