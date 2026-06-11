# API Reference

> Last updated 2026-06-11

# FragmentScoped

```java
@Scope
@Retention(CLASS)
public @interface FragmentScoped
```

Scope annotation for bindings that should exist for the life of a fragment. A single instance is provided across all dependencies injected from the [`FragmentComponent`](../dagger.hilt.android.components/fragment-component.md).
