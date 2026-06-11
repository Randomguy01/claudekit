# API Reference

> Last updated 2026-06-11

# rememberHiltViewModelFactory

> Added in 1.4.0

```kotlin
@Composable
fun rememberHiltViewModelFactory(
    delegateFactory: ViewModelProvider.Factory =
        LocalViewModelStoreOwner.current.defaultViewModelProviderFactory
): ViewModelProvider.Factory
```

Remembers a `ViewModelProvider.Factory` that allows the creation of [`HiltViewModel`](../dagger.hilt.android.lifecycle/hilt-view-model.md)-annotated `ViewModel` instances within Compose. Artifact: `androidx.hilt:hilt-lifecycle-viewmodel-compose`.

The factory is bound to the current `LocalContext`, which should normally be an `@AndroidEntryPoint`-annotated component (such as a `ComponentActivity`). Pass it to `viewModel(factory)` or other state holders that need a factory to inject Hilt dependencies into your `ViewModel`s. It wraps [`HiltViewModelFactory`](../androidx.hilt.lifecycle.viewmodel/package-functions.md#hiltviewmodelfactory) and is itself remembered against the context and `delegateFactory`.

- `delegateFactory` — a fallback `ViewModelProvider.Factory` used to instantiate `ViewModel`s that are not annotated with `@HiltViewModel`. Defaults to the default factory of the current `LocalViewModelStoreOwner`.
