# JSON DataStore

A typed DataStore persists a custom class to disk through a `Serializer`. This variant serializes that class to JSON with [kotlinx.serialization](https://github.com/Kotlin/kotlinx.serialization). For setup and dependencies — the serialization plugin and `kotlinx-serialization-json` — see `install.md`.

## Define the Schema and Serializer

Annotate the class you want to persist with `@Serializable`:

```kotlin
@Serializable
data class Settings(
    val exampleCounter: Int
)
```

Define a `Serializer<T>` for that class, where `T` is the annotated type. Include a `defaultValue` for DataStore to return before any file has been written:

```kotlin
object SettingsSerializer : Serializer<Settings> {

    override val defaultValue: Settings = Settings(exampleCounter = 0)

    override suspend fun readFrom(input: InputStream): Settings =
        try {
            Json.decodeFromString<Settings>(
                input.readBytes().decodeToString()
            )
        } catch (serialization: SerializationException) {
            throw CorruptionException("Unable to read Settings", serialization)
        }

    override suspend fun writeTo(t: Settings, output: OutputStream) {
        output.write(
            Json.encodeToString(t)
                .encodeToByteArray()
        )
    }
}
```

> [!NOTE]
> Throwing `CorruptionException` from `readFrom` signals unreadable data. To recover automatically instead of letting that exception propagate, configure a corruption handler — see `corruption.md`.

## Create the DataStore

Use the `dataStore` property delegate to create a `DataStore<Settings>`. Declare it once at the top level of a Kotlin file and access it through that property everywhere else, which keeps the DataStore a singleton. The `fileName` parameter names the file the data is persisted to, and `serializer` is the serializer defined above:

```kotlin
val Context.dataStore: DataStore<Settings> by dataStore(
    fileName = "settings.json",
    serializer = SettingsSerializer,
)
```

> [!IMPORTANT]
> Create only one `DataStore` instance per file per process. Declaring the delegate at the top level — not inside a function or class — enforces this.

## Read

Expose a property of the stored object as a `Flow` through the `DataStore.data` property:

```kotlin
fun counterFlow(): Flow<Int> = context.dataStore.data.map { settings ->
    settings.exampleCounter
}
```

> [!NOTE]
> To collect this `Flow` in a Compose UI, expose it through a `ViewModel` rather than reading the DataStore directly from a composable — see `compose.md`.

## Write

`updateData` applies a transactional, atomic read-modify-write to the stored object. Because the type is an immutable data class, return a modified copy:

```kotlin
suspend fun incrementCounter() {
    context.dataStore.updateData { settings ->
        settings.copy(exampleCounter = settings.exampleCounter + 1)
    }
}
```
