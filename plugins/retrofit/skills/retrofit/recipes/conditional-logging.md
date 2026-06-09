# Log Selected Methods Only

To enable verbose logging on specific endpoints without flooding output for the rest, mark those methods with a custom annotation and gate the logging interceptor on it. The [`Invocation`](../api/retrofit2/invocation.md) tag exposes the invoked method, so the interceptor can check for the annotation per request.

Declare the marker and apply it only where wanted:

```kotlin
annotation class Log

private interface ExampleApi {
  @GET("one") suspend fun one(): ResponseBody

  @Log @GET("two") suspend fun two(): ResponseBody
}
```

Wrap OkHttp's `HttpLoggingInterceptor` and delegate to it only when the method carries `@Log`:

```kotlin
class ConditionalLoggingInterceptor(
  private val loggingInterceptor: HttpLoggingInterceptor,
) : Interceptor {
  override fun intercept(chain: Interceptor.Chain): Response {
    val request = chain.request()
    request.tag(Invocation::class.java)?.let { invocation ->
      if (invocation.method().isAnnotationPresent(Log::class.java)) {
        return loggingInterceptor.intercept(chain)
      }
    }
    return chain.proceed(request)
  }
}
```

Register it on the client like any other interceptor:

```kotlin
val client = OkHttpClient.Builder()
    .addInterceptor(ConditionalLoggingInterceptor(
        HttpLoggingInterceptor(::println).setLevel(HttpLoggingInterceptor.Level.BODY)))
    .build()
```

> [!NOTE]
> `HttpLoggingInterceptor` lives in the `com.squareup.okhttp3:logging-interceptor` module. The flag is read from the method annotation, not request state, so it is fixed per endpoint at declaration time.

This reuses the same [`Invocation`](../api/retrofit2/invocation.md) tag covered in [Record Per-Method Metrics](invocation-metrics.md). For request-scoped values instead of method-level markers, attach a [`@Tag`](../api/retrofit2.http/tag.md) parameter and read it from the request.
