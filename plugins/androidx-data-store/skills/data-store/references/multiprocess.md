# Multi-Process DataStore

**Requires DataStore 1.1.0+**

Access the same DataStore file from more than one process with the same data-consistency guarantees DataStore provides within a single process:

- Reads return only data that has been persisted to disk.
- Read-after-write consistency.
- Writes are serialized.
- Reads are never blocked by writes.

> [!IMPORTANT]
> Do not mix `SingleProcessDataStore` and `MultiProcessDataStore` for the same file. If a file is reached from more than one process, every process must construct it with `MultiProcessDataStoreFactory`.

## Create the DataStore

Construct the DataStore with `MultiProcessDataStoreFactory.create` in every process that touches the file — both the app and the service. This replaces the `dataStore` / `preferencesDataStore` delegate used for single-process access.

Consolidate the construction, reads, and writes in one class so every process uses identical configuration. This example persists a `Time` type:

```kotlin
@Serializable
data class Time(
    val lastUpdateMillis: Long
)

class MultiProcessDataStore(context: Context) {
    private val dataStore = MultiProcessDataStoreFactory.create(
        serializer = TimeSerializer,
        produceFile = {
            File("${context.filesDir.path}/time.json")
        },
        corruptionHandler = null
    )

    fun timeFlow(): Flow<Long> = dataStore.data.map { time ->
        time.lastUpdateMillis
    }

    suspend fun updateLastUpdateTime() {
        dataStore.updateData { time ->
            time.copy(lastUpdateMillis = System.currentTimeMillis())
        }
    }
}
```

> [!NOTE]
> `TimeSerializer` is an ordinary `Serializer<Time>` — multi-process changes only how the DataStore is constructed, not how it is serialized. Write the serializer as shown in `json-datastore.md` or `proto-datastore.md`. Reads (`DataStore.data`) and writes (`updateData`) also work exactly as in those files.

> [!NOTE]
> Pass a `corruptionHandler` instead of `null` to recover from a corrupted file — see `corruption.md`.

## Run a Service in a Separate Process

Declare the service with the `android:process` attribute in `AndroidManifest.xml`:

```xml
<service
    android:name=".TimestampUpdateService"
    android:process=":my_process_id" />
```

> [!IMPORTANT]
> The colon (`:`) prefix on `android:process` makes the service run in a new process that is private to the application.

The service writes to the DataStore periodically; the app reads the value through `timeFlow()` in its own process:

```kotlin
class TimestampUpdateService : Service() {
    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val multiProcessDataStore by lazy { MultiProcessDataStore(applicationContext) }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        serviceScope.launch {
            while (true) {
                multiProcessDataStore.updateLastUpdateTime()
                delay(1000)
            }
        }
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }
}
```

> [!NOTE]
> To display the value in a Compose UI, observe `timeFlow()` through a `ViewModel` — see `compose.md`.

## Inject a Per-Process Instance

With Hilt, provide the DataStore as a `@Singleton` so each process gets exactly one instance:

```kotlin
@Provides
@Singleton
fun provideDataStore(@ApplicationContext context: Context): DataStore<Time> =
   MultiProcessDataStoreFactory.create(...)
```
