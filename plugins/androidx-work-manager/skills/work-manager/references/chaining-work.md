# Chaining Work

Create and enqueue a chain of work that specifies multiple dependent tasks and the order they run in. This is useful when several tasks must run in a particular order.

To create a chain, use [`WorkManager.beginWith(OneTimeWorkRequest)`](../api/androidx.work/work-manager.md) or [`WorkManager.beginWith(List<OneTimeWorkRequest>)`](../api/androidx.work/work-manager.md), which each return an instance of [`WorkContinuation`](../api/androidx.work/work-continuation.md). Use the `WorkContinuation` to add dependent [`OneTimeWorkRequest`](../api/androidx.work/one-time-work-request.md) instances with [`then(OneTimeWorkRequest)`](../api/androidx.work/work-continuation.md) or `then(List<OneTimeWorkRequest>)`.

Every invocation of `WorkContinuation.then(...)` returns a *new* `WorkContinuation` instance. If you add a `List` of `OneTimeWorkRequest` instances, those requests can potentially run in parallel. Call [`WorkContinuation.enqueue()`](../api/androidx.work/work-continuation.md) to enqueue the chain.

In this example, three Worker jobs run (potentially in parallel). Their results are joined and passed to a caching Worker, whose output is then passed to an upload Worker that uploads the results to a remote server.

```kotlin
WorkManager.getInstance(myContext)
    // Candidates to run in parallel
    .beginWith(listOf(plantName1, plantName2, plantName3))
    // Dependent work (only runs after all previous work in chain)
    .then(cache)
    .then(upload)
    // Call enqueue to kick things off
    .enqueue()
```

## Input Mergers

When you chain `OneTimeWorkRequest` instances, the output of parent work requests is passed as input to the children. In the example above, the outputs of `plantName1`, `plantName2`, and `plantName3` are passed as inputs to the `cache` request.

To manage inputs from multiple parent work requests, WorkManager uses an [`InputMerger`](../api/androidx.work/input-merger.md). Two types are provided:

- [`OverwritingInputMerger`](../api/androidx.work/overwriting-input-merger.md) adds all keys from all inputs to the output. On conflicts, it overwrites previously-set keys.
- [`ArrayCreatingInputMerger`](../api/androidx.work/array-creating-input-merger.md) merges the inputs, creating arrays when necessary.

For a more specific use case, write your own by subclassing `InputMerger`.

### OverwritingInputMerger

`OverwritingInputMerger` is the default merge method. On key conflicts, the latest value for a key overwrites previous versions in the output data.

For example, if the plant inputs each have a key matching their variable names (`"plantName1"`, `"plantName2"`, and `"plantName3"`), the data passed to the `cache` worker has three key-value pairs. If there's a conflict, the last worker to complete "wins" and its value is passed to `cache`.

Because the work requests run in parallel, the order in which they run isn't guaranteed. In the example above, `plantName1` could hold either `"tulip"` or `"elm"`, depending on which value is written last.

> [!TIP]
> If you might have a key conflict and need to preserve all output data, `ArrayCreatingInputMerger` is the better option.

### ArrayCreatingInputMerger

To preserve the outputs from all plant-name Workers, use an `ArrayCreatingInputMerger`:

```kotlin
val cache: OneTimeWorkRequest = OneTimeWorkRequestBuilder<PlantWorker>()
    .setInputMerger(ArrayCreatingInputMerger::class)
    .setConstraints(constraints)
    .build()
```

`ArrayCreatingInputMerger` pairs each key with an array. If each key is unique, the result is a series of one-element arrays. If there are key collisions, the corresponding values are grouped together in an array.

## Chaining and Work Statuses

Chains of `OneTimeWorkRequest` execute sequentially as long as each completes successfully (returns a [`Result.success()`](../api/androidx.work/listenable-worker-result.md)). Work requests may fail or be cancelled while running, which has downstream effects on dependent work requests.

When the first `OneTimeWorkRequest` is enqueued in a chain, all subsequent work requests are blocked until the first completes. Once enqueued and all work constraints are satisfied, the first work request begins running. If the root `OneTimeWorkRequest` or `List<OneTimeWorkRequest>` completes successfully, the next set of dependent work requests is enqueued. This pattern propagates through the chain until all work is completed.

Error states are just as important to handle. When an error occurs while a worker is processing a request, you can retry that request according to a [backoff policy you define](define-work-requests.md#retry-and-backoff-policy). Retrying a request that's part of a chain retries only that request, with the input data provided to it; any work running in parallel is unaffected.

If the retry policy is undefined or exhausted, or a `OneTimeWorkRequest` otherwise returns `Result.failure()`, that work request and all dependent work requests are marked `FAILED`. The same logic applies when a `OneTimeWorkRequest` is cancelled: any dependent work requests are also marked `CANCELLED` and won't execute.

> [!NOTE]
> If you append more work requests to a chain that has failed or cancelled work requests, the appended requests are also marked `FAILED` or `CANCELLED`, respectively. To extend such a chain regardless, use `APPEND_OR_REPLACE` — see [`ExistingWorkPolicy`](../api/androidx.work/existing-work-policy.md).

> [!TIP]
> Dependent work requests in a chain should define retry policies so work always completes in a timely manner. Failed work requests can result in incomplete chains or unexpected state.

For more on cancelling work, see [Cancelling and Stopping Work](managing-work.md#cancelling-and-stopping-work).
