# API Reference

> Last updated 2026-06-11

# RetainedLifecycle.OnClearedListener

```java
public static interface RetainedLifecycle.OnClearedListener
```

Listener for when the retained lifecycle is cleared. Register an implementation with [`RetainedLifecycle.addOnClearedListener`](retained-lifecycle.md).

## Public Methods

### onCleared

```java
void onCleared()
```

Called when the retained lifecycle is cleared.
