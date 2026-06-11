# Preferences DataStore

Preferences DataStore stores key-value pairs with a `SharedPreferences`-like API. It has no predefined schema and provides no type safety — each value is reached through a typed key. For setup and dependencies, see `install.md`.

## Define Keys

Because there is no schema, define one typed key per value using the key-type function that matches the value's type:

```kotlin
val EXAMPLE_COUNTER = intPreferencesKey("example_counter")
```

There is a key-type function for each supported type — `intPreferencesKey`, `longPreferencesKey`, `floatPreferencesKey`, `doublePreferencesKey`, `booleanPreferencesKey`, `stringPreferencesKey`, `stringSetPreferencesKey`, and `byteArrayPreferencesKey`. The `String` argument is the persisted name of the key.

## Create the DataStore

Use the `preferencesDataStore` property delegate to create a `DataStore<Preferences>`. Declare it once at the top level of a Kotlin file and access it through that property everywhere else, which keeps the DataStore a singleton. The `name` parameter names the file the data is persisted to.

```kotlin
// At the top level of your Kotlin file:
val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "settings")
```

> [!IMPORTANT]
> Create only one `DataStore` instance per file per process. Declaring the delegate at the top level — not inside a function or class — enforces this.

## Read

Expose a stored value as a `Flow` through the `DataStore.data` property, mapping the `Preferences` object to the value for your key. Supply a default for when the key has not been written yet:

```kotlin
fun counterFlow(): Flow<Int> = context.dataStore.data.map { preferences ->
    preferences[EXAMPLE_COUNTER] ?: 0
}
```

> [!NOTE]
> To collect this `Flow` in a Compose UI, expose it through a `ViewModel` rather than reading the DataStore directly from a composable — see `compose.md`.

## Write

`updateData` applies a transactional, atomic read-modify-write to the stored data. Convert the read-only `Preferences` to a `MutablePreferences` inside the block to set new values:

```kotlin
suspend fun incrementCounter() {
    context.dataStore.updateData {
        it.toMutablePreferences().also { preferences ->
            preferences[EXAMPLE_COUNTER] = (preferences[EXAMPLE_COUNTER] ?: 0) + 1
        }
    }
}
```

> [!NOTE]
> The `edit` suspend function is a shorthand for the same operation: it hands the block a `MutablePreferences` directly, without the `toMutablePreferences()` conversion.
