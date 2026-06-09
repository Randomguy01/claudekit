# Adapt Calls to a Custom Callback

A custom [`CallAdapter`](../api/retrofit2/call-adapter.md) lets methods return a type other than [`Call`](../api/retrofit2/call.md). This example adapts to a `MyCall` whose callback splits outcomes by HTTP status class instead of the single `onResponse`/`onFailure` of [`Callback`](../api/retrofit2/callback.md).

Register a [`CallAdapter.Factory`](../api/retrofit2/call-adapter-factory.md) that matches the return type and extracts its generic response type:

```java
public static class ErrorHandlingCallAdapterFactory extends CallAdapter.Factory {
  @Override public @Nullable CallAdapter<?, ?> get(
      Type returnType, Annotation[] annotations, Retrofit retrofit) {
    if (getRawType(returnType) != MyCall.class) {
      return null; // not ours — let another factory handle it
    }
    if (!(returnType instanceof ParameterizedType)) {
      throw new IllegalStateException(
          "MyCall must have generic type (e.g., MyCall<ResponseBody>)");
    }
    Type responseType = getParameterUpperBound(0, (ParameterizedType) returnType);
    Executor callbackExecutor = retrofit.callbackExecutor();
    return new ErrorHandlingCallAdapter<>(responseType, callbackExecutor);
  }
}
```

The adapter's `adapt(Call<R>)` wraps the underlying call. Inside, route the response by status code:

```java
call.enqueue(new Callback<T>() {
  @Override public void onResponse(Call<T> call, Response<T> response) {
    int code = response.code();
    if (code >= 200 && code < 300) {
      callback.success(response);
    } else if (code == 401) {
      callback.unauthenticated(response);
    } else if (code >= 400 && code < 500) {
      callback.clientError(response);
    } else if (code >= 500 && code < 600) {
      callback.serverError(response);
    } else {
      callback.unexpectedError(new RuntimeException("Unexpected response " + response));
    }
  }

  @Override public void onFailure(Call<T> call, Throwable t) {
    if (t instanceof IOException) {
      callback.networkError((IOException) t);
    } else {
      callback.unexpectedError(t);
    }
  }
});
```

Register the factory on the builder, after which methods may return `MyCall<T>`:

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://httpbin.org")
    .addCallAdapterFactory(new ErrorHandlingCallAdapterFactory())
    .build();
```

> [!NOTE]
> `getRawType`, `getParameterUpperBound`, and `callbackExecutor()` are the building blocks for any custom factory: identify your type, pull out its response type, and respect the configured callback executor so results dispatch on the expected thread.
