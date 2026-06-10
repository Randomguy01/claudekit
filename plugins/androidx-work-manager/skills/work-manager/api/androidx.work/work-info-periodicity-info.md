# API Reference

> Last updated 2026-06-10

# WorkInfo.PeriodicityInfo

> Added in 2.9.0

```
class WorkInfo.PeriodicityInfo
```

A periodic work's interval and flex duration, exposed via [`WorkInfo.periodicityInfo`](work-info.md#periodicityinfo).

## Public Constructors

### PeriodicityInfo

> Added in 2.9.0
```
PeriodicityInfo(repeatIntervalMillis: Long, flexIntervalMillis: Long)
```

## Public Properties

### flexIntervalMillis

> Added in 2.9.0
```
val flexIntervalMillis: Long
```

The duration in millis in which this work repeats from the end of the `repeatInterval`, as configured in [`PeriodicWorkRequest.Builder`](periodic-work-request-builder.md).

### repeatIntervalMillis

> Added in 2.9.0
```
val repeatIntervalMillis: Long
```

The periodic work's configured repeat interval in millis, as configured in [`PeriodicWorkRequest.Builder`](periodic-work-request-builder.md).
