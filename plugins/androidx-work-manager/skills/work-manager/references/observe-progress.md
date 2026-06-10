# Observing Worker Progress

WorkManager has built-in support for setting and observing intermediate progress for workers. If the worker runs while the app is in the foreground, this information can be shown to the user using APIs that return the `LiveData` of [`WorkInfo`](../api/androidx.work/work-info.md).

[`ListenableWorker`](../api/androidx.work/listenable-worker.md) supports the `setProgressAsync()` API, which persists intermediate progress that the UI can observe. Progress is represented by the [`Data`](../api/androidx.work/data.md) type, a serializable container of properties (similar to [input and output](../api/androidx.work/data.md), and subject to the same restrictions).

> [!NOTE]
> Progress can only be observed and updated while the `ListenableWorker` is running. Attempts to set progress after it has completed execution are ignored.

Observe progress using the `getWorkInfoBy...()` or `getWorkInfoBy...LiveData()` methods. These return [`WorkInfo`](../api/androidx.work/work-info.md) instances, whose `getProgress()` method returns `Data`.

## Update Progress

In Kotlin, use the [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) `setProgress()` extension function to update progress. (A `Worker` or `ListenableWorker` instead calls [`setProgressAsync()`](../api/androidx.work/listenable-worker.md), which returns a `ListenableFuture<Void>` because the update is stored in a database asynchronously.)

This `ProgressWorker` sets its progress to 0 when it starts, and updates it to 100 on completion:

```kotlin
import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.Data
import androidx.work.WorkerParameters
import kotlinx.coroutines.delay

class ProgressWorker(context: Context, parameters: WorkerParameters) :
    CoroutineWorker(context, parameters) {

    companion object {
        const val Progress = "Progress"
        private const val delayDuration = 1L
    }

    override suspend fun doWork(): Result {
        val firstUpdate = workDataOf(Progress to 0)
        val lastUpdate = workDataOf(Progress to 100)
        setProgress(firstUpdate)
        delay(delayDuration)
        setProgress(lastUpdate)
        return Result.success()
    }
}
```

## Observe Progress

To observe progress, use the [`getWorkInfoById`](../api/androidx.work/work-manager.md) methods to get a reference to [`WorkInfo`](../api/androidx.work/work-info.md). This example uses `getWorkInfoByIdFlow`:

```kotlin
WorkManager.getInstance(applicationContext)
    // requestId is the WorkRequest id
    .getWorkInfoByIdFlow(requestId)
    .collect { workInfo: WorkInfo? ->
        if (workInfo != null) {
            val progress = workInfo.progress
            val value = progress.getInt("Progress", 0)
            // Do something with progress information
        }
    }
```

## Observe Stop Reason State

To debug why a `Worker` was stopped, log the stop reason by calling [`WorkInfo.getStopReason()`](../api/androidx.work/work-info.md):

```kotlin
workManager.getWorkInfoByIdFlow(syncWorker.id)
    .collect { workInfo ->
        if (workInfo != null) {
            val stopReason = workInfo.stopReason
            logStopReason(syncWorker.id, stopReason)
        }
    }
```

> [!NOTE]
> For more on the lifecycle and states of `Worker` objects, see [Work states](work-states.md).
