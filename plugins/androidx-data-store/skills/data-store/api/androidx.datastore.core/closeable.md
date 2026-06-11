# API Reference

> Last updated 2026-06-10

# Closeable

> Added in 1.1.0

```
interface Closeable
```

DataStore's common-multiplatform version of `java.io.Closeable`.

## Known Direct Subtypes

| | |
|---|---|
| [`ReadScope`](read-scope.md) | The scope used for a read transaction. |
| [`StorageConnection`](storage-connection.md) | Provides a way to read and write a particular type of data. |

Known indirect subtypes: [`WriteScope`](write-scope.md).

## Public Functions

### close

> Added in 1.1.0

```
fun close(): Unit
```

Closes the resource.
