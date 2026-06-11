# API Reference

> Last updated 2026-06-11

# EntryPoints

```java
public final class EntryPoints
```

Static utility methods for accessing objects through entry points. Use it to retrieve an [`@EntryPoint`](entry-point.md)-annotated interface from a Hilt-generated component or component manager.

## Public Methods

### get

```java
public static <T> T get(Object component, Class<T> entryPoint)
```

Returns the `entryPoint` interface from a component or component manager. This performs an unsafe cast, so the caller must ensure the given component/component manager matches the entry point interface.

- `component` — the Hilt-generated component; for convenience a component manager instance is also accepted.
- `entryPoint` — the interface annotated with [`@EntryPoint`](entry-point.md). Its [`@InstallIn`](install-in.md) component should match `component`.
</content>
