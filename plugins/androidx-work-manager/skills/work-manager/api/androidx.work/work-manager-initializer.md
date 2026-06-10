# API Reference

> Last updated 2026-06-10

# WorkManagerInitializer

> Added in 2.6.0

```
class WorkManagerInitializer : Initializer
```

Initializes [`WorkManager`](work-manager.md) using `androidx.startup`. This is the default automatic initialization mechanism.

> [!NOTE]
> To use on-demand initialization with a custom [`Configuration`](configuration.md), disable this initializer in your manifest and implement [`Configuration.Provider`](configuration-provider.md) on your `Application` class.

## Public Constructors

### WorkManagerInitializer

> Added in 2.6.0
```
WorkManagerInitializer()
```

## Public Functions

### create

> Added in 2.6.0
```
fun create(context: Context): WorkManager
```

Initializes WorkManager within the application context.

### dependencies

> Added in 2.6.0
```
fun dependencies(): (Mutable)List<Class<Initializer<Any!>!>!>
```

Gets this initializer's dependencies, which are initialized before it.
