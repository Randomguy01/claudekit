# Threading in RxWorker

WorkManager provides interoperability with RxJava. Include the [`work-rxjava3`](install.md) dependency in addition to `work-runtime` in your Gradle file. (A `work-rxjava2` dependency supports RxJava 2 instead.)

Instead of extending `Worker`, extend [`RxWorker`](../api/androidx.work/rx-worker.md) and override [`RxWorker.createWork()`](../api/androidx.work/rx-worker.md) to return a `Single<Result>` indicating the [`Result`](../api/androidx.work/listenable-worker-result.md) of your execution:

```kotlin
class RxDownloadWorker(
    context: Context,
    params: WorkerParameters
) : RxWorker(context, params) {
    override fun createWork(): Single<Result> {
        return Observable.range(0, 100)
            .flatMap { download("https://www.example.com") }
            .toList()
            .map { Result.success() }
    }
}
```

`RxWorker.createWork()` is *called* on the main thread, but the return value is *subscribed* on a background thread by default. Override [`RxWorker.getBackgroundScheduler()`](../api/androidx.work/rx-worker.md) to change the subscribing thread.

When an `RxWorker` is `onStopped()`, the subscription is disposed of, so you don't need to handle [work stoppages](managing-work.md#cancelling-and-stopping-work) in any special way.
