# API Reference

> Last updated 2026-06-10

# IOException

> Added in 1.2.0

DataStore's common-multiplatform `IOException`. On the JVM/Android it is a type alias to `java.io.IOException`; on other platforms it is a class defined by DataStore.

**Common**

```
open class IOException : Exception
```

**Android**

```
actual typealias IOException = IOException : Exception
```

Common `IOException` to be defined in JVM and native code.

## Known Direct Subtypes

| | |
|---|---|
| [`CorruptionException`](corruption-exception.md) | A subclass indicating that the file could not be de-serialized due to data-format corruption. |

## Public Constructors

**Common**

```
IOException(message: String?)
```

**Common**

```
IOException(message: String?, cause: Throwable?)
```

## Inherited Members

Inherits the standard members of `kotlin.Throwable` (`message`, `cause`, `printStackTrace()`, etc.).
