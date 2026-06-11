# Injecting Dependencies with Hilt

## Hilt Application Class

Every app that uses Hilt must contain an [`Application`](https://developer.android.com/reference/kotlin/android/app/Application) class annotated with `@HiltAndroidApp`. This annotation triggers Hilt's code generation, including a base class that serves as the application-level dependency container.

```kotlin
@HiltAndroidApp
class ExampleApplication : Application() { ... }
```

The generated component is attached to the `Application` object's lifecycle and provides dependencies to it. It is also the app's parent component, so every other component can access the dependencies it provides.

## Inject Dependencies into Android Classes

Once Hilt is set up in the `Application` class, it can provide dependencies to other Android classes annotated with `@AndroidEntryPoint`:

```kotlin
@AndroidEntryPoint
class ExampleActivity : ComponentActivity() { ... }
```

Hilt supports the following Android classes:

- `Application` (via `@HiltAndroidApp`)
- `ViewModel` (via `@HiltViewModel` — see `view-model.md`)
- `Activity`
- `Service`
- `BroadcastReceiver`

> [!NOTE]
> Hilt also supports `Fragment` and `View` (the latter via `@WithFragmentBindings`), but with a Compose-first, single-activity architecture you rarely need them, so they aren't covered in these guides. Their components and scopes are documented under `api/dagger.hilt.android.components/` and `api/dagger.hilt.android.scopes/`.

In Compose, don't annotate individual composables. Annotate the root `ComponentActivity` with `@AndroidEntryPoint` — it serves as the single DI entry point for the entire UI hierarchy, so you can access Hilt-injected ViewModels directly within composable functions.

> [!NOTE]
> Hilt only supports activities that extend [`ComponentActivity`](https://developer.android.com/reference/kotlin/androidx/activity/ComponentActivity), such as [`AppCompatActivity`](https://developer.android.com/reference/kotlin/androidx/appcompat/app/AppCompatActivity).

`@AndroidEntryPoint` generates an individual Hilt component for each annotated Android class. These components receive dependencies from their parent components as described in `components.md`.

To obtain dependencies from a component, perform field injection with `@Inject`:

```kotlin
@AndroidEntryPoint
class ExampleActivity : ComponentActivity() {

  @Inject lateinit var analytics: AnalyticsAdapter
  ...
}
```

> [!WARNING]
> Hilt-injected fields cannot be `private`. Injecting a private field results in a compilation error.

A Hilt-injected class can have base classes that also use injection. Those base classes don't need `@AndroidEntryPoint` if they're abstract.

The lifecycle callback in which each Android class is injected is listed under Component lifetimes in `components.md`.

## Define Hilt Bindings

To perform field injection, Hilt must know how to provide instances of each dependency from the corresponding component. A *binding* holds the information needed to provide instances of a type.

The simplest way to supply a binding is *constructor injection*: annotate a class's constructor with `@Inject` to tell Hilt how to construct it.

```kotlin
class AnalyticsAdapter @Inject constructor(
  private val service: AnalyticsService
) { ... }
```

The parameters of an `@Inject` constructor are that class's dependencies. Here `AnalyticsAdapter` depends on `AnalyticsService`, so Hilt must also know how to provide `AnalyticsService`.

> [!NOTE]
> At build time, Hilt generates Dagger components for Android classes. Dagger then walks your code to build and validate the dependency graph (no unsatisfied dependencies, no cycles) and generates the classes it uses at runtime to construct objects and their dependencies.

Some types can't be constructor-injected — interfaces, types you don't own, or types built with a builder. For those, supply binding information through a Hilt module instead. See `modules.md`.

## Inject Dependencies in Classes Not Supported by Hilt

In Compose, the standard pattern is to inject into a `@HiltViewModel` via constructor injection and access it with `hiltViewModel()` inside a composable. But Hilt only supports the common Android classes, so you may still hit an unsupported class that needs field injection.

For those, create an *entry point* with `@EntryPoint`. An entry point is the boundary between Hilt-managed code and code that isn't — the point where non-Hilt code first enters the dependency graph.

Hilt doesn't directly support [content providers](https://developer.android.com/guide/topics/providers/content-providers), for example. To let one use Hilt, define an `@EntryPoint`-annotated interface declaring an accessor for each binding type you need (with qualifiers where applicable), and add `@InstallIn` to specify the component to install it in:

```kotlin
class ExampleContentProvider : ContentProvider() {

  @EntryPoint
  @InstallIn(SingletonComponent::class)
  interface ExampleContentProviderEntryPoint {
    fun analyticsService(): AnalyticsService
  }

  ...
}
```

To access the entry point, call the matching static method on `EntryPointAccessors`, passing either the component instance or the `@AndroidEntryPoint` object that holds it. The component you pass and the `EntryPointAccessors` method must both match the Android class named in the entry point's `@InstallIn`:

```kotlin
class ExampleContentProvider : ContentProvider() {
  ...

  override fun query(...): Cursor {
    val appContext = context?.applicationContext ?: throw IllegalStateException()
    val hiltEntryPoint =
      EntryPointAccessors.fromApplication(appContext, ExampleContentProviderEntryPoint::class.java)

    val analyticsService = hiltEntryPoint.analyticsService()
    ...
  }
}
```

This example retrieves the entry point from the `ApplicationContext` because it is installed in `SingletonComponent`. A binding in `ActivityComponent` would instead be retrieved using the `ActivityContext`.
