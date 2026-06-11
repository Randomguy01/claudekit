# API Reference

> Last updated 2026-06-11

# HiltViewModel

```java
@Target(TYPE)
@Retention(CLASS)
public @interface HiltViewModel
```

Identifies a `ViewModel` for constructor injection.

The `ViewModel` annotated with `@HiltViewModel` is available for creation by the default `HiltViewModelFactory` and can be retrieved by default in an `Activity` or `Fragment` annotated with [`@AndroidEntryPoint`](../dagger.hilt.android/android-entry-point.md). The `HiltViewModel` containing a constructor annotated with `@Inject` will have its dependencies defined in the constructor parameters injected by Dagger's Hilt.

Exactly one constructor must be annotated with either `@Inject` or [`@AssistedInject`](../dagger.assisted/assisted-inject.md). Only dependencies available in the [`ViewModelComponent`](../dagger.hilt.android.components/view-model-component.md) can be injected into the `ViewModel`.

## Elements

### assistedFactory

```java
Class<?> assistedFactory default Object.class
```

Returns a factory class that can be used to create this `ViewModel` with assisted injection. The default value, `Object.class`, denotes that no factory is specified and the `ViewModel` is not assisted injected.
