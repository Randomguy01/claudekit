# API Reference

> Last updated 2026-06-11

# EarlyEntryPoints

```java
@Beta
public final class EarlyEntryPoints
```

Static utility methods for accessing entry points annotated with [`@EarlyEntryPoint`](early-entry-point.md).

## Public Methods

### get

```java
public static <T> T get(Context applicationContext, Class<T> entryPoint)
```

Returns the early entry point interface from the application's component manager holder. This performs an unsafe cast, so the caller must ensure the component matches the given early entry point interface.

- `applicationContext` — the application context.
- `entryPoint` — the interface annotated with [`@EarlyEntryPoint`](early-entry-point.md); its [`@InstallIn`](../dagger.hilt/install-in.md) component should match.
