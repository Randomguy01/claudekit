# Testing Worker Implementations

WorkManager provides APIs for testing [`Worker`](../api/androidx.work/worker.md), [`ListenableWorker`](../api/androidx.work/listenable-worker.md), and the `ListenableWorker` variants ([`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) and [`RxWorker`](../api/androidx.work/rx-worker.md)).

## Testing Workers

Suppose you have this `Worker`:

```kotlin
class SleepWorker(context: Context, parameters: WorkerParameters) :
    Worker(context, parameters) {

    override fun doWork(): Result {
        // Sleep on a background thread.
        Thread.sleep(1000)
        return Result.success()
    }
}
```

To test it, use [`TestWorkerBuilder`](https://developer.android.com/reference/androidx/work/testing/TestWorkerBuilder), which builds instances of `Worker` for testing business logic:

```kotlin
@RunWith(AndroidJUnit4::class)
class SleepWorkerTest {
    private lateinit var context: Context
    private lateinit var executor: Executor

    @Before
    fun setUp() {
        context = ApplicationProvider.getApplicationContext()
        executor = Executors.newSingleThreadExecutor()
    }

    @Test
    fun testSleepWorker() {
        val worker = TestWorkerBuilder<SleepWorker>(
            context = context,
            executor = executor
        ).build()

        val result = worker.doWork()
        assertThat(result, `is`(Result.success()))
    }
}
```

`TestWorkerBuilder` can also set fields such as `inputData` or `runAttemptCount`, so you can verify worker state in isolation. Suppose `SleepWorker` takes a sleep duration as input data rather than a constant:

```kotlin
class SleepWorker(context: Context, parameters: WorkerParameters) :
    Worker(context, parameters) {

    override fun doWork(): Result {
        // Sleep on a background thread.
        val sleepDuration = inputData.getLong(SLEEP_DURATION, 1000)
        Thread.sleep(sleepDuration)
        return Result.success()
    }

    companion object {
        const val SLEEP_DURATION = "SLEEP_DURATION"
    }
}
```

Provide that input data to `TestWorkerBuilder` to satisfy `SleepWorker`:

```kotlin
@Test
fun testSleepWorker() {
    val worker = TestWorkerBuilder<SleepWorker>(
        context = context,
        executor = executor,
        inputData = workDataOf("SLEEP_DURATION" to 1000L)
    ).build()

    val result = worker.doWork()
    assertThat(result, `is`(Result.success()))
}
```

For more details on the `TestWorkerBuilder` API, see the reference for [`TestListenableWorkerBuilder`](https://developer.android.com/reference/androidx/work/testing/TestListenableWorkerBuilder), its superclass.

## Testing ListenableWorker and its Variants

To test a [`ListenableWorker`](../api/androidx.work/listenable-worker.md) or its variants ([`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) and [`RxWorker`](../api/androidx.work/rx-worker.md)), use [`TestListenableWorkerBuilder`](https://developer.android.com/reference/androidx/work/testing/TestListenableWorkerBuilder). Unlike `TestWorkerBuilder`, which lets you specify the background `Executor` that runs the `Worker`, `TestListenableWorkerBuilder` relies on the threading logic of the `ListenableWorker` implementation.

For example, to test this `CoroutineWorker`:

```kotlin
class SleepWorker(context: Context, parameters: WorkerParameters) :
    CoroutineWorker(context, parameters) {
    override suspend fun doWork(): Result {
        delay(1000L) // milliseconds
        return Result.success()
    }
}
```

Create an instance with `TestListenableWorkerBuilder`, then call its `doWork` function within a coroutine:

```kotlin
@RunWith(AndroidJUnit4::class)
class SleepWorkerTest {
    private lateinit var context: Context

    @Before
    fun setUp() {
        context = ApplicationProvider.getApplicationContext()
    }

    @Test
    fun testSleepWorker() {
        val worker = TestListenableWorkerBuilder<SleepWorker>(context).build()
        runBlocking {
            val result = worker.doWork()
            assertThat(result, `is`(Result.success()))
        }
    }
}
```

`runBlocking` is a useful coroutine builder for tests: code that would execute asynchronously instead runs in parallel.

Testing an `RxWorker` is similar, since `TestListenableWorkerBuilder` handles any `ListenableWorker` subclass. Consider a version of `SleepWorker` that uses RxJava instead of coroutines:

```kotlin
class SleepWorker(
    context: Context,
    parameters: WorkerParameters
) : RxWorker(context, parameters) {
    override fun createWork(): Single<Result> {
        return Single.just(Result.success())
            .delay(1000L, TimeUnit.MILLISECONDS)
    }
}
```

The test uses the same `TestListenableWorkerBuilder` but calls `RxWorker`'s `createWork` function, which returns a `Single` you use to verify your worker's behavior. `TestListenableWorkerBuilder` handles the threading and runs your worker code in parallel:

```kotlin
@RunWith(AndroidJUnit4::class)
class SleepWorkerTest {
    private lateinit var context: Context

    @Before
    fun setUp() {
        context = ApplicationProvider.getApplicationContext()
    }

    @Test
    fun testSleepWorker() {
        val worker = TestListenableWorkerBuilder<SleepWorker>(context).build()
        worker.createWork().subscribe { result ->
            assertThat(result, `is`(Result.success()))
        }
    }
}
```
