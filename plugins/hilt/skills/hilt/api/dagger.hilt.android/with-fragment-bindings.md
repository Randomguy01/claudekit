# API Reference

> Last updated 2026-06-11

# WithFragmentBindings

```java
@Target(TYPE)
public @interface WithFragmentBindings
```

Makes a `View` annotated with [`@AndroidEntryPoint`](android-entry-point.md) have access to fragment bindings. By default such a view is associated with the activity; annotating it `@WithFragmentBindings` instead associates it with the fragment it is attached to, giving it access to fragment-scoped bindings. A view annotated this way must be attached through a fragment.
