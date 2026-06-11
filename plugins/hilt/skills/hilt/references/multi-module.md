# Hilt in Multi-Module Apps

Hilt's code generation needs access to every Gradle module that uses Hilt. The Gradle module that compiles your [`Application`](https://developer.android.com/reference/android/app/Application) class must have all Hilt modules and constructor-injected classes in its transitive dependencies.

If your project is composed of regular Gradle modules, use Hilt exactly as described in `dependency-injection.md` and `modules.md`. This does **not** hold for apps with [feature modules](https://developer.android.com/guide/app-bundle/dynamic-delivery#customize_delivery).

> [!NOTE]
> For deep multi-module projects, consider enabling the `enableExperimentalClasspathAggregation` flag in your `build.gradle`. See the [Hilt classpath aggregation docs](https://dagger.dev/hilt/gradle-setup#classpath-aggregation).

## Hilt in Feature Modules

In feature modules the usual dependency direction is inverted, so Hilt can't process annotations there. Use [Dagger](https://developer.android.com/training/dependency-injection/dagger-basics) with *component dependencies* instead:

1. Declare an `@EntryPoint` interface (see `dependency-injection.md`) in the `app` module — or any module Hilt can process — exposing the bindings the feature module needs.
2. Create a Dagger component that depends on that `@EntryPoint` interface.
3. Use Dagger as usual inside the feature module.

Suppose you add a `login` feature module implemented with a `LoginActivity`. It can only obtain bindings from the application component, and it needs an `OkHttpClient` with the `authInterceptor` binding.

First, in the `app` module, create an `@EntryPoint` interface installed in `SingletonComponent` exposing the bindings the `login` module needs:

```kotlin
// LoginModuleDependencies.kt — file in the app module.

@EntryPoint
@InstallIn(SingletonComponent::class)
interface LoginModuleDependencies {

  @AuthInterceptorOkHttpClient
  fun okHttpClient(): OkHttpClient
}
```

To field-inject in `LoginActivity`, create a Dagger component that depends on the `@EntryPoint` interface:

```kotlin
// LoginComponent.kt — file in the login module.

@Component(dependencies = [LoginModuleDependencies::class])
interface LoginComponent {

  fun inject(activity: LoginActivity)

  @Component.Builder
  interface Builder {
    fun context(@BindsInstance context: Context): Builder
    fun appDependencies(loginModuleDependencies: LoginModuleDependencies): Builder
    fun build(): LoginComponent
  }
}
```

With that in place, use Dagger as usual in the feature module. For example, consume a `SingletonComponent` binding as a dependency of a class:

```kotlin
// LoginAnalyticsAdapter.kt — file in the login module.

class LoginAnalyticsAdapter @Inject constructor(
  @AuthInterceptorOkHttpClient okHttpClient: OkHttpClient
) { ... }
```

To perform the field injection, build the Dagger component, supplying the `SingletonComponent` dependencies via `EntryPointAccessors.fromApplication` with the `applicationContext`:

```kotlin
// LoginActivity.kt — file in the login module.

class LoginActivity : AppCompatActivity() {

  @Inject
  lateinit var loginAnalyticsAdapter: LoginAnalyticsAdapter

  override fun onCreate(savedInstanceState: Bundle?) {
    DaggerLoginComponent.builder()
      .context(this)
      .appDependencies(
        EntryPointAccessors.fromApplication(
          applicationContext,
          LoginModuleDependencies::class.java
        )
      )
      .build()
      .inject(this)

    super.onCreate(savedInstanceState)
    ...
  }
}
```

For more on module dependencies in feature modules, see [Component dependencies with feature modules](https://developer.android.com/training/dependency-injection/dagger-multi-module#dagger-dfm) and [Using Dagger in Android apps](https://developer.android.com/training/dependency-injection/dagger-android).
