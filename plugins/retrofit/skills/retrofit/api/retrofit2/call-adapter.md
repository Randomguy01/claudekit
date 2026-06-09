# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# CallAdapter

Package `retrofit2`

```java
public interface CallAdapter<R, T>
```

Adapts a [`Call`](call.md) with response type `R` into the type of `T`. Instances are created by [a factory](call-adapter-factory.md) which is installed into the [`Retrofit`](retrofit.md) instance.

## Nested Types

| Type | Description |
|------|-------------|
| [`CallAdapter.Factory`](call-adapter-factory.md) | Creates `CallAdapter` instances based on the return type of service interface methods. |

## Public Methods

### responseType

```java
java.lang.reflect.Type responseType()
```

Returns the value type that this adapter uses when converting the HTTP response body to a Java object. For example, the response type for `Call<Repo>` is `Repo`. This type is used to prepare the `call` passed to [`adapt`](#adapt).

Note: this is typically not the same type as the `returnType` provided to this call adapter's factory.

### adapt

```java
T adapt(Call<R> call)
```

Returns an instance of `T` which delegates to `call`.

For example, given an instance for a hypothetical utility `Async`, this instance would return a new `Async<R>` which invoked `call` when run.

```java
@Override
public <R> Async<R> adapt(final Call<R> call) {
  return Async.create(new Callable<Response<R>>() {
    @Override
    public Response<R> call() throws Exception {
      return call.execute();
    }
  });
}
```
