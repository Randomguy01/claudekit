# API Reference

> Last updated 2026-06-11

# ActivityComponent

```java
public interface ActivityComponent
```

A Hilt component that has the lifetime of the activity — created in `Activity#onCreate` and destroyed in `Activity#onDestroy`, so unlike [`ActivityRetainedComponent`](activity-retained-component.md) it is recreated across configuration changes. A child of [`ActivityRetainedComponent`](activity-retained-component.md), and the parent of [`FragmentComponent`](fragment-component.md) and [`ViewComponent`](view-component.md). Bindings are scoped to it with `@ActivityScoped`.
</content>
