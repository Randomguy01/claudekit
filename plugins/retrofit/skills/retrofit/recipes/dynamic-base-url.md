# Change the Base URL at Runtime

To switch hosts after the [`Retrofit`](../api/retrofit2/retrofit.md) instance is built — for example to move between staging and production, or between regional endpoints — rewrite the request URL in an OkHttp `Interceptor` rather than rebuilding Retrofit.

```java
final class HostSelectionInterceptor implements Interceptor {
  private volatile String host;

  void setHost(String host) {
    this.host = host;
  }

  @Override public okhttp3.Response intercept(Chain chain) throws IOException {
    Request request = chain.request();
    String host = this.host;
    if (host != null) {
      HttpUrl newUrl = request.url().newBuilder().host(host).build();
      request = request.newBuilder().url(newUrl).build();
    }
    return chain.proceed(request);
  }
}
```

Install it on the OkHttp client supplied to the builder, then change the host at any time:

```java
HostSelectionInterceptor hostSelection = new HostSelectionInterceptor();
OkHttpClient client = new OkHttpClient.Builder()
    .addInterceptor(hostSelection)
    .build();

Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://staging.example.com/")
    .callFactory(client)
    .build();

hostSelection.setHost("prod.example.com"); // subsequent calls hit the new host
```

> [!NOTE]
> The interceptor rewrites only the host here; use the other `HttpUrl.Builder` setters (`scheme`, `port`) to swap more of the URL. To override the full URL per call instead, declare a [`@Url`](../api/retrofit2.http/url.md) parameter.
