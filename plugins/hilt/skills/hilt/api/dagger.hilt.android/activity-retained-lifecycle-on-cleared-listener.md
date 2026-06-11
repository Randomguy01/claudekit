# API Reference

> Last updated 2026-06-11

# ActivityRetainedLifecycle.OnClearedListener

```java
public static interface ActivityRetainedLifecycle.OnClearedListener
    extends RetainedLifecycle.OnClearedListener
```

Listener for receiving a callback for when the [`ActivityRetainedComponent`](../dagger.hilt.android.components/activity-retained-component.md) will no longer be used and destroyed. Register it via [`ActivityRetainedLifecycle.addOnClearedListener`](activity-retained-lifecycle.md#addonclearedlistener).

## Public Methods

### onCleared

```java
void onCleared()
```

Called when the associated retained component is being cleared. Inherited from [`RetainedLifecycle.OnClearedListener`](../dagger.hilt.android.lifecycle/retained-lifecycle-on-cleared-listener.md).
</content>
