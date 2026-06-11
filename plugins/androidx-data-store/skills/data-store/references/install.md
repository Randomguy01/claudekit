# Installing DataStore

## Latest Version

Run [versions.sh](../scripts/versions.sh) to get the latest stable version, or `versions.sh --all` to list every published version.
Default to the latest stable version unless instructed otherwise.

All `androidx.datastore:*` artifacts share the same version. The third-party serialization libraries (kotlinx.serialization, Protocol Buffers) are versioned independently — pass an artifact name to query each one:

| Pinned dependency | `versions.sh` argument |
| --- | --- |
| `androidx.datastore:*` | `versions.sh` (default) |
| `org.jetbrains.kotlinx:kotlinx-serialization-json` | `versions.sh kotlinx-serialization-json` |
| `org.jetbrains.kotlin.plugin.serialization` (Gradle plugin) | `versions.sh kotlin-serialization-plugin` |
| `com.google.protobuf:protobuf-kotlin-lite` (and `protoc`) | `versions.sh protobuf` |
| `com.google.protobuf` (Gradle plugin) | `versions.sh protobuf-plugin` |

The kotlin-serialization-plugin version tracks the Kotlin version, and `protoc` shares the `protobuf` version. Add `--all` to any of these to list every published version.

## Dependencies (app-level)

DataStore has two configurations. Choose based on how you need to store data:

- **Preferences DataStore** — key-value pairs, no predefined schema, no type safety.
- **Typed DataStore** — custom objects persisted through a `Serializer` (Proto or JSON).

> [!IMPORTANT]
> The `-core` variants drop the Android dependency. Use them in Kotlin Multiplatform or pure-Kotlin modules; use the plain artifact in Android modules.

### Preferences DataStore

Required (one of):
- `androidx.datastore:datastore-preferences` — Android
- `androidx.datastore:datastore-preferences-core` — no Android dependency

Optional:
- RxJava2 support: `androidx.datastore:datastore-preferences-rxjava2`
- RxJava3 support: `androidx.datastore:datastore-preferences-rxjava3`

### Typed DataStore (Proto or JSON)

Required (one of):
- `androidx.datastore:datastore` — Android
- `androidx.datastore:datastore-core` — no Android dependency

Optional:
- RxJava2 support: `androidx.datastore:datastore-rxjava2`
- RxJava3 support: `androidx.datastore:datastore-rxjava3`

A typed DataStore needs a serializer. Add the dependency for the format you serialize to — see `proto-datastore.md` or `json-datastore.md` for the serializer itself.

#### JSON (kotlinx.serialization)

- Plugin: `org.jetbrains.kotlin.plugin.serialization`
- `org.jetbrains.kotlinx:kotlinx-serialization-json`

#### Protocol Buffers

- Plugin: `com.google.protobuf`
- `com.google.protobuf:protobuf-kotlin-lite`

Protobuf also requires code-generation config in the module `build.gradle.kts`. The versions below are illustrative — resolve current ones with `versions.sh protobuf-plugin` (the plugin) and `versions.sh protobuf` (`protobuf-kotlin-lite` and `protoc`, which share a version):

```kotlin
plugins {
    id("com.google.protobuf") version "0.9.5"
}

dependencies {
    implementation("com.google.protobuf:protobuf-kotlin-lite:4.32.1")
}

protobuf {
    protoc {
        artifact = "com.google.protobuf:protoc:4.32.1"
    }
    generateProtoTasks {
        all().forEach { task ->
            task.builtins {
                create("java") {
                    option("lite")
                }
                create("kotlin")
            }
        }
    }
}
```

> [!NOTE]
> The `Settings` class for a Proto DataStore is generated at compile time from the `.proto` schema. Rebuild the project after adding or changing the schema.

## Instructions

Install the required dependency for your chosen configuration (Preferences or typed). Add the RxJava artifacts only if the project consumes DataStore through RxJava. For a typed DataStore, add the plugin and dependency for one serialization format — JSON or Protocol Buffers — not both.
