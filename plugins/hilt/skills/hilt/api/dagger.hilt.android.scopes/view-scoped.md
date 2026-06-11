# API Reference

> Last updated 2026-06-11

# ViewScoped

```java
@Scope
@Retention(CLASS)
@Target({METHOD, TYPE})
public @interface ViewScoped
```

Scope annotation for bindings that should exist for the life of a View. A single instance is provided across all dependencies injected from the [`ViewComponent`](../dagger.hilt.android.components/view-component.md) or [`ViewWithFragmentComponent`](../dagger.hilt.android.components/view-with-fragment-component.md).
