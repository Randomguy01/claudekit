# API Reference

> Last updated 2026-06-10

# ForegroundInfo

> Added in 2.3.0

```
class ForegroundInfo
```

The information required when a [`ListenableWorker`](listenable-worker.md) runs in the context of a foreground service.

## Public Constructors

### ForegroundInfo

> Added in 2.3.0
```
ForegroundInfo(notificationId: Int, notification: Notification)
```

Creates an instance with a `Notification`. On API 29 and above, specify a `foregroundServiceType` using the three-arg constructor; otherwise a default type of `0` is used.

- `notificationId` — the notification id.
- `notification` — the `Notification` to show while the worker runs in the foreground service.

### ForegroundInfo

> Added in 2.3.0
```
ForegroundInfo(
    notificationId: Int,
    notification: Notification,
    foregroundServiceType: Int
)
```

Creates an instance with a `Notification` and a foreground service type. See `Service.startForeground(int, Notification, int)`.

- `notificationId` — the notification id.
- `notification` — the `Notification`.
- `foregroundServiceType` — the foreground `ServiceInfo` type.

## Public Functions

### getForegroundServiceType

> Added in 2.3.0
```
fun getForegroundServiceType(): Int
```

The foreground `ServiceInfo` type.

### getNotification

> Added in 2.3.0
```
fun getNotification(): Notification
```

The user-visible `Notification`.

### getNotificationId

> Added in 2.3.0
```
fun getNotificationId(): Int
```

The notification id to be used.
