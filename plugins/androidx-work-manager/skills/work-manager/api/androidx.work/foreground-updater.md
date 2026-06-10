# API Reference

> Last updated 2026-06-10

# ForegroundUpdater

> Added in 2.3.0

```
interface ForegroundUpdater
```

Manages updating `Notification`s when a [`ListenableWorker`](listenable-worker.md) transitions to running in the context of a foreground service.

## Public Functions

### setForegroundAsync

> Added in 2.3.0
```
fun setForegroundAsync(
    context: Context,
    id: UUID,
    foregroundInfo: ForegroundInfo
): ListenableFuture<Void!>
```

Returns a `ListenableFuture` that resolves after the [`ListenableWorker`](listenable-worker.md) transitions to running in the context of a foreground service.

- `context` — the application context.
- `id` — the `UUID` identifying the [`ListenableWorker`](listenable-worker.md).
- `foregroundInfo` — the [`ForegroundInfo`](foreground-info.md).
