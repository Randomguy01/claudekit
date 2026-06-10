# API Reference

> Last updated 2026-06-10

# WorkRequest

> Added in 1.0.0

```
abstract class WorkRequest
```

The base class for specifying parameters for work that should be enqueued in [`WorkManager`](work-manager.md). There are two concrete implementations: [`OneTimeWorkRequest`](one-time-work-request.md) and [`PeriodicWorkRequest`](periodic-work-request.md).

## Known Direct Subtypes

| Type | Description |
|------|-------------|
| [`OneTimeWorkRequest`](one-time-work-request.md) | A `WorkRequest` for non-repeating work. |
| [`PeriodicWorkRequest`](periodic-work-request.md) | A `WorkRequest` for repeating work. |

## Nested Types

| Type | Description |
|------|-------------|
| [`WorkRequest.Builder`](work-request-builder.md) | A builder for `WorkRequest`s. |

## Constants

### DEFAULT_BACKOFF_DELAY_MILLIS

```
const val DEFAULT_BACKOFF_DELAY_MILLIS = 30000: Long
```

The default initial backoff time (in milliseconds) for work that has to be retried.

### MAX_BACKOFF_MILLIS

```
const val MAX_BACKOFF_MILLIS: Long
```

The maximum backoff time (in milliseconds) for work that has to be retried.

### MIN_BACKOFF_MILLIS

```
const val MIN_BACKOFF_MILLIS: Long
```

The minimum backoff time (in milliseconds) for work that has to be retried.

## Public Properties

### id

> Added in 1.0.0
```
open val id: UUID
```

The unique identifier associated with this unit of work.
