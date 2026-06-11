# Proto DataStore

A typed DataStore persists a custom class to disk through a `Serializer`. This variant uses [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) to define the schema and generate the class. For setup and dependencies — the protobuf Gradle plugin and code-generation config — see `install.md`.

## Define the Schema and Serializer

Proto DataStore requires a schema declared in a `.proto` file under `app/src/main/proto/`. The schema defines the type of the objects you persist. Add `settings.proto`:

```proto
syntax = "proto3";

option java_package = "com.example.datastore.snippets.proto";
option java_multiple_files = true;

message Settings {
  int32 example_counter = 1;
}
```

> [!NOTE]
> The `Settings` class is generated at compile time from the message in the `.proto` file. Rebuild the project after adding or changing the schema.

Define a `Serializer<T>`, where `T` is the generated type. Include a `defaultValue` for DataStore to return before any file has been written — `getDefaultInstance()` supplies the proto's zero values:

```kotlin
object SettingsSerializer : Serializer<Settings> {
    override val defaultValue: Settings = Settings.getDefaultInstance()

    override suspend fun readFrom(input: InputStream): Settings {
        try {
            return Settings.parseFrom(input)
        } catch (exception: InvalidProtocolBufferException) {
            throw CorruptionException("Cannot read proto.", exception)
        }
    }

    override suspend fun writeTo(t: Settings, output: OutputStream) {
        return t.writeTo(output)
    }
}
```

> [!NOTE]
> Throwing `CorruptionException` from `readFrom` signals unreadable data. To recover automatically instead of letting that exception propagate, configure a corruption handler — see `corruption.md`.

## Create the DataStore

Use the `dataStore` property delegate to create a `DataStore<Settings>`. Declare it once at the top level of a Kotlin file and access it through that property everywhere else, which keeps the DataStore a singleton. The `fileName` parameter names the file the data is persisted to, and `serializer` is the serializer defined above:

```kotlin
val Context.dataStore: DataStore<Settings> by dataStore(
    fileName = "settings.pb",
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

`updateData` applies a transactional, atomic read-modify-write to the stored object. Use the `copy { }` DSL generated for the proto type to return a modified instance:

```kotlin
suspend fun incrementCounter() {
    context.dataStore.updateData { settings ->
        settings.copy { exampleCounter = exampleCounter + 1 }
    }
}
```
