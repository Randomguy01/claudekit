# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Callback

Package `retrofit2`

```java
public interface Callback<T>
```

Type parameter `T` — successful response body type.

Communicates responses from a server or offline requests. One and only one method will be invoked in response to a given request.

Callback methods are executed using the [`Retrofit`](retrofit.md) callback executor. When none is specified, the following defaults are used:

- **Android** — callbacks are executed on the application's main (UI) thread.
- **JVM** — callbacks are executed on the background thread which performed the request.

## Public Methods

### onResponse

```java
void onResponse(Call<T> call, Response<T> response)
```

Invoked for a received HTTP response.

Note: an HTTP response may still indicate an application-level failure such as a 404 or 500. Call [`Response.isSuccessful`](response.md#issuccessful) to determine if the response indicates success.

### onFailure

```java
void onFailure(Call<T> call, java.lang.Throwable t)
```

Invoked when a network exception occurred talking to the server or when an unexpected exception occurred creating the request or processing the response.
