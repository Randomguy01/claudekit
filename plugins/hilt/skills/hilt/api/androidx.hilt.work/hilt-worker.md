# API Reference

> Last updated 2026-06-11

# HiltWorker

> Added in 1.0.0

```kotlin
@Target(AnnotationTarget.CLASS)
@Retention(AnnotationRetention.BINARY)
@GeneratesRootInput
annotation class HiltWorker
```

A type annotation that identifies a `ListenableWorker`'s constructor for injection. Artifact: `androidx.hilt:hilt-common`.

The `Worker` becomes available for creation by the [`HiltWorkerFactory`](hilt-worker-factory.md), which should be set in `WorkManager`'s configuration via `Configuration.Builder.setWorkerFactory`. A `@HiltWorker` whose constructor is annotated with [`@AssistedInject`](../dagger.assisted/assisted-inject.md) has the dependencies declared in its constructor parameters injected by Hilt.

```kotlin
@HiltWorker
class UploadWorker @AssistedInject constructor(
    @Assisted context: Context,
    @Assisted params: WorkerParameters,
    private val httpClient: HttpClient
) : Worker(context, params) {
    // ...
}
```

```kotlin
@HiltAndroidApp
class MyApplication : Application(), Configuration.Provider {
    @Inject lateinit var workerFactory: HiltWorkerFactory

    override fun getWorkManagerConfiguration() =
        Configuration.Builder()
            .setWorkerFactory(workerFactory)
            .build()
}
```

Exactly one constructor in the `Worker` must be annotated with [`@AssistedInject`](../dagger.assisted/assisted-inject.md). It must declare an [`@Assisted`](../dagger.assisted/assisted.md)-annotated `Context` and an `@Assisted`-annotated `WorkerParameters`, along with any other dependencies. The `Context` and `WorkerParameters` must not be wrapped in a `Provider` or [`Lazy`](../dagger/lazy.md), and must not be qualified.

Only dependencies available in the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md) can be injected into the `Worker`.
