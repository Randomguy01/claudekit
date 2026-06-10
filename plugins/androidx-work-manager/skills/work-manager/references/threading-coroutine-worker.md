# Threading in CoroutineWorker

For Kotlin users, WorkManager provides first-class support for coroutines. Include [`work-runtime-ktx`](install.md) in your Gradle file, then extend [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) instead of [`Worker`](../api/androidx.work/worker.md). `CoroutineWorker` has a suspending version of `doWork()`. This simple `CoroutineWorker` performs a network operation:

```kotlin
class CoroutineDownloadWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        val data = downloadSynchronously("https://www.google.com")
        saveData(data)
        return Result.success()
    }
}
```

[`CoroutineWorker.doWork()`](../api/androidx.work/coroutine-worker.md) is a *suspending* function. Unlike `Worker`, it does *not* run on the `Executor` specified in your [`Configuration`](../api/androidx.work/configuration.md); instead it defaults to `Dispatchers.Default`. Customize this by providing your own `CoroutineContext`. In the example above, you'd probably want to do this work on `Dispatchers.IO`:

```kotlin
class CoroutineDownloadWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        return withContext(Dispatchers.IO) {
            val data = downloadSynchronously("https://www.google.com")
            saveData(data)
            Result.success()
        }
    }
}
```

`CoroutineWorker` handles stoppages automatically by cancelling the coroutine and propagating the cancellation signals. You don't need to do anything special to handle [work stoppages](managing-work.md#cancelling-and-stopping-work).

## Running a CoroutineWorker in a Different Process

Bind a worker to a specific process using [`RemoteCoroutineWorker`](https://developer.android.com/reference/kotlin/androidx/work/multiprocess/RemoteCoroutineWorker), an implementation of [`ListenableWorker`](../api/androidx.work/listenable-worker.md).

> [!NOTE]
> `RemoteCoroutineWorker` and `RemoteWorkerService` live in the `androidx.work:work-multiprocess` artifact (see [Installing WorkManager](install.md)).

`RemoteCoroutineWorker` binds to a specific process with two extra arguments that you provide as part of the input data when building the work request: `ARGUMENT_CLASS_NAME` and `ARGUMENT_PACKAGE_NAME`. This work request is bound to a specific process:

```kotlin
val PACKAGE_NAME = "com.example.background.multiprocess"

val serviceName = RemoteWorkerService::class.java.name
val componentName = ComponentName(PACKAGE_NAME, serviceName)

val data: Data = Data.Builder()
    .putString(ARGUMENT_PACKAGE_NAME, componentName.packageName)
    .putString(ARGUMENT_CLASS_NAME, componentName.className)
    .build()

return OneTimeWorkRequest.Builder(ExampleRemoteCoroutineWorker::class.java)
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
