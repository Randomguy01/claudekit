# API Reference

> Last updated 2026-06-10

# RemoteWorkerService

> Added in 2.6.0

```
class RemoteWorkerService : Service
```

The `Service` which hosts an implementation of a [`ListenableWorker`](../androidx.work/listenable-worker.md). Declare it (or a subclass) in your manifest to host workers that run in a remote process. Ships in the `androidx.work:work-multiprocess` artifact.

## Public Constructors

### RemoteWorkerService

> Added in 2.6.0
```
RemoteWorkerService()
```

## Public Functions

### onBind

> Added in 2.6.0
```
fun onBind(intent: Intent): IBinder?
```

### onCreate

```
fun onCreate(): Unit
```

## Inherited Members

Inherits the rest of its API from the Android framework `Service`, `ContextWrapper`, and `Context` types.
