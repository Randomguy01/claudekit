# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Response

Package `retrofit2`

```java
public final class Response<T>
```

An HTTP response.

## Public Methods

### success

```java
static <T> Response<T> success(@Nullable T body)
static <T> Response<T> success(int code, @Nullable T body)
static <T> Response<T> success(@Nullable T body, okhttp3.Headers headers)
static <T> Response<T> success(@Nullable T body, okhttp3.Response rawResponse)
```

Create a synthetic successful response with `body` as the deserialized body. Overloads let you also specify an HTTP status `code`, custom `headers`, or a full `rawResponse`.

### error

```java
static <T> Response<T> error(int code, okhttp3.ResponseBody body)
static <T> Response<T> error(okhttp3.ResponseBody body, okhttp3.Response rawResponse)
```

Create an error response with `body` as the error body, either from a synthetic HTTP status `code` or from an existing `rawResponse`.

### raw

```java
okhttp3.Response raw()
```

The raw response from the HTTP client.

### code

```java
int code()
```

HTTP status code.

### message

```java
java.lang.String message()
```

HTTP status message or null if unknown.

### headers

```java
okhttp3.Headers headers()
```

HTTP headers.

### isSuccessful

```java
boolean isSuccessful()
```

Returns true if [`code`](#code) is in the range [200..300).

### body

```java
@Nullable T body()
```

The deserialized response body of a [successful](#issuccessful) response.

### errorBody

```java
@Nullable okhttp3.ResponseBody errorBody()
```

The raw response body of an [unsuccessful](#issuccessful) response.

### toString

```java
java.lang.String toString()
```
