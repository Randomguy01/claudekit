# Hilt and Jetpack Navigation

Hilt integrates with the Jetpack Navigation libraries to retrieve a `ViewModel` scoped to the current navigation destination. Add `androidx.hilt:hilt-navigation-compose` (see `install.md`).

In both Navigation Compose and Navigation 3, the `hiltViewModel()` function returns a `@HiltViewModel`-annotated `ViewModel` scoped to the current destination. It works with fragments or activities annotated with `@AndroidEntryPoint`. See `view-model.md` for defining the `ViewModel` itself.

## Navigation Compose

ViewModels are scoped to navigation destinations automatically. Call `hiltViewModel()` inside a `composable` destination to get an instance scoped to that destination:

```kotlin
// import androidx.hilt.navigation.compose.hiltViewModel

@Composable
fun MyApp() {
  val navController = rememberNavController()
  val startRoute = "example"
  NavHost(navController, startDestination = startRoute) {
    composable("example") { backStackEntry ->
      // Creates a ViewModel scoped to the current BackStackEntry.
      val viewModel = hiltViewModel<MyViewModel>()
      MyScreen(viewModel)
    }
    /* ... */
  }
}
```

## Scope a ViewModel to a Navigation Graph

To share a `ViewModel` across the destinations of a [nested graph](https://developer.android.com/guide/navigation/design/nested-graphs#compose) rather than scope it to a single destination, retrieve the parent graph's back stack entry with `getBackStackEntry` and pass it to `hiltViewModel()`:

```kotlin
// import androidx.hilt.navigation.compose.hiltViewModel
// import androidx.navigation.compose.getBackStackEntry

@Composable
fun MyApp() {
  val navController = rememberNavController()
  val startRoute = "example"
  val innerStartRoute = "exampleWithRoute"
  NavHost(navController, startDestination = startRoute) {
    navigation(startDestination = innerStartRoute, route = "Parent") {
      // ...
      composable("exampleWithRoute") { backStackEntry ->
        val parentEntry = remember(backStackEntry) {
          navController.getBackStackEntry("Parent")
        }
        val parentViewModel = hiltViewModel<ParentViewModel>(parentEntry)
        ExampleWithRouteScreen(parentViewModel)
      }
    }
  }
}
```

## Navigation 3

In Navigation 3, destinations are `NavEntry` objects. [Scope ViewModels to `NavEntry`s](https://developer.android.com/guide/navigation/navigation-3/save-state#scoping-viewmodels) with `rememberViewModelStoreNavEntryDecorator`, then call `hiltViewModel()` inside that `NavEntry`'s provider:

```kotlin
NavDisplay(...,
  entryDecorators = listOf(..., rememberViewModelStoreNavEntryDecorator()),
  entryProvider = entryProvider {
    entry { key ->
      val viewModel = hiltViewModel()
      MyScreen(viewModel = viewModel)
    }
  }
)
```
