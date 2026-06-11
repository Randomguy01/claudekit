# API Reference

> Last updated 2026-06-11

# ActivityScoped

```java
@Scope
@Retention(CLASS)
public @interface ActivityScoped
```

Scope annotation for bindings that should exist for the life of an activity. A single instance is provided across all dependencies injected from the [`ActivityComponent`](../dagger.hilt.android.components/activity-component.md).
