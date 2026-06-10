# API Reference

> Last updated 2026-06-10

# PeriodicWorkRequest

> Added in 1.0.0

```
class PeriodicWorkRequest : WorkRequest
```

A [`WorkRequest`](work-request.md) for repeating work. This work executes multiple times until cancelled, with the first execution happening immediately or as soon as the given [`Constraints`](constraints.md) are met. The next execution happens during the period interval; execution may be delayed because [`WorkManager`](work-manager.md) is subject to OS battery optimizations such as Doze mode.

Control when the work executes within the period more exactly via the `flexInterval` — see [`PeriodicWorkRequest.Builder`](periodic-work-request-builder.md).

> [!IMPORTANT]
> Periodic work has a minimum interval of 15 minutes. If the work has constraints, it will not execute until the constraints are met, even after the period delay.

Use periodic work when you want a fairly consistent delay between consecutive runs and can accept inexactness due to battery optimizations and Doze mode. To run work exactly at a certain time or only during a certain window, use a [`OneTimeWorkRequest`](one-time-work-request.md) instead.

The normal lifecycle is `ENQUEUED -> RUNNING -> ENQUEUED`. Periodic work cannot terminate in a succeeded or failed state — it can only terminate if explicitly cancelled. On retries, it still backs off according to [`PeriodicWorkRequest.Builder.setBackoffCriteria`](work-request-builder.md#setbackoffcriteria). Periodic work cannot be part of a chain or graph of work.

## Nested Types

| Type | Description |
|------|-------------|
| [`PeriodicWorkRequest.Builder`](periodic-work-request-builder.md) | Builder for `PeriodicWorkRequest`s. |

## Constants

### MIN_PERIODIC_FLEX_MILLIS

```
const val MIN_PERIODIC_FLEX_MILLIS: Long
```

The minimum flex duration for a `PeriodicWorkRequest` (in milliseconds).

### MIN_PERIODIC_INTERVAL_MILLIS

```
const val MIN_PERIODIC_INTERVAL_MILLIS: Long
```

The minimum interval duration for a `PeriodicWorkRequest` (in milliseconds).
