# API Reference

> Last updated 2026-06-10

# RemoteWorkContinuation

> Added in 2.5.0

```
abstract class RemoteWorkContinuation
```

Provides a subset of [`WorkContinuation`](../androidx.work/work-continuation.md) APIs that are available for apps that use multiple processes. Obtain instances from [`RemoteWorkManager.beginWith`](remote-work-manager.md#beginwith) / [`beginUniqueWork`](remote-work-manager.md#beginuniquework).

## Public Functions

### combine

> Added in 2.5.0
```
java-static fun combine(continuations: (Mutable)List<RemoteWorkContinuation!>): RemoteWorkContinuation
```

Combines multiple `RemoteWorkContinuation`s as prerequisites for a new `RemoteWorkContinuation`, to allow for complex chaining.

### enqueue

> Added in 2.5.0
```
abstract fun enqueue(): ListenableFuture<Void!>
```

Enqueues this `RemoteWorkContinuation` on the background thread. Returns a `ListenableFuture` that can be used to determine when the enqueue has completed.

### then

> Added in 2.5.0
```
fun then(work: OneTimeWorkRequest): RemoteWorkContinuation
abstract fun then(work: (Mutable)List<OneTimeWorkRequest!>): RemoteWorkContinuation
```

Adds new [`OneTimeWorkRequest`](../androidx.work/one-time-work-request.md)(s) that depend on the successful completion of all previously added requests, returning a new `RemoteWorkContinuation` for further chaining.
