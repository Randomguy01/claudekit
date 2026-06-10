# API Reference

> Last updated 2026-06-10

# WorkContinuation

> Added in 1.0.0

```
abstract class WorkContinuation
```

A class that allows you to chain together [`OneTimeWorkRequest`](one-time-work-request.md)s into arbitrary acyclic graphs of work dependencies. Add dependent work with [`then`](#then), and combine multiple continuations with [`combine`](#combine). Because of its fluent nature, this class is usually invisible in practice.

Enqueuing a `WorkContinuation` enqueues all previously-unenqueued prerequisites. You must call [`enqueue`](#enqueue) to actually submit the graph; enqueues are asynchronous, and you can observe or block on the returned [`Operation`](operation.md).

Build a diamond graph (A→B and C→D, both feeding E) like this:

```kotlin
val left = workManager.beginWith(A).then(B)
val right = workManager.beginWith(C).then(D)
WorkContinuation.combine(listOf(left, right)).then(E).enqueue()
```

## Public Constructors

### WorkContinuation

> Added in 1.0.0
```
WorkContinuation()
```

## Public Functions

### combine

> Added in 1.0.0
```
java-static fun combine(continuations: (Mutable)List<WorkContinuation!>): WorkContinuation
```

Combines multiple `WorkContinuation`s as prerequisites for a new `WorkContinuation`, enabling complex chaining.

### enqueue

> Added in 1.0.0
```
abstract fun enqueue(): Operation
```

Enqueues this `WorkContinuation` on the background thread. Returns an [`Operation`](operation.md) that can be used to determine when the enqueue completes.

### then

> Added in 1.0.0
```
fun then(work: OneTimeWorkRequest): WorkContinuation
abstract fun then(work: (Mutable)List<OneTimeWorkRequest!>): WorkContinuation
```

Adds new [`OneTimeWorkRequest`](one-time-work-request.md)(s) that depend on the successful completion of all previously added requests, returning a new `WorkContinuation` for further chaining.

### getWorkInfos

> Added in 1.0.0
```
abstract fun getWorkInfos(): ListenableFuture<(Mutable)List<WorkInfo!>!>
```

Returns a `ListenableFuture` of the [`WorkInfo`](work-info.md)s for each [`OneTimeWorkRequest`](one-time-work-request.md) in this continuation and its prerequisites.

### getWorkInfosLiveData

> Added in 1.0.0
```
abstract fun getWorkInfosLiveData(): LiveData<(Mutable)List<WorkInfo!>!>
```

Returns a `LiveData` of the [`WorkInfo`](work-info.md)s for each request in this continuation and its prerequisites; attached observers trigger when any state or output changes.
