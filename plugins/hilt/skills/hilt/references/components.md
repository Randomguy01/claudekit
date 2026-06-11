# Generated Components for Android Classes

For each Android class you can field-inject, Hilt generates an associated component that you name in `@InstallIn`. Each component is responsible for injecting its bindings into the corresponding Android class.

| Hilt component | Injector for |
|---|---|
| `SingletonComponent` | `Application` |
| `ActivityRetainedComponent` | N/A |
| `ViewModelComponent` | `ViewModel` |
| `ActivityComponent` | `Activity` |
| `ServiceComponent` | `Service` |

> [!NOTE]
> Hilt doesn't generate a component for broadcast receivers — it injects them directly from `SingletonComponent`.

## Component Lifetimes

Hilt creates and destroys instances of the generated components in step with the lifecycle of the corresponding Android class. The created/destroyed points also tell you which lifecycle callback each class is injected in.

| Generated component | Created at | Destroyed at |
|---|---|---|
| `SingletonComponent` | `Application#onCreate()` | `Application` destroyed |
| `ActivityRetainedComponent` | `Activity#onCreate()` | `Activity#onDestroy()` |
| `ViewModelComponent` | `ViewModel` created | `ViewModel` destroyed |
| `ActivityComponent` | `Activity#onCreate()` | `Activity#onDestroy()` |
| `ServiceComponent` | `Service#onCreate()` | `Service#onDestroy()` |

> [!NOTE]
> `ActivityRetainedComponent` survives configuration changes: it is created at the first `Activity#onCreate()` and destroyed at the last `Activity#onDestroy()`.

## Component Scopes

By default every binding is *unscoped*: Hilt creates a new instance each time the binding is requested. Scoping a binding to a component makes Hilt create it once per instance of that component and share the same instance for every request within it.

| Android class | Generated component | Scope |
|---|---|---|
| `Application` | `SingletonComponent` | `@Singleton` |
| `Activity` | `ActivityRetainedComponent` | `@ActivityRetainedScoped` |
| `ViewModel` | `ViewModelComponent` | `@ViewModelScoped` |
| `Activity` | `ActivityComponent` | `@ActivityScoped` |
| `Service` | `ServiceComponent` | `@ServiceScoped` |

Scope a binding by annotating its constructor-injected class (or its `@Binds`/`@Provides` function) with the scope annotation. Scoping `AnalyticsAdapter` to `ActivityComponent` makes Hilt provide the same instance throughout the activity's life:

```kotlin
@ActivityScoped
class AnalyticsAdapter @Inject constructor(
  private val service: AnalyticsService
) { ... }
```

> [!CAUTION]
> A scoped object stays in memory until its component is destroyed, so scoping is costly. Minimize scoped bindings — reserve them for bindings with internal state that must be shared within a scope, bindings that need synchronization, or bindings you've measured to be expensive to create.

> [!IMPORTANT]
> A binding's scope must match the scope of the component it's installed in. To share a single instance app-wide, scope it `@Singleton` and install it in `SingletonComponent`, not `ActivityComponent`.

```kotlin
// If AnalyticsService is an interface.
@Module
@InstallIn(SingletonComponent::class)
abstract class AnalyticsModule {

  @Singleton
  @Binds
  abstract fun bindAnalyticsService(
    analyticsServiceImpl: AnalyticsServiceImpl
  ): AnalyticsService
}

// If you don't own AnalyticsService.
@Module
@InstallIn(SingletonComponent::class)
object AnalyticsModule {

  @Singleton
  @Provides
  fun provideAnalyticsService(): AnalyticsService {
    return Retrofit.Builder()
      .baseUrl("https://example.com")
      .build()
      .create(AnalyticsService::class.java)
  }
}
```

> [!NOTE]
> For the difference between `@ActivityRetainedScoped` and `@ViewModelScoped`, see the `@ViewModelScoped` section in `view-model.md`.

## Component Hierarchy

Installing a module into a component makes its bindings available to other bindings in that component and in any child component beneath it. The hierarchy is:

- `SingletonComponent` (root)
  - `ActivityRetainedComponent`
    - `ActivityComponent`
    - `ViewModelComponent`
  - `ServiceComponent`

## Component Default Bindings

Each component comes with default bindings that Hilt can inject into your own bindings. These correspond to the general activity type, not a specific subclass, because Hilt uses one activity component definition to inject all activities (each activity gets its own instance of it).

| Component | Default bindings |
|---|---|
| `SingletonComponent` | `Application` |
| `ActivityRetainedComponent` | `Application` |
| `ViewModelComponent` | `SavedStateHandle` |
| `ActivityComponent` | `Application`, `Activity` |
| `ServiceComponent` | `Application`, `Service` |

The application context is also available via the `@ApplicationContext` qualifier:

```kotlin
class AnalyticsServiceImpl @Inject constructor(
  @ApplicationContext context: Context
) : AnalyticsService { ... }

// The Application binding is available without qualifiers.
class AnalyticsServiceImpl @Inject constructor(
  application: Application
) : AnalyticsService { ... }
```

The activity context is available via `@ActivityContext`:

```kotlin
class AnalyticsAdapter @Inject constructor(
  @ActivityContext context: Context
) { ... }

// The Activity binding is available without qualifiers.
class AnalyticsAdapter @Inject constructor(
  activity: ComponentActivity
) { ... }
```
