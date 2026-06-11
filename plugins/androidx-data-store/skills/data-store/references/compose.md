# Using DataStore in Compose

Follow Android app architecture: keep DataStore operations in the data layer (a repository) and expose the data to the UI through a `ViewModel`. This applies to every DataStore variant — the UI consumes a `Flow` of values and never sees the `DataStore` itself.

> [!CAUTION]
> Do not read from or write to DataStore directly inside composable functions. Route reads through a `ViewModel` and writes through `ViewModel` functions.

## Expose DataStore through a ViewModel

Pass the repository that wraps the DataStore into the `ViewModel`, and convert its `Flow` to a `StateFlow` with `stateIn` so the UI can observe it. Expose writes as `ViewModel` functions that launch in `viewModelScope`:

```kotlin
class SettingsViewModel(
    private val userPreferencesRepository: UserPreferencesRepository
) : ViewModel() {

    // Expose the DataStore flow as a StateFlow for Compose
    val userSettings: StateFlow<UserSettings> = userPreferencesRepository.userSettingsFlow
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = UserSettings.getDefaultInstance()
        )

    fun updateCounter(newValue: Int) {
        viewModelScope.launch {
            userPreferencesRepository.updateCounter(newValue)
        }
    }
}
```

## Observe and Write from a Composable

Use `collectAsStateWithLifecycle` to observe the `StateFlow` as Compose `State`, and call the `ViewModel` functions to write:

```kotlin
@Composable
fun SettingsScreen(
    viewModel: SettingsViewModel = viewModel()
) {
    // Safely collect the state
    val settings by viewModel.userSettings.collectAsStateWithLifecycle()

    Column(modifier = Modifier.padding(16.dp)) {
        Text(text = "Current counter: ${settings.counter}")

        Spacer(modifier = Modifier.height(8.dp))

        Button(onClick = { viewModel.updateCounter(settings.counter + 1) }) {
            Text("Increment Counter")
        }
    }
}
```

> [!NOTE]
> `collectAsStateWithLifecycle` also accepts a raw `Flow` with an `initialValue` argument, for when exposing a `StateFlow` from the `ViewModel` isn't warranted:
> ```kotlin
> val counter by counterFlow.collectAsStateWithLifecycle(initialValue = 0)
> ```

For more on converting state into Compose, see [State and Jetpack Compose](https://developer.android.com/develop/ui/compose/state#use-other-types-of-state-in-jetpack-compose).
