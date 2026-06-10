# Long-Running Workers

WorkManager has built-in support for long-running workers. WorkManager can signal the OS to keep the process alive if possible while the work executes, so these Workers can run longer than 10 minutes. Example use cases include bulk uploads or downloads that can't be chunked, crunching an ML model locally, or any task that's *important to the user*.

Under the hood, WorkManager manages and runs a foreground service on your behalf to execute the [`WorkRequest`](../api/androidx.work/work-request.md), while also showing a configurable notification.

[`ListenableWorker`](../api/androidx.work/listenable-worker.md) supports the `setForegroundAsync()` API, and [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) supports a suspending `setForeground()` API. These let you specify that a `WorkRequest` is *important* (from the user's perspective) or *long-running*.

> [!NOTE]
> WorkManager relies on `JobScheduler` to schedule its work, even when it creates a foreground service to run tasks. Starting with Android 16, long-running workers (which use foreground services) can exhaust your app's job quota. If this happens, try launching the foreground service directly instead of using WorkManager. To download data in response to a user action, consider a [user-initiated data transfer job](https://developer.android.com/develop/background-work/background-tasks/uidt), which is exempt from the ordinary job quotas.

**Requires WorkManager 2.3.0-alpha03+**

WorkManager can also create a `PendingIntent` to cancel workers without registering a new Android component, using the [`createCancelPendingIntent()`](../api/androidx.work/work-manager.md) API. This is especially useful with `setForegroundAsync()` or `setForeground()` to add a notification action that cancels the `Worker`.

## Creating and Managing Long-Running Workers

In Kotlin, use a [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) and the suspending `setForeground()` method:

```kotlin
class DownloadWorker(context: Context, parameters: WorkerParameters) :
    CoroutineWorker(context, parameters) {

    private val notificationManager =
        context.getSystemService(Context.NOTIFICATION_SERVICE) as
                NotificationManager

    override suspend fun doWork(): Result {
        val inputUrl = inputData.getString(KEY_INPUT_URL)
            ?: return Result.failure()
        val outputFile = inputData.getString(KEY_OUTPUT_FILE_NAME)
            ?: return Result.failure()
        // Mark the Worker as important
        val progress = "Starting Download"
        setForeground(createForegroundInfo(progress))
        download(inputUrl, outputFile)
        return Result.success()
    }

    private fun download(inputUrl: String, outputFile: String) {
        // Downloads a file and updates bytes read
        // Calls setForeground() periodically when it needs to update
        // the ongoing Notification
    }

    // Creates an instance of ForegroundInfo which can be used to update the
    // ongoing notification.
    private fun createForegroundInfo(progress: String): ForegroundInfo {
        val id = applicationContext.getString(R.string.notification_channel_id)
        val title = applicationContext.getString(R.string.notification_title)
        val cancel = applicationContext.getString(R.string.cancel_download)
        // This PendingIntent can be used to cancel the worker
        val intent = WorkManager.getInstance(applicationContext)
            .createCancelPendingIntent(getId())

        // Create a Notification channel if necessary
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createChannel()
        }

        val notification = NotificationCompat.Builder(applicationContext, id)
            .setContentTitle(title)
            .setTicker(title)
            .setContentText(progress)
            .setSmallIcon(R.drawable.ic_work_notification)
            .setOngoing(true)
            // Add the cancel action to the notification which can
            // be used to cancel the worker
            .addAction(android.R.drawable.ic_delete, cancel, intent)
            .build()

        return ForegroundInfo(notificationId, notification)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createChannel() {
        // Create a Notification channel
    }

    companion object {
        const val KEY_INPUT_URL = "KEY_INPUT_URL"
        const val KEY_OUTPUT_FILE_NAME = "KEY_OUTPUT_FILE_NAME"
    }
}
```

A `Worker` or `ListenableWorker` instead calls [`setForegroundAsync()`](../api/androidx.work/listenable-worker.md), which returns a `ListenableFuture<Void>`. Call it periodically to update the ongoing `Notification`.

## Add a Foreground Service Type to a Long-Running Worker

> [!NOTE]
> Depending on your app's target API level and the kind of work the service does, you may be *required* to declare a foreground service type. Declaring one is a best practice no matter which version of Android you target. See [Declare foreground services and request permissions](https://developer.android.com/develop/background-work/services/fgs/declare).

If your app targets Android 14 (API level 34) or higher, you must specify a [foreground service type](https://developer.android.com/develop/background-work/services/fgs/service-types) for all long-running workers. If your app targets Android 10 (API level 29) or higher and the worker requires access to location, indicate that the worker uses a foreground service type of [`location`](https://developer.android.com/develop/background-work/services/fgs/service-types#location). If your app targets Android 11 (API level 30) or higher and the worker requires access to camera or microphone, declare the [`camera`](https://developer.android.com/develop/background-work/services/fgs/service-types#camera) or [`microphone`](https://developer.android.com/develop/background-work/services/fgs/service-types#microphone) foreground service types respectively.

### Declare Foreground Service Types in the App Manifest

Declare the worker's foreground service type in your app's manifest. In this example, the worker requires access to location and microphone:

```xml
<service
    android:name="androidx.work.impl.foreground.SystemForegroundService"
    android:foregroundServiceType="location|microphone"
    tools:node="merge" />
```

> [!NOTE]
> The [manifest merger tool](https://developer.android.com/studio/build/manage-manifests#merge-manifests) combines this `<service>` declaration with the one WorkManager's `SystemForegroundService` defines in its own manifest.

### Specify Foreground Service Types at Runtime

When you call `setForeground()` or `setForegroundAsync()`, specify a [foreground service type](https://developer.android.com/develop/background-work/services/fgs/service-types):

```kotlin
private fun createForegroundInfo(progress: String): ForegroundInfo {
    // ...
    return ForegroundInfo(
        NOTIFICATION_ID, notification,
        FOREGROUND_SERVICE_TYPE_LOCATION or FOREGROUND_SERVICE_TYPE_MICROPHONE
    )
}
```

> [!NOTE]
> Beginning with Android 14 (API level 34), when you call `setForeground()` or `setForegroundAsync()`, the system checks for prerequisites based on the service type. See [Declare foreground services and request permissions](https://developer.android.com/develop/background-work/services/fgs/declare).
