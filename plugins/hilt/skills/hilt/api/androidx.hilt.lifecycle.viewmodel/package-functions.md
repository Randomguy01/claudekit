# API Reference

> Last updated 2026-06-11

# androidx.hilt.lifecycle.viewmodel — Top-Level Functions

The package-level helper functions in `androidx.hilt.lifecycle.viewmodel`. Artifact: `androidx.hilt:hilt-lifecycle-viewmodel`.

## Top-Level Functions

### HiltViewModelFactory

> Added in 1.3.0

```kotlin
fun HiltViewModelFactory(
    context: Context,
    delegateFactory: ViewModelProvider.Factory
): ViewModelProvider.Factory
```

Creates a `ViewModelProvider.Factory` that retrieves [`HiltViewModel`](../dagger.hilt.android.lifecycle/hilt-view-model.md)-annotated `ViewModel`s, delegating any non-Hilt `ViewModel` to the supplied factory.

- `context` — the activity context.
- `delegateFactory` — the delegated factory, used for `ViewModel`s that Hilt does not create.

Throws `IllegalStateException` if the given context is not an activity.
