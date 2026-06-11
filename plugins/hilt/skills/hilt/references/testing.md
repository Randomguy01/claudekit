# Testing Hilt Code

## Unit Tests

Hilt isn't needed for unit tests. To test a class that uses constructor injection, call its constructor directly with fakes or mocks — exactly as you would if the constructor weren't annotated:

```kotlin
@ActivityScoped
class AnalyticsAdapter @Inject constructor(
  private val service: AnalyticsService
) { ... }

class AnalyticsAdapterTest {

  @Test
  fun `Happy path`() {
    // No Hilt needed: pass a fake or mock AnalyticsService.
    val adapter = AnalyticsAdapter(fakeAnalyticsService)
    assertEquals(...)
  }
}
```

The same applies to ViewModel classes obtained via `hiltViewModel()` in composables — construct the `ViewModel` directly with fakes in unit tests.

## End-to-End Tests

For integration tests, Hilt injects dependencies as it does in production. It needs no maintenance because it generates a fresh set of components for each test.

### Adding Testing Dependencies

Add `com.google.dagger:hilt-android-testing` and its compiler (`kspTest`/`kspAndroidTest`) for the relevant source set — see the testing section of `install.md` for exact coordinates.

> [!NOTE]
> If you use Jetpack integrations (such as `hilt-navigation-compose` for `hiltViewModel()`), add their annotation processors to your test dependencies too.

### UI Test Setup

Annotate any Hilt UI test with `@HiltAndroidTest` — it generates the Hilt components for each test. Add `HiltAndroidRule`, which manages component state and performs injection:

```kotlin
@HiltAndroidTest
class SettingsScreenTest {

  @get:Rule(order = 0)
  val hiltRule = HiltAndroidRule(this)

  @get:Rule(order = 1)
  val composeRule = createAndroidComposeRule<HiltTestActivity>()

  // Compose UI tests here.
}
```

> [!NOTE]
> When the test has other rules, see [Multiple TestRule objects](#multiple-testrule-objects).

To let Hilt inject dependencies into the composable host, create an empty `HiltTestActivity` in the `androidTest` source set annotated with `@AndroidEntryPoint`; `createAndroidComposeRule` uses it as the host for composable content.

#### Test Application

Instrumented tests that use Hilt must run in a Hilt-aware `Application`. The library provides `HiltTestApplication`. (If your tests need a different base application, see [Custom application for tests](#custom-application-for-tests).) Specifying a custom test application isn't Hilt-specific — these are the general steps.

For **instrumented tests**, configure a custom test runner so Hilt applies to every instrumented test:

1. Create a class extending [`AndroidJUnitRunner`](https://developer.android.com/reference/kotlin/androidx/test/runner/AndroidJUnitRunner) in the `androidTest` folder.
2. Override `newApplication` and pass in the generated Hilt test application's name.

```kotlin
class CustomTestRunner : AndroidJUnitRunner() {

  override fun newApplication(cl: ClassLoader?, name: String?, context: Context?): Application {
    return super.newApplication(cl, HiltTestApplication::class.java.name, context)
  }
}
```

Then set this runner in the app module's `build.gradle`, using its full classpath:

```kotlin
android {
  defaultConfig {
    testInstrumentationRunner = "com.example.android.dagger.CustomTestRunner"
  }
}
```

For **Robolectric tests**, set the application in `robolectric.properties`:

```
application = dagger.hilt.android.testing.HiltTestApplication
```

Or configure it per test with Robolectric's `@Config`:

```kotlin
@HiltAndroidTest
@Config(application = HiltTestApplication::class)
class SettingsScreenTest {

  @get:Rule
  var hiltRule = HiltAndroidRule(this)

  // Robolectric tests here.
}
```

### Inject Types in Tests

Field-inject test dependencies with `@Inject`, then call `hiltRule.inject()` to populate them:

```kotlin
@HiltAndroidTest
class SettingsScreenTest {

  @get:Rule(order = 0)
  val hiltRule = HiltAndroidRule(this)

  @get:Rule(order = 1)
  val composeRule = createAndroidComposeRule<HiltTestActivity>()

  @Inject
  lateinit var analyticsAdapter: AnalyticsAdapter

  @Before
  fun init() {
    hiltRule.inject()
  }

  @Test
  fun settingsScreen_showsTitle() {
    composeRule.setContent {
      SettingsScreen()
    }
    composeRule.onNodeWithText("Settings").assertIsDisplayed()
  }
}
```

### Replace a Binding for All Tests

To inject a fake or mock instead of the production binding, replace the module that contains it. Create a module in the `test` or `androidTest` folder annotated with `@TestInstallIn`, naming the production module in `replaces`. Every test in that folder then receives the fake.

Given this production module:

```kotlin
@Module
@InstallIn(SingletonComponent::class)
abstract class AnalyticsModule {

  @Singleton
  @Binds
  abstract fun bindAnalyticsService(
    analyticsServiceImpl: AnalyticsServiceImpl
  ): AnalyticsService
}
```

the replacement is:

```kotlin
@Module
@TestInstallIn(
  components = [SingletonComponent::class],
  replaces = [AnalyticsModule::class]
)
abstract class FakeAnalyticsModule {

  @Singleton
  @Binds
  abstract fun bindAnalyticsService(
    fakeAnalyticsService: FakeAnalyticsService
  ): AnalyticsService
}
```

Because composables usually consume these dependencies indirectly through a `ViewModel` from `hiltViewModel()`, replacing the binding is enough — the composable under test picks up the fake automatically.

### Replace a Binding in a Single Test

To replace a binding for one test class only, uninstall the production module with `@UninstallModules` and declare a replacement module inside the test class:

```kotlin
@UninstallModules(AnalyticsModule::class)
@HiltAndroidTest
class SettingsScreenTest {

  @Module
  @InstallIn(SingletonComponent::class)
  abstract class TestModule {

    @Singleton
    @Binds
    abstract fun bindAnalyticsService(
      fakeAnalyticsService: FakeAnalyticsService
    ): AnalyticsService
  }

  // ...
}
```

> [!TIP]
> Prefer `@TestInstallIn` whenever possible. Hilt creates new components for tests that use `@UninstallModules`, which can significantly increase build times.

> [!WARNING]
> `@UninstallModules` can only uninstall `@InstallIn` modules — not modules without `@InstallIn`, and not `@TestInstallIn` modules. Either case is a compilation error.

### Bind New Values with @BindValue

`@BindValue` binds a test field into the Hilt dependency graph under its declared type, carrying any qualifiers on the field. It replaces and references a binding in one step:

```kotlin
@UninstallModules(AnalyticsModule::class)
@HiltAndroidTest
class SettingsScreenTest {

  @BindValue @JvmField
  val analyticsService: AnalyticsService = FakeAnalyticsService()

  ...
}
```

It composes with qualifiers and other testing annotations — for example, with [Mockito](https://site.mockito.org/) in a Robolectric test:

```kotlin
class SettingsScreenTest {
  ...

  @BindValue @ExampleQualifier @Mock
  lateinit var qualifiedVariable: ExampleCustomType

  // Robolectric tests here.
}
```

For [multibindings](https://dagger.dev/dev-guide/multibindings), use `@BindValueIntoSet` or `@BindValueIntoMap` instead (the latter also requires a map-key annotation on the field).

## Special Cases

### Custom Application for Tests

When `HiltTestApplication` can't be used because your test application must extend a different base, annotate a class or interface with `@CustomTestApplication`, passing the base class:

```kotlin
@CustomTestApplication(BaseApplication::class)
interface HiltTestApplication
```

Hilt generates an `Application` that extends the given base — its name is the annotated class's name with `_Application` appended (here, `HiltTestApplication_Application`). Set this generated application to run in your tests as described under [Test application](#test-application).

> [!NOTE]
> Because `HiltTestApplication_Application` is generated at runtime, the IDE may highlight it in red until you run your tests.

### Multiple TestRule Objects

Compose UI tests already combine `HiltAndroidRule` with a Compose test rule. If you add more `TestRule` objects, ensure `HiltAndroidRule` runs first — declare execution order with the `order` attribute on `@Rule`:

```kotlin
@HiltAndroidTest
class SettingsScreenTest {

  @get:Rule(order = 0)
  var hiltRule = HiltAndroidRule(this)

  @get:Rule(order = 1)
  val composeRule = createAndroidComposeRule<HiltTestActivity>()

  @get:Rule(order = 2)
  val otherRule = SomeOtherRule()

  // UI tests here.
}
```

Alternatively, wrap the rules with `RuleChain`, placing `HiltAndroidRule` as the outer rule:

```kotlin
@HiltAndroidTest
class SettingsScreenTest {

  @get:Rule
  var rule = RuleChain.outerRule(HiltAndroidRule(this))
    .around(SettingsScreenTestRule(...))

  // UI tests here.
}
```

### Use an Entry Point Before the Singleton Component Is Available

`@EarlyEntryPoint` is an escape hatch for when a Hilt entry point (see `dependency-injection.md`) must be created before the singleton component is available in a Hilt test. See the [Hilt docs on `@EarlyEntryPoint`](https://dagger.dev/hilt/early-entry-point).
