# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Invocation

Package `retrofit2`

```java
public final class Invocation
```

A single invocation of a Retrofit service interface method. This class captures both the method that was called and the arguments to the method.

Retrofit automatically adds an invocation to each OkHttp request as a tag. You can retrieve the invocation in an OkHttp interceptor for metrics and monitoring.

```java
class InvocationLogger implements Interceptor {
  @Override public Response intercept(Chain chain) throws IOException {
    Request request = chain.request();
    Invocation invocation = request.tag(Invocation.class);
    if (invocation != null) {
      System.out.printf("%s.%s %s%n",
          invocation.service().getSimpleName(),
          invocation.method().getName(),
          invocation.arguments());
    }
    return chain.proceed(request);
  }
}
```

**Note:** use caution when examining an invocation's arguments. Although the arguments list is unmodifiable, the arguments themselves may be mutable. They may also be unsafe for concurrent access. For best results declare Retrofit service interfaces using only immutable types for parameters.

## Public Methods

### of

```java
static <T> Invocation of(java.lang.Class<T> service,
                         T instance,
                         java.lang.reflect.Method method,
                         java.util.List<?> arguments)
```

```java
@Deprecated
static Invocation of(java.lang.reflect.Method method, java.util.List<?> arguments)
```

**Deprecated** — the `(Method, List)` overload creates an invocation without a service instance; prefer the overload that takes `service` and `instance`.

### service

```java
java.lang.Class<?> service()
```

### instance

```java
@Nullable java.lang.Object instance()
```

The instance of [`service`](#service). This is never null when created by Retrofit; null is only returned when created by the deprecated [`of(Method, List)`](#of).

### method

```java
java.lang.reflect.Method method()
```

### arguments

```java
java.util.List<?> arguments()
```

### toString

```java
java.lang.String toString()
```
