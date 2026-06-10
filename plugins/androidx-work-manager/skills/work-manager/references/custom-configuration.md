# Customizing WorkManager Configuration and Initialization

By default, WorkManager configures itself automatically when your app starts, using options suitable for most apps. To control how WorkManager manages and schedules work, initialize it yourself.

## On-Demand Initialization

On-demand initialization creates WorkManager only when the component is needed, rather than on every app start. This moves WorkManager off your critical startup path, improving startup performance.

### Remove the Default Initializer

To provide your own configuration, first remove the default initializer by updating `AndroidManifest.xml` with the merge rule `tools:node="remove"`.

**Requires WorkManager 2.6+** — WorkManager uses [App Startup](https://developer.android.com/topic/libraries/app-startup) internally, so remove the `androidx.startup` node.

If you don't use App Startup at all, remove it completely:

```xml
<!-- If you want to disable android.startup completely. -->
<provider
    android:name="androidx.startup.InitializationProvider"
    android:authorities="${applicationId}.androidx-startup"
    tools:node="remove">
</provider>
```

Otherwise, remove only the `WorkManagerInitializer` node:

```xml
<provider
    android:name="androidx.startup.InitializationProvider"
    android:authorities="${applicationId}.androidx-startup"
    android:exported="false"
    tools:node="merge">
    <!-- If you are using androidx.startup to initialize other components -->
    <meta-data
        android:name="androidx.work.WorkManagerInitializer"
        android:value="androidx.startup"
        tools:node="remove" />
</provider>
```

On WorkManager older than 2.6, remove the `workmanager-init` node instead:

```xml
<provider
    android:name="androidx.work.impl.WorkManagerInitializer"
    android:authorities="${applicationId}.workmanager-init"
    tools:node="remove" />
```

For more on manifest merge rules, see [merging multiple manifest files](https://developer.android.com/studio/build/manage-manifests#merge-manifests).

### Implement Configuration.Provider

Have your `Application` class implement [`Configuration.Provider`](../api/androidx.work/configuration-provider.md) and supply your own [`getWorkManagerConfiguration()`](../api/androidx.work/configuration-provider.md). When you need WorkManager, call [`WorkManager.getInstance(Context)`](../api/androidx.work/work-manager.md); WorkManager calls your `getWorkManagerConfiguration()` to discover its `Configuration`. You don't need to call `WorkManager.initialize` yourself.

> [!NOTE]
> The deprecated no-parameter `WorkManager.getInstance()` method throws an exception if called before WorkManager is initialized. Always use `WorkManager.getInstance(Context)`, even when you aren't customizing WorkManager.

```kotlin
class MyApplication() : Application(), Configuration.Provider {
    override fun getWorkManagerConfiguration() =
        Configuration.Builder()
            .setMinimumLoggingLevel(android.util.Log.INFO)
            .build()
}
```

> [!NOTE]
> A custom `getWorkManagerConfiguration()` implementation takes effect only after you [remove the default initializer](#remove-the-default-initializer).

## Custom Initialization Before WorkManager 2.1.0

Before version 2.1.0, there are two initialization options. Default initialization suits most apps; for precise control, specify your own configuration.

### Default Initialization

WorkManager uses a custom `ContentProvider` — the internal `androidx.work.impl.WorkManagerInitializer` class — to initialize itself at app start with the default [`Configuration`](../api/androidx.work/configuration.md). This initializer is used automatically unless you disable it, and is suitable for most apps.

### Custom Initialization

Disable the default initializer, then initialize WorkManager manually:

```kotlin
// provide custom configuration
val myConfig = Configuration.Builder()
    .setMinimumLoggingLevel(android.util.Log.INFO)
    .build()

// initialize WorkManager
WorkManager.initialize(this, myConfig)
```

Run the [`WorkManager`](../api/androidx.work/work-manager.md) singleton's initialization in either `Application.onCreate()` or `ContentProvider.onCreate()`.

For the complete list of customizations, see the [`Configuration.Builder()`](../api/androidx.work/configuration-builder.md) reference.
