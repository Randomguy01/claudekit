# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# HttpException

Package `retrofit2`

```java
public class HttpException extends java.lang.RuntimeException
```

Exception for an unexpected, non-2xx HTTP response.

## Public Constructors

### HttpException

```java
HttpException(Response<?> response)
```

## Public Methods

### code

```java
int code()
```

HTTP status code.

### message

```java
java.lang.String message()
```

HTTP status message.

### response

```java
@Nullable Response<?> response()
```

The full HTTP response. This may be null if the exception was serialized.
