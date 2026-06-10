# API Reference

> Last updated 2026-06-10

# androidx.work.testing — Top-Level & Extension Functions

The package-level helper functions in `androidx.work.testing`. These are the idiomatic Kotlin entry points; they wrap the Java-style builders documented in the per-type files.

## Top-Level Functions

### TestListenableWorkerBuilder

```
inline fun <W : ListenableWorker> TestListenableWorkerBuilder(
    context: Context,
    inputData: Data = Data.EMPTY,
    tags: List<String> = emptyList(),
    runAttemptCount: Int = 1,
    triggeredContentUris: List<Uri> = emptyList(),
    triggeredContentAuthorities: List<String> = emptyList()
): TestListenableWorkerBuilder<W>
```

Builds a [`TestListenableWorkerBuilder`](test-listenable-worker-builder.md) for the reified [`ListenableWorker`](../androidx.work/listenable-worker.md) subtype `W`. The idiomatic Kotlin form, applying the supplied input [`Data`](../androidx.work/data.md), tags, run attempt count, and triggered content `Uri`s/authorities as defaults.

### TestWorkerBuilder

```
inline fun <W : Worker> TestWorkerBuilder(
    context: Context,
    executor: Executor,
    inputData: Data = Data.EMPTY,
    tags: List<String> = emptyList(),
    runAttemptCount: Int = 1,
    triggeredContentUris: List<Uri> = emptyList(),
    triggeredContentAuthorities: List<String> = emptyList()
): TestWorkerBuilder<W>
```

Builds a [`TestWorkerBuilder`](test-worker-builder.md) for the reified [`Worker`](../androidx.work/worker.md) subtype `W`, running on the given `Executor`. Applies the supplied input [`Data`](../androidx.work/data.md), tags, run attempt count, and triggered content `Uri`s/authorities as defaults.
