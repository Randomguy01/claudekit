# API Reference

> Last updated 2026-06-10

# Constraints

> Added in 1.0.0

```
class Constraints
```

A specification of the requirements that need to be met before a [`WorkRequest`](work-request.md) can run. By default, WorkRequests do not have any requirements and can run immediately. By adding requirements, you can make sure that work only runs in certain situations — for example, when you have an unmetered network and are charging.

## Nested Types

| Type | Description |
|------|-------------|
| [`Constraints.Builder`](constraints-builder.md) | A Builder for a `Constraints` object. |
| [`Constraints.ContentUriTrigger`](constraints-content-uri-trigger.md) | Describes a content uri trigger on the `WorkRequest`: it should run when a local `content:` `Uri` is updated. |

## Public Companion Properties

### NONE

```
val NONE: Constraints
```

Represents a `Constraints` object with no requirements.

## Public Constructors

### Constraints

> Added in 1.0.0
```
Constraints(other: Constraints)
```

### Constraints

> Added in 2.9.0
```
@Ignore
Constraints(
    requiredNetworkType: NetworkType = NetworkType.NOT_REQUIRED,
    requiresCharging: Boolean = false,
    requiresBatteryNotLow: Boolean = false,
    requiresStorageNotLow: Boolean = false
)
```

- `requiredNetworkType` — the type of network required for the work to run. Defaults to [`NetworkType.NOT_REQUIRED`](network-type.md#not_required).
- `requiresCharging` — whether the device should be charging for the [`WorkRequest`](work-request.md) to run. Defaults to `false`.
- `requiresBatteryNotLow` — whether the device battery should be at an acceptable level. Defaults to `false`.
- `requiresStorageNotLow` — whether the device's available storage should be at an acceptable level. Defaults to `false`.

### Constraints

> Added in 2.9.0
```
@Ignore
Constraints(
    requiredNetworkType: NetworkType = NetworkType.NOT_REQUIRED,
    requiresCharging: Boolean = false,
    requiresDeviceIdle: Boolean = false,
    requiresBatteryNotLow: Boolean = false,
    requiresStorageNotLow: Boolean = false
)
```

As above, plus `requiresDeviceIdle` — whether the device should be idle for the [`WorkRequest`](work-request.md) to run. Defaults to `false`.

### Constraints

> Added in 2.8.0
```
@Ignore
@RequiresApi(value = 24)
Constraints(
    requiredNetworkType: NetworkType = NetworkType.NOT_REQUIRED,
    requiresCharging: Boolean = false,
    requiresDeviceIdle: Boolean = false,
    requiresBatteryNotLow: Boolean = false,
    requiresStorageNotLow: Boolean = false,
    contentTriggerUpdateDelayMillis: Long = -1,
    contentTriggerMaxDelayMillis: Long = -1,
    contentUriTriggers: Set<Constraints.ContentUriTrigger> = setOf()
)
```

As above, plus:

- `contentTriggerUpdateDelayMillis` — the delay in milliseconds allowed from the time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled. If there are more changes during this time, the delay resets to the start of the most recent change.
- `contentTriggerMaxDelayMillis` — the maximum delay in milliseconds allowed from the first time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled.
- `contentUriTriggers` — set of [`ContentUriTrigger`](constraints-content-uri-trigger.md). The [`WorkRequest`](work-request.md) will run when a local `content:` `Uri` of one of the triggers in the set is updated.

## Public Functions

### requiresBatteryNotLow

> Added in 1.0.0
```
fun requiresBatteryNotLow(): Boolean
```

Returns `true` if the work should only execute when the battery isn't low.

### requiresCharging

> Added in 1.0.0
```
fun requiresCharging(): Boolean
```

Returns `true` if the work should only execute while the device is charging.

### requiresDeviceIdle

> Added in 1.0.0
```
fun requiresDeviceIdle(): Boolean
```

Returns `true` if the work should only execute while the device is idle.

### requiresStorageNotLow

> Added in 1.0.0
```
fun requiresStorageNotLow(): Boolean
```

Returns `true` if the work should only execute when the storage isn't low.

## Public Properties

### contentTriggerMaxDelayMillis

> Added in 2.8.0
```
@ColumnInfo(name = "trigger_max_content_delay")
val contentTriggerMaxDelayMillis: Long
```

The maximum delay in milliseconds allowed from the first time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled.

### contentTriggerUpdateDelayMillis

> Added in 2.8.0
```
@ColumnInfo(name = "trigger_content_update_delay")
val contentTriggerUpdateDelayMillis: Long
```

The delay in milliseconds allowed from the time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled. If there are more changes during this time, the delay resets to the start of the most recent change.

### contentUriTriggers

> Added in 2.8.0
```
@ColumnInfo(name = "content_uri_triggers")
val contentUriTriggers: Set<Constraints.ContentUriTrigger>
```

Set of [`ContentUriTrigger`](constraints-content-uri-trigger.md). The [`WorkRequest`](work-request.md) will run when a local `content:` `Uri` of one of the triggers in the set is updated.

### requiredNetworkRequest

> Added in 2.10.0
```
val requiredNetworkRequest: NetworkRequest?
```

The `NetworkRequest` required for work to run on. Used only on API levels >= 28 (Android P). On older API levels, [`requiredNetworkType`](#requirednetworktype) is used instead and this property is `null`.

`NetworkRequest`s with a `NetworkSpecifier` set aren't supported, nor are `NetworkRequest`s with `setIncludeOtherUidNetworks` set.

### requiredNetworkType

> Added in 1.0.0
```
@ColumnInfo(name = "required_network_type")
val requiredNetworkType: NetworkType
```

The type of network required for the work to run.
