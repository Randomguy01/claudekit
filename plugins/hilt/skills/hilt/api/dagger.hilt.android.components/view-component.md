# API Reference

> Last updated 2026-06-11

# ViewComponent

```java
public interface ViewComponent
```

A Hilt component that has the lifetime of the view — created when a view annotated with [`@AndroidEntryPoint`](../dagger.hilt.android/android-entry-point.md) is instantiated and destroyed with it. A child of [`ActivityComponent`](activity-component.md); it has access to activity bindings but not fragment bindings. For a view that needs fragment bindings, annotate it [`@WithFragmentBindings`](../dagger.hilt.android/with-fragment-bindings.md) to associate it with [`ViewWithFragmentComponent`](view-with-fragment-component.md) instead. Bindings are scoped to it with `@ViewScoped`.
