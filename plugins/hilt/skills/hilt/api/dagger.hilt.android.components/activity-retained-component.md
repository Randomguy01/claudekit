# API Reference

> Last updated 2026-06-11

# ActivityRetainedComponent

```java
public interface ActivityRetainedComponent
```

A Hilt component that has the lifetime of a configuration-surviving activity. Created on first access and retained across configuration changes (it is backed by a retained `ViewModel`), it is cleared when the activity is finally destroyed. A child of [`SingletonComponent`](../dagger.hilt.components/singleton-component.md), and the parent of [`ActivityComponent`](activity-component.md) and [`ViewModelComponent`](view-model-component.md). Bindings are scoped to it with `@ActivityRetainedScoped`.
</content>
