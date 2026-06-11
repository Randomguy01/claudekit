# API Reference

> Last updated 2026-06-11

# RetainedLifecycle

```java
public interface RetainedLifecycle
```

A class for registered listeners on a retained lifecycle (generally backed up by a `ViewModel`).

Known subinterfaces are [`ActivityRetainedLifecycle`](../dagger.hilt.android/activity-retained-lifecycle.md) and [`ViewModelLifecycle`](../dagger.hilt.android/view-model-lifecycle.md).

## Nested Types

| Type | Description |
| --- | --- |
| [`RetainedLifecycle.OnClearedListener`](retained-lifecycle-on-cleared-listener.md) | Listener for when the retained lifecycle is cleared. |

## Public Methods

### addOnClearedListener

```java
@MainThread
void addOnClearedListener(@NonNull RetainedLifecycle.OnClearedListener listener)
```

Adds a new [`OnClearedListener`](retained-lifecycle-on-cleared-listener.md) for receiving a callback when the lifecycle is cleared.

### removeOnClearedListener

```java
@MainThread
void removeOnClearedListener(@NonNull RetainedLifecycle.OnClearedListener listener)
```

Removes a [`OnClearedListener`](retained-lifecycle-on-cleared-listener.md) previously added by `addOnClearedListener`.
