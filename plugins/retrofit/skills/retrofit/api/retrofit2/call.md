# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Call

Package `retrofit2`

```java
public interface Call<T> extends java.lang.Cloneable
```

Type parameter `T` — successful response body type.

An invocation of a Retrofit method that sends a request to a webserver and returns a response. Each call yields its own HTTP request and response pair. Use [`clone`](#clone) to make multiple calls with the same parameters to the same webserver; this may be used to implement polling or to retry a failed call.

Calls may be executed synchronously with [`execute`](#execute), or asynchronously with [`enqueue`](#enqueue). In either case the call can be canceled at any time with [`cancel`](#cancel). A call that is busy writing its request or reading its response may receive an `IOException`; this is working as designed.

## Public Methods

### execute

```java
Response<T> execute() throws java.io.IOException
```

Synchronously send the request and return its response. Throws `java.io.IOException` if a problem occurred talking to the server, and `java.lang.RuntimeException` (and subclasses) if an unexpected error occurs creating the request or decoding the response.

### enqueue

```java
void enqueue(Callback<T> callback)
```

Asynchronously send the request and notify `callback` of its response, or if an error occurred talking to the server, creating the request, or processing the response.

### isExecuted

```java
boolean isExecuted()
```

Returns true if this call has been either [executed](#execute) or [enqueued](#enqueue). It is an error to execute or enqueue a call more than once.

### cancel

```java
void cancel()
```

Cancel this call. An attempt will be made to cancel in-flight calls, and if the call has not yet been executed it never will be.

### isCanceled

```java
boolean isCanceled()
```

True if [`cancel`](#cancel) was called.

### clone

```java
Call<T> clone()
```

Create a new, identical call to this one which can be enqueued or executed even if this call has already been.

### request

```java
okhttp3.Request request()
```

The original HTTP request.

### timeout

```java
okio.Timeout timeout()
```

Returns a timeout that spans the entire call: resolving DNS, connecting, writing the request body, server processing, and reading the response body. If the call requires redirects or retries all must complete within one timeout period.
