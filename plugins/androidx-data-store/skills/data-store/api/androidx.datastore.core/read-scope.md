# API Reference

> Last updated 2026-06-10

# ReadScope

> Added in 1.1.0

```
interface ReadScope<T : Any?> : Closeable
```

The scope used for a read transaction. Extends [`Closeable`](closeable.md).

## Known Direct Subtypes

| | |
|---|---|
| [`WriteScope`](write-scope.md) | The scope used for a write transaction. |

## Public Functions

### readData

```
suspend fun readData(): T
```

Read the data from the underlying storage.

## Inherited Functions

From [`Closeable`](closeable.md): `close()`.
