# API Reference

> Last updated 2026-06-10

# androidx.work — Top-Level & Extension Functions

The package-level helper functions in `androidx.work`. These are the idiomatic Kotlin entry points; they wrap the Java-style builders and APIs documented in the per-type files.

## Top-Level Functions

### OneTimeWorkRequestBuilder

```
inline fun <W : ListenableWorker> OneTimeWorkRequestBuilder(): OneTimeWorkRequest.Builder
```

Creates a [`OneTimeWorkRequest.Builder`](one-time-work-request-builder.md) for the reified [`ListenableWorker`](listenable-worker.md) type `W`. The idiomatic Kotlin form of `OneTimeWorkRequest.Builder(W::class.java)`.

### PeriodicWorkRequestBuilder

```
@RequiresApi(value = 26)
inline fun <W : ListenableWorker> PeriodicWorkRequestBuilder(
    repeatInterval: Duration
): PeriodicWorkRequest.Builder

@RequiresApi(value = 26)
inline fun <W : ListenableWorker> PeriodicWorkRequestBuilder(
    repeatInterval: Duration,
    flexTimeInterval: Duration
): PeriodicWorkRequest.Builder

inline fun <W : ListenableWorker> PeriodicWorkRequestBuilder(
    repeatInterval: Long,
    repeatIntervalTimeUnit: TimeUnit
): PeriodicWorkRequest.Builder

inline fun <W : ListenableWorker> PeriodicWorkRequestBuilder(
    repeatInterval: Long,
    repeatIntervalTimeUnit: TimeUnit,
    flexTimeInterval: Long,
    flexTimeIntervalUnit: TimeUnit
): PeriodicWorkRequest.Builder
```

Creates a [`PeriodicWorkRequest.Builder`](periodic-work-request-builder.md) for the reified [`ListenableWorker`](listenable-worker.md) type `W`, with the given repeat interval (and optional flex interval). The `Duration` overloads require API 26.

### workDataOf

```
inline fun workDataOf(vararg pairs: Pair<String, Any?>): Data
```

Converts a list of pairs to a [`Data`](data.md) object. If multiple pairs share a key, the last value wins; entries iterate in the order specified. The idiomatic alternative to [`Data.Builder`](data-builder.md).

## Extension Functions

### Operation.await

```
suspend inline fun Operation.await(): Operation.State.SUCCESS
```

Awaits an [`Operation`](operation.md) without blocking a thread. Returns the terminal [`SUCCESS`](operation-state-success.md) state, or throws the `Throwable` that caused the operation to fail.

### Data.hasKeyWithValueOfType

```
inline fun <T : Any> Data.hasKeyWithValueOfType(key: String): Boolean
```

Returns `true` if the [`Data`](data.md) instance has a value for the given key with the reified expected type `T`. The Kotlin convenience form of [`Data.hasKeyWithValueOfType(key, klass)`](data.md#haskeywithvalueoftype).

### WorkerParameters.isRemoteWorkRequest

> Added in 2.10.0
```
fun WorkerParameters.isRemoteWorkRequest(): Boolean
```

Returns `true` if and only if the [`WorkerParameters`](worker-parameters.md) instance corresponds to a [`WorkRequest`](work-request.md) that runs in a remote process.

### WorkerParameters.usingRemoteService

```
inline fun <T : ListenableWorker> WorkerParameters.usingRemoteService(
    componentName: ComponentName
): WorkerParameters
```

> Added in 2.10.0
```
fun WorkerParameters.usingRemoteService(
    workerClassName: String,
    componentName: ComponentName
): WorkerParameters
```

Returns a new [`WorkerParameters`](worker-parameters.md) representing a [`WorkRequest`](work-request.md) that can run in the process identified by `componentName` (the `RemoteService` host). The reified overload delegates to the [`ListenableWorker`](listenable-worker.md) type `T`; the other takes its fully qualified class name.

### OneTimeWorkRequest.Builder.setInputMerger

> Added in 1.0.0
```
inline fun OneTimeWorkRequest.Builder.setInputMerger(
    inputMerger: KClass<InputMerger>
): OneTimeWorkRequest.Builder
```

`KClass`-based form of [`OneTimeWorkRequest.Builder.setInputMerger`](one-time-work-request-builder.md#setinputmerger).
