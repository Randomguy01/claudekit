# Hilt Modules

When a type can't be constructor-injected — it's an interface, it comes from a library you don't own, or it must be built with a builder — supply its binding information through a *Hilt module*.

A Hilt module is a class annotated with `@Module`. Annotate it with `@InstallIn` to tell Hilt which component (and therefore which Android class) the module is installed in. Bindings declared in a module are available in that component and all of its children — see `components.md`.

> [!NOTE]
> Hilt modules are not the same thing as [Gradle modules](https://developer.android.com/studio/projects#ApplicationModules).

> [!IMPORTANT]
> Hilt's code generation needs access to every Gradle module that uses Hilt. The Gradle module that compiles your `Application` class must therefore have all your Hilt modules and constructor-injected classes in its transitive dependencies.

## Inject Interface Instances with @Binds

When the dependency is an interface, you can't constructor-inject it. Declare an abstract function annotated with `@Binds` inside a module to tell Hilt which implementation to use:

- The return type is the interface being provided.
- The single parameter is the implementation to provide (which must itself be constructor-injectable).

```kotlin
interface AnalyticsService {
  fun analyticsMethods()
}

// Constructor-injected, so Hilt knows how to provide AnalyticsServiceImpl.
class AnalyticsServiceImpl @Inject constructor(
  ...
) : AnalyticsService { ... }

@Module
@InstallIn(ActivityComponent::class)
abstract class AnalyticsModule {

  @Binds
  abstract fun bindAnalyticsService(
    analyticsServiceImpl: AnalyticsServiceImpl
  ): AnalyticsService
}
```

`AnalyticsModule` is installed in `ActivityComponent`, so its bindings are available in all of the app's activities.

## Inject Instances with @Provides

When you don't own the type — it comes from an external library (such as [Retrofit](https://square.github.io/retrofit/), [`OkHttpClient`](https://square.github.io/okhttp/), or a [Room database](https://developer.android.com/topic/libraries/architecture/room)) or must be built with a builder — declare a function annotated with `@Provides`:

- The return type is the type being provided.
- The parameters are that type's dependencies.
- The body tells Hilt how to construct an instance; Hilt runs it every time it needs one.

```kotlin
@Module
@InstallIn(ActivityComponent::class)
object AnalyticsModule {

  @Provides
  fun provideAnalyticsService(
    // Potential dependencies of this type
  ): AnalyticsService {
    return Retrofit.Builder()
      .baseUrl("https://example.com")
      .build()
      .create(AnalyticsService::class.java)
  }
}
```

## Provide Multiple Bindings for the Same Type

When Hilt needs to provide different implementations of the *same* type, distinguish them with *qualifiers*. A qualifier is an annotation that identifies a specific binding when a type has more than one.

For example, to intercept calls to one service with one `OkHttpClient` interceptor and other services with a different interceptor, Hilt needs two `OkHttpClient` bindings. First, define the qualifiers:

```kotlin
@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class AuthInterceptorOkHttpClient

@Qualifier
@Retention(AnnotationRetention.BINARY)
annotation class OtherInterceptorOkHttpClient
```

Then provide an instance for each qualifier. Both functions return `OkHttpClient`, but the qualifiers mark them as distinct bindings:

```kotlin
@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

  @AuthInterceptorOkHttpClient
  @Provides
  fun provideAuthInterceptorOkHttpClient(
    authInterceptor: AuthInterceptor
  ): OkHttpClient {
    return OkHttpClient.Builder()
      .addInterceptor(authInterceptor)
      .build()
  }

  @OtherInterceptorOkHttpClient
  @Provides
  fun provideOtherInterceptorOkHttpClient(
    otherInterceptor: OtherInterceptor
  ): OkHttpClient {
    return OkHttpClient.Builder()
      .addInterceptor(otherInterceptor)
      .build()
  }
}
```

Inject the one you need by annotating the field or parameter with the matching qualifier:

```kotlin
// As a dependency of another @Provides binding.
@Module
@InstallIn(ActivityComponent::class)
object AnalyticsModule {

  @Provides
  fun provideAnalyticsService(
    @AuthInterceptorOkHttpClient okHttpClient: OkHttpClient
  ): AnalyticsService {
    return Retrofit.Builder()
      .baseUrl("https://example.com")
      .client(okHttpClient)
      .build()
      .create(AnalyticsService::class.java)
  }
}

// As a dependency of a constructor-injected class.
class ExampleServiceImpl @Inject constructor(
  @AuthInterceptorOkHttpClient private val okHttpClient: OkHttpClient
) : ...

// At field injection.
@AndroidEntryPoint
class ExampleActivity : ComponentActivity() {

  @AuthInterceptorOkHttpClient
  @Inject lateinit var okHttpClient: OkHttpClient
}
```

> [!TIP]
> Once a type has a qualifier, add qualifiers to every way of providing that type. Leaving the common implementation unqualified is error-prone and can cause Hilt to inject the wrong dependency.

## Predefined Qualifiers in Hilt

Hilt ships predefined qualifiers. Because you may need the `Context` of either the application or the activity, Hilt provides `@ApplicationContext` and `@ActivityContext`:

```kotlin
class AnalyticsAdapter @Inject constructor(
  @ActivityContext private val context: Context,
  private val service: AnalyticsService
) { ... }
```

For the other predefined bindings each component supplies, see Component default bindings in `components.md`.
