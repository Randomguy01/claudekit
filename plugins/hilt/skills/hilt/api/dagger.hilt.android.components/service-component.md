# API Reference

> Last updated 2026-06-11

# ServiceComponent

```java
public interface ServiceComponent
```

A Hilt component that has the lifetime of the service — created in `Service#onCreate` and destroyed in `Service#onDestroy`. A child of [`SingletonComponent`](../dagger.hilt.components/singleton-component.md). Bindings are scoped to it with `@ServiceScoped`.
</content>
