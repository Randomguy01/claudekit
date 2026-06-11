# API Reference

> Last updated 2026-06-10

# WriteScope

> Added in 1.1.0

```
interface WriteScope<T : Any?> : ReadScope
```

The scope used for a write transaction. Extends [`ReadScope`](read-scope.md).

## Public Functions

### writeData

> Added in 1.1.0

```
suspend fun writeData(value: T): Unit
```

Writes the data to the underlying storage.

## Inherited Functions

From [`Closeable`](closeable.md): `close()`. From [`ReadScope`](read-scope.md): `readData()`.
