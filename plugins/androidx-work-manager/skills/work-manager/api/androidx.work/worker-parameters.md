# API Reference

> Last updated 2026-06-10

# WorkerParameters

> Added in 1.0.0

```
class WorkerParameters
```

Setup parameters for a [`ListenableWorker`](listenable-worker.md). Instances are created by WorkManager and passed to the worker's constructor.

## Public Functions

### getGeneration

> Added in 2.8.0
```
fun getGeneration(): @IntRange(from = 0) Int
```

Gets the generation of this worker. A work has multiple generations if it was updated via [`WorkManager.updateWork`](work-manager.md#updatework) or [`WorkManager.enqueueUniquePeriodicWork`](work-manager.md#enqueueuniqueperiodicwork) using [`ExistingPeriodicWorkPolicy.UPDATE`](existing-periodic-work-policy.md#update). This worker can be of an older generation than the latest known if an update happened while it was running.

### getId

> Added in 1.0.0
```
fun getId(): UUID
```

Gets the ID of the [`WorkRequest`](work-request.md) that created this [`ListenableWorker`](listenable-worker.md).

### getInputData

> Added in 1.0.0
```
fun getInputData(): Data
```

Gets the input [`Data`](data.md). When there are multiple prerequisites for this worker, the input data has been run through an [`InputMerger`](input-merger.md).

### getNetwork

> Added in 1.0.0
```
@RequiresApi(value = 28)
fun getNetwork(): Network?
```

Gets the `Network` to use for this worker, or `null` if no network is needed.

### getRunAttemptCount

> Added in 1.0.0
```
fun getRunAttemptCount(): @IntRange(from = 0) Int
```

Gets the current run attempt count for this work. For periodic work, this value resets between periods.

### getTags

> Added in 1.0.0
```
fun getTags(): (Mutable)Set<String!>
```

Gets the set of tags associated with this worker's [`WorkRequest`](work-request.md). See [`WorkRequest.Builder.addTag`](work-request-builder.md#addtag).

### getTriggeredContentAuthorities

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun getTriggeredContentAuthorities(): (Mutable)List<String!>
```

Gets the list of content authorities that caused this worker to execute.

### getTriggeredContentUris

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun getTriggeredContentUris(): (Mutable)List<Uri!>
```

Gets the list of content `Uri`s that caused this worker to execute. See [`Constraints.Builder.addContentUriTrigger`](constraints-builder.md#addcontenturitrigger).

## Extension Functions

`WorkerParameters` has extension functions for multi-process work (`isRemoteWorkRequest`, `usingRemoteService`). See [`package-functions.md`](package-functions.md).
