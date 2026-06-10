# API Reference

> Last updated 2026-06-10

# Configuration.Provider

> Added in 2.1.0

```
interface Configuration.Provider
```

A class that can provide the [`Configuration`](configuration.md) for WorkManager and allow for on-demand initialization. To use it:

- Disable `androidx.work.WorkManagerInitializer` in your manifest (see [`WorkManagerInitializer`](work-manager-initializer.md)).
- Implement `Configuration.Provider` on your `Application` class.
- Access WorkManager via [`WorkManager.getInstance(context)`](work-manager.md#getinstance).

> [!NOTE]
> On-demand initialization may delay some useful WorkManager features, such as automatic rescheduling of work after a crash and recovery from the app being force-stopped.

## Public Properties

### workManagerConfiguration

> Added in 2.1.0
```
val workManagerConfiguration: Configuration
```

The [`Configuration`](configuration.md) used to initialize WorkManager.
