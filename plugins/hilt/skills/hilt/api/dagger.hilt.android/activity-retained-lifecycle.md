# API Reference

> Last updated 2026-06-11

# ActivityRetainedLifecycle

```java
public interface ActivityRetainedLifecycle extends RetainedLifecycle
```

A [`RetainedLifecycle`](../dagger.hilt.android.lifecycle/retained-lifecycle.md) associated with the lifetime of the [`ActivityRetainedComponent`](../dagger.hilt.android.components/activity-retained-component.md) — i.e. it survives configuration changes and is cleared when the activity is finally destroyed. Inject it to register listeners that run when the retained component is cleared.

## Nested Types

| Type | Summary |
|------|---------|
| [`ActivityRetainedLifecycle.OnClearedListener`](activity-retained-lifecycle-on-cleared-listener.md) | Listener for a callback when the `ActivityRetainedComponent` is destroyed. |

## Public Methods

Inherited from [`RetainedLifecycle`](../dagger.hilt.android.lifecycle/retained-lifecycle.md):

### addOnClearedListener

```java
void addOnClearedListener(RetainedLifecycle.OnClearedListener listener)
```

Registers `listener` to be notified when the retained component is cleared.

### removeOnClearedListener

```java
void removeOnClearedListener(RetainedLifecycle.OnClearedListener listener)
```

Unregisters a previously registered `listener`.
