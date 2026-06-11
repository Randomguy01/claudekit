# Injecting WorkManager with Hilt

Add `androidx.hilt:hilt-work` plus the additional annotation processor `ksp("androidx.hilt:hilt-compiler")` — it runs on top of the Hilt annotation processor. See `install.md`.

Inject a [`Worker`](https://developer.android.com/reference/kotlin/androidx/work/Worker) by annotating the class with `@HiltWorker` and its constructor with `@AssistedInject`. Annotate the `Context` and `WorkerParameters` dependencies with `@Assisted`; the remaining parameters are Hilt dependencies.

> [!IMPORTANT]
> A `Worker` may only use `@Singleton` or unscoped bindings.

```kotlin
@HiltWorker
class ExampleWorker @AssistedInject constructor(
  @Assisted appContext: Context,
  @Assisted workerParams: WorkerParameters,
  workerDependency: WorkerDependency
) : Worker(appContext, workerParams) { ... }
```

Then have the [`Application`](https://developer.android.com/reference/kotlin/android/app/Application) class implement `Configuration.Provider`, inject a `HiltWorkerFactory`, and pass it into the `WorkManager` configuration:

```kotlin
@HiltAndroidApp
class ExampleApplication : Application(), Configuration.Provider {

  @Inject lateinit var workerFactory: HiltWorkerFactory

  override fun getWorkManagerConfiguration() =
    Configuration.Builder()
      .setWorkerFactory(workerFactory)
      .build()
}
```

> [!WARNING]
> Supplying a custom `WorkManager` configuration requires removing the default initializer from `AndroidManifest.xml`. See [custom WorkManager configuration](https://developer.android.com/topic/libraries/architecture/workmanager/advanced/custom-configuration).
