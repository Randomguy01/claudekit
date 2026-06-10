# API Reference

> Last updated 2026-06-10

# Clock

> Added in 2.9.0

```
interface Clock
```

The interface WorkManager uses to access the current time. Install a custom clock via [`Configuration.Builder.setClock`](configuration-builder.md#setclock) (useful in tests).

## Public Functions

### currentTimeMillis

> Added in 2.9.0
```
fun currentTimeMillis(): Long
```

The current time in milliseconds, analogous to `System.currentTimeMillis()`.
