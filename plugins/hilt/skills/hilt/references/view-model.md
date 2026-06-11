# Injecting ViewModels with Hilt

Hilt provides extensions for several Jetpack libraries — Compose, `ViewModel`, Navigation, and WorkManager. Add the relevant dependency (see `install.md`) before using each integration.

## Inject ViewModel Objects with Hilt

Provide a [`ViewModel`](https://developer.android.com/topic/libraries/architecture/viewmodel) by annotating it with `@HiltViewModel` and annotating its constructor with `@Inject`:

```kotlin
@HiltViewModel
class ExampleViewModel @Inject constructor(
  private val savedStateHandle: SavedStateHandle,
  private val repository: ExampleRepository
) : ViewModel() {
  ...
}
```

An `@AndroidEntryPoint` activity then obtains the `ViewModel` as usual, via `ViewModelProvider` or the `by viewModels()` [KTX extension](https://developer.android.com/kotlin/ktx):

```kotlin
@AndroidEntryPoint
class ExampleActivity : AppCompatActivity() {
  private val exampleViewModel: ExampleViewModel by viewModels()
  ...
}
```

## Use the ViewModel from Compose

In Compose, the `viewModel()` function automatically uses the `ViewModel` that Hilt constructs from `@HiltViewModel` — no extra wiring needed beyond annotating the root `ComponentActivity` with `@AndroidEntryPoint`:

```kotlin
@HiltViewModel
class MyViewModel @Inject constructor(
  private val savedStateHandle: SavedStateHandle,
  private val repository: ExampleRepository
) : ViewModel() { /* ... */ }

// import androidx.lifecycle.viewmodel.compose.viewModel
@Composable
fun MyScreen(
  viewModel: MyViewModel = viewModel()
) { /* ... */ }
```

> [!TIP]
> When using Navigation Compose, prefer the `hiltViewModel()` function (from `androidx.hilt:hilt-navigation-compose`) over `viewModel()` — it scopes the `ViewModel` correctly to the current navigation destination. See `navigation.md`.

## Use Assisted Injection with ViewModels

Assisted injection lets you supply dynamic runtime arguments alongside Hilt-managed dependencies. Annotate the constructor with `@AssistedInject`, mark the runtime parameters with `@Assisted`, and declare an `@AssistedFactory` interface — Hilt generates the matching `ViewModelProvider.Factory` from it. Point `@HiltViewModel` at that factory:

```kotlin
@HiltViewModel(assistedFactory = MyViewModel.Factory::class)
class MyViewModel @AssistedInject constructor(
  @Assisted val userId: String,
  private val repository: MyRepository
) : ViewModel() {
  @AssistedFactory interface Factory {
    fun create(userId: String): MyViewModel
  }
}
```

In Compose, pass the assisted factory into `hiltViewModel()` during navigation or screen initialization. This removes manual factory boilerplate while keeping the `ViewModel` scoped to the navigation back stack. See the Hilt docs on [assisted injection](https://dagger.dev/hilt/view-model#assisted-injection).

## @ViewModelScoped

All Hilt ViewModels are provided by `ViewModelComponent`, which follows the `ViewModel` lifecycle and survives configuration changes. Scope a dependency to a single `ViewModel` with `@ViewModelScoped`: a single instance of the scoped type is shared across all dependencies injected into that `ViewModel`, while a different `ViewModel` instance receives its own instance.

> [!TIP]
> To share a single instance across multiple ViewModels, scope it with `@ActivityRetainedScoped` or `@Singleton` instead. See `components.md` for the full scope/component table.
