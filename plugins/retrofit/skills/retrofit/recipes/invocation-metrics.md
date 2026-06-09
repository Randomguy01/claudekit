# Record Per-Method Metrics

Retrofit attaches an [`Invocation`](../api/retrofit2/invocation.md) to every OkHttp request as a tag, carrying the service interface, the invoked method, and the argument values. Read it from an `Interceptor` to attribute timing, logging, or metrics back to the exact API method that triggered the call.

```java
static final class InvocationLogger implements Interceptor {
  @Override public Response intercept(Chain chain) throws IOException {
    Request request = chain.request();
    long startNanos = System.nanoTime();
    Response response = chain.proceed(request);
    long elapsedNanos = System.nanoTime() - startNanos;

    Invocation invocation = request.tag(Invocation.class);
    if (invocation != null) {
      System.out.printf("%s.%s %s HTTP %s (%.0f ms)%n",
          invocation.service().getSimpleName(),
          invocation.method().getName(),
          invocation.arguments(),
          response.code(),
          elapsedNanos / 1_000_000.0);
    }

    return response;
  }
}
```

Install it on the OkHttp client supplied to the builder:

```java
OkHttpClient client = new OkHttpClient.Builder()
    .addInterceptor(new InvocationLogger())
    .build();

Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://square.com/")
    .callFactory(client)
    .build();
```

> [!NOTE]
> Always null-check `request.tag(Invocation.class)`. The tag is only present on requests Retrofit generated, so a shared OkHttp client serving non-Retrofit traffic will see `null`.

The same `Invocation` tag drives method-level [conditional logging](conditional-logging.md): inspect `invocation.method()` for an annotation to decide what to do per endpoint.
