# Threading in WorkManager

WorkManager performs background work asynchronously on your behalf, and the basic implementation addresses most apps' needs. For more advanced use cases — such as correctly handling work being stopped — understand threading and concurrency in WorkManager.

WorkManager provides four work primitives:

- [`Worker`](../api/androidx.work/worker.md) is the simplest implementation, and the one used in previous sections. WorkManager automatically runs it on a background thread, which you can override. See [Threading in Worker](threading-worker.md).
- [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) is the recommended implementation for Kotlin users. It exposes a suspending function for background work and runs on a default `Dispatcher` that you can customize. See [Threading in CoroutineWorker](threading-coroutine-worker.md).
- [`RxWorker`](../api/androidx.work/rx-worker.md) is the recommended implementation for RxJava users — use it if much of your existing asynchronous code is modeled in RxJava. As with all RxJava, you choose the threading strategy. See [Threading in RxWorker](threading-rxworker.md).
- [`ListenableWorker`](../api/androidx.work/listenable-worker.md) is the base class for `Worker`, `CoroutineWorker`, and `RxWorker`. It's intended for Java developers who interact with callback-based asynchronous APIs such as `FusedLocationProviderClient` and aren't using RxJava. See [Threading in ListenableWorker](threading-listenableworker.md).
