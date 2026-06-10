# Integration Testing WorkManager

WorkManager provides a `work-testing` artifact to help with integration testing of your workers.

## Setup

Add `work-testing` as an `androidTestImplementation` dependency in `build.gradle`:

```kotlin
dependencies {
    val work_version = "2.4.0"

    // optional - Test helpers
    androidTestImplementation("androidx.work:work-testing:$work_version")
}
```

For more on adding dependencies, see the declaring-dependencies section in the [WorkManager release notes](https://developer.android.com/jetpack/androidx/releases/work#declaring_dependencies).

> [!NOTE]
> Beginning with 2.1.0, [`TestWorkerBuilder`](../api/androidx.work.testing/test-worker-builder.md) and [`TestListenableWorkerBuilder`](../api/androidx.work.testing/test-listenable-worker-builder.md) let you test the business logic in your workers without initializing WorkManager with `WorkManagerTestInitHelper`. See [Testing Worker implementations](test.md). The material on this page is still useful when you need integration tests.

> [!TIP]
> Use [`TestListenableWorkerBuilder`](../api/androidx.work.testing/test-listenable-worker-builder.md) to test [`CoroutineWorker`](../api/androidx.work/coroutine-worker.md) implementations: the `work-testing` artifact uses `Dispatchers.Default` rather than your worker's own `CoroutineDispatcher`. See [Testing ListenableWorker and its variants](test.md#testing-listenableworker-and-its-variants).

## Concepts

`work-testing` provides a special test-mode implementation of WorkManager, initialized with [`WorkManagerTestInitHelper`](../api/androidx.work.testing/work-manager-test-init-helper.md). It also provides a [`SynchronousExecutor`](../api/androidx.work.testing/synchronous-executor.md), which makes it easier to write tests synchronously without dealing with multiple threads, locks, or latches.

Using these classes together:

```kotlin
@RunWith(AndroidJUnit4::class)
class BasicInstrumentationTest {
    @Before
    fun setup() {
        val context = InstrumentationRegistry.getTargetContext()
        val config = Configuration.Builder()
            .setMinimumLoggingLevel(Log.DEBUG)
            .setExecutor(SynchronousExecutor())
            .build()

        // Initialize WorkManager for instrumentation tests.
        WorkManagerTestInitHelper.initializeTestWorkManager(context, config)
    }
}
```

## Structuring Tests

With WorkManager initialized in test mode, you're ready to test your workers. Suppose you have an `EchoWorker` that expects some `inputData` and echoes its input to `outputData`:

```kotlin
class EchoWorker(context: Context, parameters: WorkerParameters)
   : Worker(context, parameters) {
   override fun doWork(): Result {
       return when(inputData.size()) {
           0 -> Result.failure()
           else -> Result.success(inputData)
       }
   }
}
```

### Basic Tests

This Android instrumentation test exercises `EchoWorker`. Testing it in test mode is very similar to using `EchoWorker` in a real app:

```kotlin
@Test
@Throws(Exception::class)
fun testSimpleEchoWorker() {
    // Define input data
    val input = workDataOf(KEY_1 to 1, KEY_2 to 2)

    // Create request
    val request = OneTimeWorkRequestBuilder<EchoWorker>()
        .setInputData(input)
        .build()

    val workManager = WorkManager.getInstance(applicationContext)
    // Enqueue and wait for result. This also runs the Worker synchronously
    // because we are using a SynchronousExecutor.
    workManager.enqueue(request).result.get()
    // Get WorkInfo and outputData
    val workInfo = workManager.getWorkInfoById(request.id).get()
    val outputData = workInfo.outputData

    // Assert
    assertThat(workInfo.state, `is`(WorkInfo.State.SUCCEEDED))
    assertThat(outputData, `is`(input))
}
```

Another test verifies that when `EchoWorker` gets no input data, the expected `Result` is `Result.failure()`:

```kotlin
@Test
@Throws(Exception::class)
fun testEchoWorkerNoInput() {
    // Create request
    val request = OneTimeWorkRequestBuilder<EchoWorker>()
        .build()

    val workManager = WorkManager.getInstance(applicationContext)
    workManager.enqueue(request).result.get()
    val workInfo = workManager.getWorkInfoById(request.id).get()

    // Assert
    assertThat(workInfo.state, `is`(WorkInfo.State.FAILED))
}
```

## Simulate Constraints, Delays, and Periodic Work

`WorkManagerTestInitHelper` provides a [`TestDriver`](../api/androidx.work.testing/test-driver.md) that simulates initial delay, met constraints for `ListenableWorker` instances, and intervals for `PeriodicWorkRequest` instances.

### Test Initial Delays

Workers can have initial delays. Rather than waiting out the `initialDelay` in your test, use `TestDriver.setInitialDelayMet` to mark it as met:

```kotlin
@Test
@Throws(Exception::class)
fun testWithInitialDelay() {
    val input = workDataOf(KEY_1 to 1, KEY_2 to 2)

    val request = OneTimeWorkRequestBuilder<EchoWorker>()
        .setInputData(input)
        .setInitialDelay(10, TimeUnit.SECONDS)
        .build()

    val workManager = WorkManager.getInstance(applicationContext)
    val testDriver = WorkManagerTestInitHelper.getTestDriver()
    workManager.enqueue(request).result.get()
    // Tells the WorkManager test framework that initial delays are now met.
    testDriver.setInitialDelayMet(request.id)
    val workInfo = workManager.getWorkInfoById(request.id).get()
    val outputData = workInfo.outputData

    assertThat(workInfo.state, `is`(WorkInfo.State.SUCCEEDED))
    assertThat(outputData, `is`(input))
}
```

### Test Constraints

Use `TestDriver.setAllConstraintsMet` to mark a worker's constraints as met:

```kotlin
@Test
@Throws(Exception::class)
fun testWithConstraints() {
    val input = workDataOf(KEY_1 to 1, KEY_2 to 2)

    val constraints = Constraints.Builder()
        .setRequiredNetworkType(NetworkType.CONNECTED)
        .build()

    val request = OneTimeWorkRequestBuilder<EchoWorker>()
        .setInputData(input)
        .setConstraints(constraints)
        .build()

    val workManager = WorkManager.getInstance(applicationContext)
    val testDriver = WorkManagerTestInitHelper.getTestDriver()
    workManager.enqueue(request).result.get()
    // Tells the testing framework that all constraints are met.
    testDriver.setAllConstraintsMet(request.id)
    val workInfo = workManager.getWorkInfoById(request.id).get()
    val outputData = workInfo.outputData

    assertThat(workInfo.state, `is`(WorkInfo.State.SUCCEEDED))
    assertThat(outputData, `is`(input))
}
```

### Test Periodic Work

Use `TestDriver.setPeriodDelayMet` to indicate that an interval is complete:

```kotlin
@Test
@Throws(Exception::class)
fun testPeriodicWork() {
    val input = workDataOf(KEY_1 to 1, KEY_2 to 2)

    val request = PeriodicWorkRequestBuilder<EchoWorker>(15, MINUTES)
        .setInputData(input)
        .build()

    val workManager = WorkManager.getInstance(applicationContext)
    val testDriver = WorkManagerTestInitHelper.getTestDriver()
    workManager.enqueue(request).result.get()
    // Tells the testing framework the period delay is met
    testDriver.setPeriodDelayMet(request.id)
    val workInfo = workManager.getWorkInfoById(request.id).get()

    assertThat(workInfo.state, `is`(WorkInfo.State.ENQUEUED))
}
```
