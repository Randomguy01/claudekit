# API Reference

> Last updated 2026-06-11

# ServiceScoped

```java
@Scope
@Retention(CLASS)
public @interface ServiceScoped
```

Scope annotation for bindings that should exist for the life of a service. A single instance is provided across all dependencies injected from the [`ServiceComponent`](../dagger.hilt.android.components/service-component.md).
