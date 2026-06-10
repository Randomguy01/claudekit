# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# CallAdapter.Factory

Package `retrofit2` · Enclosing interface [`CallAdapter`](call-adapter.md)

```java
public abstract static class CallAdapter.Factory
```

Creates [`CallAdapter`](call-adapter.md) instances based on the return type of [the service interface](retrofit.md#create) methods.

## Public Constructors

### Factory

```java
Factory()
```

## Public Methods

### get

```java
@Nullable
abstract CallAdapter<?, ?> get(java.lang.reflect.Type returnType,
                               java.lang.annotation.Annotation[] annotations,
                               Retrofit retrofit)
```

Returns a call adapter for interface methods that return `returnType`, or null if it cannot be handled by this factory.

### getParameterUpperBound

```java
protected static java.lang.reflect.Type getParameterUpperBound(
    int index,
    java.lang.reflect.ParameterizedType type)
```

Extract the upper bound of the generic parameter at `index` from `type`. For example, index 1 of `Map<String, ? extends Runnable>` returns `Runnable`.

### getRawType

```java
protected static java.lang.Class<?> getRawType(java.lang.reflect.Type type)
```

Extract the raw class type from `type`. For example, the type representing `List<? extends Runnable>` returns `List.class`.
