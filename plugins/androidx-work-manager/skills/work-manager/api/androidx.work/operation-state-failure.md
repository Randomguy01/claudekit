# API Reference

> Last updated 2026-06-10

# Operation.State.FAILURE

> Added in 1.0.0

```
class Operation.State.FAILURE : Operation.State
```

Represents an [`Operation`](operation.md) which has failed. The failure surfaces as a `Throwable` on the future returned by [`Operation.getResult`](operation.md#getresult).

## Public Constructors

### FAILURE

> Added in 1.0.0
```
FAILURE(exception: Throwable)
```

## Public Functions

### getThrowable

> Added in 1.0.0
```
fun getThrowable(): Throwable
```

The `Throwable` which caused the [`Operation`](operation.md) to fail.

### toString

```
fun toString(): String
```
