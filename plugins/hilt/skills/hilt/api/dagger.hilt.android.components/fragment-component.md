# API Reference

> Last updated 2026-06-11

# FragmentComponent

```java
public interface FragmentComponent
```

A Hilt component that has the lifetime of the fragment — created in `Fragment#onAttach` and destroyed in `Fragment#onDestroy`. A child of [`ActivityComponent`](activity-component.md), and the parent of [`ViewWithFragmentComponent`](view-with-fragment-component.md). Bindings are scoped to it with `@FragmentScoped`.
