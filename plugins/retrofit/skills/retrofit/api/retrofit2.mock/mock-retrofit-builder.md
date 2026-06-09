# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# MockRetrofit.Builder

Package `retrofit2.mock` · Enclosing class [`MockRetrofit`](mock-retrofit.md)

```java
public static final class MockRetrofit.Builder
```

Build a new [`MockRetrofit`](mock-retrofit.md).

## Public Constructors

### Builder

```java
Builder(retrofit2.Retrofit retrofit)
```

Start a builder wrapping the given [`Retrofit`](../retrofit2/retrofit.md) instance.

## Public Methods

### networkBehavior

```java
MockRetrofit.Builder networkBehavior(NetworkBehavior behavior)
```

Set the [`NetworkBehavior`](network-behavior.md) to apply. Defaults to a new instance from [`NetworkBehavior.create`](network-behavior.md#create).

### backgroundExecutor

```java
MockRetrofit.Builder backgroundExecutor(java.util.concurrent.ExecutorService executor)
```

Set the executor on which asynchronous behavior is simulated.

### build

```java
MockRetrofit build()
```

Create the [`MockRetrofit`](mock-retrofit.md) instance using the configured values.
