# API Reference

> Last updated 2026-06-08

# EmptyResultSetException

> Added in 2.0.0

**Android**
```
open class EmptyResultSetException : RuntimeException
```

Thrown by Room when the query in an RxJava `Single` DAO method needs to return a result but the returned result from the database is empty.

Since a `Single` must either emit a single non-null value or an error, this exception is thrown instead of emitting a null value when the query result is empty. If the `Single` contains a type argument of a collection (e.g. `Single<List<Song>>`), then this exception is not thrown and an empty collection is emitted instead.

This type is provided by the `androidx.room:room-rxjava2` artifact.

## Public Constructors

### EmptyResultSetException

> Added in 2.0.0
```
EmptyResultSetException(message: String)
```

## Inherited Members

This class extends `RuntimeException` and inherits the standard `kotlin.Throwable` API (e.g. `message`, `cause`, `stackTrace`, `printStackTrace()`).
