# API Reference

> Last updated 2026-06-10

# OneTimeWorkRequest

> Added in 1.0.0

```
class OneTimeWorkRequest : WorkRequest
```

A [`WorkRequest`](work-request.md) for non-repeating work. `OneTimeWorkRequest`s can be put in simple or complex graphs of work using methods like [`WorkManager.enqueue`](work-manager.md#enqueue) or [`WorkManager.beginWith`](work-manager.md#beginwith).

## Nested Types

| Type | Description |
|------|-------------|
| [`OneTimeWorkRequest.Builder`](one-time-work-request-builder.md) | Builder for `OneTimeWorkRequest`s. |

## Public Companion Functions

### from

> Added in 2.8.0
```
fun from(workerClass: Class<ListenableWorker>): OneTimeWorkRequest
```

Creates a `OneTimeWorkRequest` with defaults from a [`ListenableWorker`](listenable-worker.md) class.

### from

```
fun from(workerClasses: List<Class<ListenableWorker>>): List<OneTimeWorkRequest>
```

Creates a list of `OneTimeWorkRequest`s with defaults from a list of [`ListenableWorker`](listenable-worker.md) classes.

> [!TIP]
> For the idiomatic Kotlin builder, use the top-level [`OneTimeWorkRequestBuilder<W>()`](package-functions.md) function.
