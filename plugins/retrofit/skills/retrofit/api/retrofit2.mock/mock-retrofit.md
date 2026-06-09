# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# MockRetrofit

Package `retrofit2.mock` · Artifact `com.squareup.retrofit2:retrofit-mock`

```java
public final class MockRetrofit
```

Wraps a [`Retrofit`](../retrofit2/retrofit.md) instance to create [`BehaviorDelegate`](behavior-delegate.md) instances for mock implementations of service interfaces, applying simulated [`NetworkBehavior`](network-behavior.md). Build with [`MockRetrofit.Builder`](mock-retrofit-builder.md).

```java
Retrofit retrofit = new Retrofit.Builder().baseUrl("https://example.com/").build();
NetworkBehavior behavior = NetworkBehavior.create();
MockRetrofit mockRetrofit = new MockRetrofit.Builder(retrofit)
    .networkBehavior(behavior)
    .build();

BehaviorDelegate<MyApi> delegate = mockRetrofit.create(MyApi.class);
```

## Nested Types

| Type | Description |
|------|-------------|
| [`MockRetrofit.Builder`](mock-retrofit-builder.md) | Build a new `MockRetrofit`. |

## Public Methods

### retrofit

```java
retrofit2.Retrofit retrofit()
```

The underlying [`Retrofit`](../retrofit2/retrofit.md) instance.

### networkBehavior

```java
NetworkBehavior networkBehavior()
```

The [`NetworkBehavior`](network-behavior.md) applied to created delegates.

### backgroundExecutor

```java
java.util.concurrent.Executor backgroundExecutor()
```

The executor on which asynchronous behavior (delay, failure) is simulated.

### create

```java
<T> BehaviorDelegate<T> create(java.lang.Class<T> service)
```

Create a [`BehaviorDelegate`](behavior-delegate.md) for the `service` interface, used to build a mock implementation.
