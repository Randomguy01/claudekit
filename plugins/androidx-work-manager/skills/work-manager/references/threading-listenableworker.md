# Threading in ListenableWorker

When you need a custom threading strategy — for example, to handle a callback-based asynchronous operation — use [`ListenableWorker`](../api/androidx.work/listenable-worker.md). It is the most basic worker API; [`Worker`](../api/androidx.work/worker.md), [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md), and [`RxWorker`](../api/androidx.work/rx-worker.md) all derive from it. A `ListenableWorker` only signals when work should start and stop, leaving the threading entirely up to you. The start signal is invoked on the main thread, so it's important that you move to a background thread of your choice manually.

The abstract method [`ListenableWorker.startWork()`](../api/androidx.work/listenable-worker.md) returns a `ListenableFuture` of the [`Result`](../api/androidx.work/listenable-worker-result.md). A `ListenableFuture` is a `Future` that supports attaching listeners and propagating exceptions. In `startWork()`, return a `ListenableFuture` that you set with the `Result` of the operation once it completes. Create `ListenableFuture` instances in one of two ways:

- If you use Guava, use `ListeningExecutorService`.
- Otherwise, include [`concurrent-futures`](https://developer.android.com/jetpack/androidx/releases/concurrent#declaring_dependencies) in your Gradle file and use [`CallbackToFutureAdapter`](https://developer.android.com/reference/androidx/concurrent/futures/CallbackToFutureAdapter).

To execute work based on an asynchronous callback:

```kotlin
class CallbackWorker(
    context: Context,
    params: WorkerParameters
) : ListenableWorker(context, params) {
    override fun startWork(): ListenableFuture<Result> {
        return CallbackToFutureAdapter.getFuture { completer ->
            val callback = object : Callback {
                var successes = 0

                override fun onFailure(call: Call, e: IOException) {
                    completer.setException(e)
                }

                override fun onResponse(call: Call, response: Response) {
                    successes++
                    if (successes == 100) {
                        completer.set(Result.success())
                    }
                }
            }

            repeat(100) {
                downloadAsynchronously("https://example.com", callback)
            }

            callback
        }
    }
}
```

A `ListenableWorker`'s `ListenableFuture` is always cancelled when the work is expected to [stop](managing-work.md#cancelling-and-stopping-work). With `CallbackToFutureAdapter`, add a cancellation listener inside `getFuture` to react — for example, before kicking off the downloads:

```kotlin
completer.addCancellationListener(cancelDownloadsRunnable, executor)
```

## Running a ListenableWorker in a Different Process

Bind a worker to a specific process using [`RemoteListenableWorker`](https://developer.android.com/reference/kotlin/androidx/work/multiprocess/RemoteListenableWorker), an implementation of `ListenableWorker`.

> [!NOTE]
> `RemoteListenableWorker` and `RemoteWorkerService` live in the `androidx.work:work-multiprocess` artifact (see [Installing WorkManager](install.md)).

`RemoteListenableWorker` binds to a specific process with two extra arguments that you provide as part of the input data when building the work request: `ARGUMENT_CLASS_NAME` and `ARGUMENT_PACKAGE_NAME`. This work request is bound to a specific process:

```kotlin
val PACKAGE_NAME = "com.example.background.multiprocess"

val serviceName = RemoteWorkerService::class.java.name
val componentName = ComponentName(PACKAGE_NAME, serviceName)

val data: Data = Data.Builder()
    .putString(ARGUMENT_PACKAGE_NAME, componentName.packageName)
    .putString(ARGUMENT_CLASS_NAME, componentName.className)
    .build()

return OneTimeWorkRequest.Builder(ExampleRemoteListenableWorker::class.java)
    .setInputData(data)
    .build()
```

For each `RemoteWorkerService`, add a service definition in your `AndroidManifest.xml`:

```xml
<manifest ... >
    <service
        android:name="androidx.work.multiprocess.RemoteWorkerService"
        android:exported="false"
        android:process=":worker1" />

    <service
        android:name=".RemoteWorkerService2"
        android:exported="false"
        android:process=":worker2" />
    ...
</manifest>
```
