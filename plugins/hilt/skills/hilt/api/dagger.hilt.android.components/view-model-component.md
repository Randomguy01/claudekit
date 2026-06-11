# API Reference

> Last updated 2026-06-11

# ViewModelComponent

```java
public interface ViewModelComponent
```

A Hilt component that has the lifetime of a single `ViewModel`. It is the injection source for `@HiltViewModel`-annotated ViewModels, and provides a `SavedStateHandle` binding. A child of [`ActivityRetainedComponent`](activity-retained-component.md), so it inherits bindings from there and from [`SingletonComponent`](../dagger.hilt.components/singleton-component.md). Bindings are scoped to an individual `ViewModel` instance with `@ViewModelScoped`.
