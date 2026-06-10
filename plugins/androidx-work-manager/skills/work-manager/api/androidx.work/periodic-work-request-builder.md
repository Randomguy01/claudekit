# API Reference

> Last updated 2026-06-10

# PeriodicWorkRequest.Builder

> Added in 1.0.0

```
class PeriodicWorkRequest.Builder : WorkRequest.Builder
```

Builder for [`PeriodicWorkRequest`](periodic-work-request.md)s.

The repeat interval must be greater than or equal to [`PeriodicWorkRequest.MIN_PERIODIC_INTERVAL_MILLIS`](periodic-work-request.md#min_periodic_interval_millis), and any flex interval must be greater than or equal to [`PeriodicWorkRequest.MIN_PERIODIC_FLEX_MILLIS`](periodic-work-request.md#min_periodic_flex_millis).

When a `flexInterval` is supplied, the work runs once within the **flex period** at the end of each interval. The flex period begins at `repeatInterval - flexInterval`:

```
[_____before flex_____|_____flex_____][_____before flex_____|_____flex_____]...
[___cannot run work___|_can run work_][___cannot run work___|_can run work_]...
\____________________________________/\____________________________________/...
interval 1                            interval 2             ...(repeat)
```

## Public Constructors

Each constructor comes in a `Class<ListenableWorker>` form and (since 2.10.0) a `KClass<ListenableWorker>` form, in interval-only and flex variants, accepting either a `Duration` or a `Long` + `TimeUnit`.

### Builder

> Added in 1.0.0 (`Class`) · 2.10.0 (`KClass`)
```
@RequiresApi(value = 26)
Builder(workerClass: Class<ListenableWorker>, repeatInterval: Duration)
```

Runs periodically once every interval period. The work is guaranteed to run exactly once during each interval (subject to OS battery optimizations such as Doze).

### Builder

> Added in 1.0.0 (`Class`) · 2.10.0 (`KClass`)
```
@RequiresApi(value = 26)
Builder(
    workerClass: Class<ListenableWorker>,
    repeatInterval: Duration,
    flexInterval: Duration
)
```

Runs periodically once within the flex period of every interval (see diagram above).

### Builder

> Added in 1.0.0 (`Class`) · 2.10.0 (`KClass`)
```
Builder(
    workerClass: Class<ListenableWorker>,
    repeatInterval: Long,
    repeatIntervalTimeUnit: TimeUnit
)
```

`Long` + `TimeUnit` form of the interval-only constructor.

### Builder

> Added in 1.0.0 (`Class`) · 2.10.0 (`KClass`)
```
Builder(
    workerClass: Class<ListenableWorker>,
    repeatInterval: Long,
    repeatIntervalTimeUnit: TimeUnit,
    flexInterval: Long,
    flexIntervalTimeUnit: TimeUnit
)
```

`Long` + `TimeUnit` form of the flex constructor.

## Public Functions

### clearNextScheduleTimeOverride

> Added in 2.9.0
```
fun clearNextScheduleTimeOverride(): PeriodicWorkRequest.Builder
```

Clears any override set by [`setNextScheduleTimeOverride`](#setnextscheduletimeoverride). When cleared, the next schedule is based on the previous enqueue/run time and the result of that run (e.g. for a `Retry` returned at time `T` with linear backoff, the schedule returns to `T + backoffInterval`). The override may be cleared while a worker is running; the worker then schedules its next run based on its result type and interval.

### setNextScheduleTimeOverride

> Added in 2.9.0
```
fun setNextScheduleTimeOverride(nextScheduleTimeOverrideMillis: Long): PeriodicWorkRequest.Builder
```

Overrides the next time this work is scheduled to run, overriding the normal interval, flex, initial delay, and backoff. Enables dynamic calculation of the next schedule (adaptive refresh times, custom retry behavior, drift-free scheduling). Use [`ExistingPeriodicWorkPolicy.UPDATE`](existing-periodic-work-policy.md#update) with these techniques to avoid cancelling a currently-running worker while scheduling the next one.

This sets only the single next schedule; afterwards the override is cleared and the work is scheduled normally. It can be called from inside or outside [`Worker.startWork`](worker.md); if the worker is currently running it overrides the next start, even if the current run returns `Retry`. [`MIN_PERIODIC_INTERVAL_MILLIS`](periodic-work-request.md#min_periodic_interval_millis) is enforced to prevent infinite loops.

> [!NOTE]
> Work will almost never run at this exact time. The scheduled time is assigned accurately, but actual run times depend on the system scheduler, Doze and power-saving modes, and any configured constraints.

## Inherited Members

Inherits the chainable setters from [`WorkRequest.Builder`](work-request-builder.md) (`addTag`, `setConstraints`, `setInputData`, `setBackoffCriteria`, `setInitialDelay`, `setExpedited`, `setId`, `keepResultsForAtLeast`, `setTraceTag`, `build`).
