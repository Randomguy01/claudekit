# API Reference

> Last updated 2026-06-10

# ProgressUpdater

> Added in 2.3.0

```
interface ProgressUpdater
```

Updates progress for a [`ListenableWorker`](listenable-worker.md).

## Public Functions

### updateProgress

> Added in 2.3.0
```
fun updateProgress(context: Context, id: UUID, data: Data): ListenableFuture<Void!>
```

Returns a `ListenableFuture` that resolves after the progress is persisted. Cancelling the future does not cancel the writes to the database.

- `context` — the application context.
- `id` — the `UUID` identifying the [`ListenableWorker`](listenable-worker.md).
- `data` — the progress [`Data`](data.md).
