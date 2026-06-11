# API Reference

> Last updated 2026-06-11

# ViewModelScoped

```java
@Scope
@Retention(CLASS)
public @interface ViewModelScoped
```

Scope annotation for bindings that should exist for the life of a single `ViewModel`.

Use `ViewModelScoped` to designate a binding within the [`ViewModelComponent`](../dagger.hilt.android.components/view-model-component.md), so that a single provision of the scoped binding will be shared across all dependencies injected into the `ViewModel` annotated with [`@HiltViewModel`](../dagger.hilt.android.lifecycle/hilt-view-model.md). Other `ViewModel` classes that request the scoped binding will receive a different instance. To share a single instance across multiple `ViewModel` classes, use a wider scope from a parent component such as `@Singleton` or [`@ActivityRetainedScoped`](activity-retained-scoped.md).
