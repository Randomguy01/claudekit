# API Reference

> Last updated 2026-06-10

# CorruptionException

> Added in 1.0.0

```
class CorruptionException : IOException
```

A subclass of [`IOException`](io-exception.md) indicating that the file could not be de-serialized due to data-format corruption. It should **not** be thrown when the `IOException` is due to a transient IO or permissions issue.

## Public Constructors

### CorruptionException

> Added in 1.0.0

```
CorruptionException(message: String, cause: Throwable? = null)
```

## Inherited Members

Inherits the standard members of `kotlin.Throwable` (`message`, `cause`, `printStackTrace()`, etc.) via [`IOException`](io-exception.md).
