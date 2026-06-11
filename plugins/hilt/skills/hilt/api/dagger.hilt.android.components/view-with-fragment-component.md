# API Reference

> Last updated 2026-06-11

# ViewWithFragmentComponent

```java
public interface ViewWithFragmentComponent
```

A Hilt component that has the lifetime of the view, with access to fragment bindings. Used for a view annotated with both [`@AndroidEntryPoint`](../dagger.hilt.android/android-entry-point.md) and [`@WithFragmentBindings`](../dagger.hilt.android/with-fragment-bindings.md). A child of [`FragmentComponent`](fragment-component.md). Bindings are scoped to it with `@ViewScoped`.
</content>
