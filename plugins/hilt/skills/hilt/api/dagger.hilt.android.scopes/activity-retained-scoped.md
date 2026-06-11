# API Reference

> Last updated 2026-06-11

# ActivityRetainedScoped

```java
@Scope
@Retention(CLASS)
public @interface ActivityRetainedScoped
```

Scope annotation for bindings that should exist for the life of an activity, surviving configuration changes. A single instance is provided across all dependencies injected from the [`ActivityRetainedComponent`](../dagger.hilt.android.components/activity-retained-component.md).
