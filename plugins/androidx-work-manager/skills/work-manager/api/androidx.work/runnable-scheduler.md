# API Reference

> Last updated 2026-06-10

# RunnableScheduler

> Added in 2.4.0

```
interface RunnableScheduler
```

Can be used to schedule `Runnable`s after a delay in milliseconds. Used by the in-process scheduler to schedule timed work. Install a custom one via [`Configuration.Builder.setRunnableScheduler`](configuration-builder.md#setrunnablescheduler).

## Public Functions

### cancel

> Added in 2.4.0
```
fun cancel(runnable: Runnable): Unit
```

Cancels a `Runnable` previously scheduled with [`scheduleWithDelay`](#schedulewithdelay).

### scheduleWithDelay

> Added in 2.4.0
```
fun scheduleWithDelay(
    delayInMillis: @IntRange(from = 0) Long,
    runnable: Runnable
): Unit
```

Schedules a `Runnable` to run after a delay (in milliseconds) relative to the current time.
