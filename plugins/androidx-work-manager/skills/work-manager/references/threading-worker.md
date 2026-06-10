# Threading in Worker

When you use a [`Worker`](../api/androidx.work/worker.md), WorkManager automatically calls [`Worker.doWork()`](../api/androidx.work/worker.md) on a background thread. The background thread comes from the `Executor` specified in WorkManager's [`Configuration`](../api/androidx.work/configuration.md). By default, WorkManager sets up an `Executor` for you, but you can customize it — for example, share an existing background Executor in your app, create a single-threaded `Executor` so all background work runs sequentially, or specify a custom `Executor`. To customize the `Executor`, initialize WorkManager manually:

```kotlin
WorkManager.initialize(
    context,
    Configuration.Builder()
        // Uses a fixed thread pool of size 8 threads.
        .setExecutor(Executors.newFixedThreadPool(8))
        .build())
```

This simple `Worker` downloads the contents of a webpage 100 times:

```kotlin
class DownloadWorker(context: Context, params: WorkerParameters) : Worker(context, params) {

    override fun doWork(): ListenableWorker.Result {
        repeat(100) {
            try {
                downloadSynchronously("https://www.google.com")
            } catch (e: IOException) {
                return ListenableWorker.Result.failure()
            }
        }

        return ListenableWorker.Result.success()
    }
}
```

> [!IMPORTANT]
> `Worker.doWork()` is a synchronous call — do the entirety of your background work in a blocking fashion and finish it by the time the method exits. If you call an asynchronous API in `doWork()` and return a [`Result`](../api/androidx.work/listenable-worker-result.md), your callback may not operate properly. In that situation, use a [`ListenableWorker`](../api/androidx.work/listenable-worker.md) instead (see [Threading in ListenableWorker](threading-listenableworker.md)).

When a running `Worker` is [stopped for any reason](managing-work.md#cancelling-and-stopping-work), it receives a call to [`Worker.onStopped()`](../api/androidx.work/listenable-worker.md). Override this method or call [`Worker.isStopped()`](../api/androidx.work/listenable-worker.md) to checkpoint your code and free up resources when necessary. When the `Worker` above is stopped, it may be in the middle of its download loop and will keep going even though it has been stopped. To stop promptly, check `isStopped`:

```kotlin
class DownloadWorker(context: Context, params: WorkerParameters) : Worker(context, params) {

    override fun doWork(): ListenableWorker.Result {
        for (i in 0 until 100) {
            if (isStopped) {
                break
            }

            try {
                downloadSynchronously("https://www.google.com")
            } catch (e: IOException) {
                return ListenableWorker.Result.failure()
            }
        }

        return ListenableWorker.Result.success()
    }
}
```

Once a `Worker` has been stopped, it doesn't matter what you return from `Worker.doWork()` — the `Result` is ignored.
