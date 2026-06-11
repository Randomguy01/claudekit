# API Reference

> Last updated 2026-06-11

# Lazy

```java
public interface Lazy<T extends @Nullable Object>
```

A handle to a lazily-computed value. Each `Lazy` computes its value on the first call to [`get()`](#get) and returns that same value on every subsequent call. All implementations are expected to be thread-safe and compute their value at most once.

Compare the three injection forms:

- **Direct injection** (`Foo foo`) — the value is computed before it is injected.
- **Provider injection** (`Provider<Foo>`) — a new value is computed on every call to `Provider.get()`.
- **Lazy injection** (`Lazy<Foo>`) — the value is computed lazily on the first call to `get()`, then cached for later calls.

Each injected `Lazy` is independent and remembers its value in isolation from other `Lazy` instances. To share a single instance among multiple clients, scope the binding (for example with `@Singleton`) and inject `Lazy` to defer computation within each client.

## Public Methods

### get

```java
T get()
```

Returns the underlying value, computing it on the first call. Every call on the same `Lazy` instance returns the same value.
