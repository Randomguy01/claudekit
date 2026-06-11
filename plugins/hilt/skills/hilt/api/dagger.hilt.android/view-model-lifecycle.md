# API Reference

> Last updated 2026-06-11

# ViewModelLifecycle

```java
public interface ViewModelLifecycle extends RetainedLifecycle
```

A class for registering listeners on the `ViewModel` lifecycle. A [`RetainedLifecycle`](../dagger.hilt.android.lifecycle/retained-lifecycle.md) associated with the lifetime of the [`ViewModelComponent`](../dagger.hilt.android.components/view-model-component.md); its listeners run when the `ViewModel` is cleared. Inject it to clean up resources tied to the ViewModel scope.

## Public Methods

Inherited from [`RetainedLifecycle`](../dagger.hilt.android.lifecycle/retained-lifecycle.md):

### addOnClearedListener

```java
void addOnClearedListener(RetainedLifecycle.OnClearedListener listener)
```

Registers `listener` to be notified when the `ViewModel` is cleared.

### removeOnClearedListener

```java
void removeOnClearedListener(RetainedLifecycle.OnClearedListener listener)
```

Unregisters a previously registered `listener`.
</content>
