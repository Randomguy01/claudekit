# API Reference

> Last updated 2026-06-10

# Constraints.Builder

> Added in 1.0.0

```
class Constraints.Builder
```

A Builder for a [`Constraints`](constraints.md) object.

## Public Constructors

### Builder

> Added in 1.0.0
```
Builder()
```

## Public Functions

### addContentUriTrigger

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun addContentUriTrigger(uri: Uri, triggerForDescendants: Boolean): Constraints.Builder
```

Sets whether the [`WorkRequest`](work-request.md) should run when a local `content:` `Uri` is updated.

- `uri` — the local `content:` `Uri` to observe.
- `triggerForDescendants` — `true` if any changes in descendants cause this [`WorkRequest`](work-request.md) to run.

### build

> Added in 1.0.0
```
fun build(): Constraints
```

Generates the [`Constraints`](constraints.md) from this Builder.

### setRequiredNetworkRequest

> Added in 2.10.0
```
fun setRequiredNetworkRequest(
    networkRequest: NetworkRequest,
    networkType: NetworkType
): Constraints.Builder
```

Sets whether the device should have a particular `NetworkRequest` for the [`WorkRequest`](work-request.md) to run, on API levels >= 28 (Android P). On older API levels, `networkType` is used instead.

`NetworkRequest`s with a `NetworkSpecifier` set aren't supported, nor are `NetworkRequest`s with `setIncludeOtherUidNetworks` set; an `IllegalArgumentException` is thrown if such requests are passed.

### setRequiredNetworkType

> Added in 1.0.0
```
fun setRequiredNetworkType(networkType: NetworkType): Constraints.Builder
```

Sets whether the device should have a particular [`NetworkType`](network-type.md) for the [`WorkRequest`](work-request.md) to run. The default value is [`NetworkType.NOT_REQUIRED`](network-type.md#not_required).

### setRequiresBatteryNotLow

> Added in 1.0.0
```
fun setRequiresBatteryNotLow(requiresBatteryNotLow: Boolean): Constraints.Builder
```

Sets whether the device battery should be at an acceptable level for the [`WorkRequest`](work-request.md) to run. The default value is `false`.

### setRequiresCharging

> Added in 1.0.0
```
fun setRequiresCharging(requiresCharging: Boolean): Constraints.Builder
```

Sets whether the device should be charging for the [`WorkRequest`](work-request.md) to run. The default value is `false`.

### setRequiresDeviceIdle

> Added in 1.0.0
```
fun setRequiresDeviceIdle(requiresDeviceIdle: Boolean): Constraints.Builder
```

Sets whether the device should be idle for the [`WorkRequest`](work-request.md) to run. The default value is `false`.

### setRequiresStorageNotLow

> Added in 1.0.0
```
fun setRequiresStorageNotLow(requiresStorageNotLow: Boolean): Constraints.Builder
```

Sets whether the device's available storage should be at an acceptable level for the [`WorkRequest`](work-request.md) to run. The default value is `false`.

### setTriggerContentMaxDelay

> Added in 1.0.0
```
@RequiresApi(value = 26)
fun setTriggerContentMaxDelay(duration: Duration): Constraints.Builder
```

Sets the maximum delay allowed from the first time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled.

### setTriggerContentMaxDelay

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun setTriggerContentMaxDelay(duration: Long, timeUnit: TimeUnit): Constraints.Builder
```

Sets the maximum delay allowed from the first time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled.

- `duration` — the length of the delay in `timeUnit` units.
- `timeUnit` — the units of time for `duration`.

### setTriggerContentUpdateDelay

> Added in 1.0.0
```
@RequiresApi(value = 26)
fun setTriggerContentUpdateDelay(duration: Duration): Constraints.Builder
```

Sets the delay allowed from the time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled. If there are more changes during this time, the delay resets to the start of the most recent change.

### setTriggerContentUpdateDelay

> Added in 1.0.0
```
@RequiresApi(value = 24)
fun setTriggerContentUpdateDelay(duration: Long, timeUnit: TimeUnit): Constraints.Builder
```

Sets the delay allowed from the time a `content:` `Uri` change is detected to the time the [`WorkRequest`](work-request.md) is scheduled. If there are more changes during this time, the delay resets to the start of the most recent change.

- `duration` — the length of the delay in `timeUnit` units.
- `timeUnit` — the units of time for `duration`.
