# API Reference

> Last updated 2026-06-08

# MultiInstanceInvalidationService

> Added in 2.4.0

**Android**
```
@ExperimentalRoomApi
class MultiInstanceInvalidationService : Service
```

A `Service` for remote invalidation among multiple [`InvalidationTracker`](invalidation-tracker.md) instances. This service runs in the main app process. All instances of `InvalidationTracker` (potentially in other processes) have to connect to this service.

The intent to launch it can be specified by [`RoomDatabase.Builder.setMultiInstanceInvalidationServiceIntent()`](room-database-builder.md#setmultiinstanceinvalidationserviceintent), although the service is defined in the manifest by default, so there should be no need to override it in a normal situation.

See [`@ExperimentalRoomApi`](experimental-room-api.md).

## Public Constructors

### MultiInstanceInvalidationService

> Added in 2.4.0
```
MultiInstanceInvalidationService()
```

## Public Functions

### onBind

> Added in 2.4.0
```
open fun onBind(intent: Intent): IBinder
```

The standard `Service.onBind` override returning the binder for this invalidation service.

## Inherited Members

In addition to the members above, this class inherits the standard `android.app.Service`, `android.content.ContextWrapper`, and `android.content.Context` API (e.g. `onCreate`, `onDestroy`, `onStartCommand`, `stopSelf`, and the full `Context` surface).
