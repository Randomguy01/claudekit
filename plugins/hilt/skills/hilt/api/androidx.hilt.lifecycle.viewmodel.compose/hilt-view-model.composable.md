# API Reference

> Last updated 2026-06-11

# hiltViewModel

> Added in 1.3.0

```kotlin
@Composable
inline fun <reified VM : ViewModel> hiltViewModel(
    viewModelStoreOwner: ViewModelStoreOwner =
        checkNotNull(LocalViewModelStoreOwner.current) {
            "No ViewModelStoreOwner was provided via LocalViewModelStoreOwner"
        },
    key: String? = null
): VM
```

Returns an existing [`HiltViewModel`](../dagger.hilt.android.lifecycle/hilt-view-model.md)-annotated `ViewModel` or creates a new one scoped to the current `ViewModelStoreOwner`. Artifact: `androidx.hilt:hilt-lifecycle-viewmodel-compose`.

- `viewModelStoreOwner` — the owner the `ViewModel` is scoped to; defaults to the current `LocalViewModelStoreOwner`.
- `key` — an optional key to distinguish multiple `ViewModel`s of the same type under the same owner.

## Assisted injection overload

> Added in 1.3.0

```kotlin
@Composable
inline fun <reified VM : ViewModel, reified VMF> hiltViewModel(
    viewModelStoreOwner: ViewModelStoreOwner =
        checkNotNull(LocalViewModelStoreOwner.current) {
            "No ViewModelStoreOwner was provided via LocalViewModelStoreOwner"
        },
    key: String? = null,
    noinline creationCallback: (VMF) -> VM
): VM
```

Returns or creates a [`HiltViewModel`](../dagger.hilt.android.lifecycle/hilt-view-model.md)-annotated `ViewModel` whose constructor is annotated with [`@AssistedInject`](../dagger.assisted/assisted-inject.md). `VMF` is the `@AssistedFactory` interface declared via the `@HiltViewModel(assistedFactory = ...)` element; `creationCallback` receives that factory and returns the `ViewModel`, letting you pass runtime arguments.

- `viewModelStoreOwner` — the owner the `ViewModel` is scoped to; defaults to the current `LocalViewModelStoreOwner`.
- `key` — an optional key to distinguish multiple `ViewModel`s of the same type under the same owner.
- `creationCallback` — builds the `ViewModel` from its assisted factory `VMF`.

Both overloads obtain their factory from [`rememberHiltViewModelFactory`](remember-hilt-view-model-factory.composable.md).
