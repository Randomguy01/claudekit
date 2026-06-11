---
name: hilt
description: >
  Set up and use Hilt for dependency injection in an Android app. Use this skill
  when the user works with Hilt or Dagger-based DI on Android — annotating the
  Application with @HiltAndroidApp, injecting into activities/fragments/services
  with @AndroidEntryPoint, writing @Module bindings with @Binds/@Provides,
  qualifiers, component scopes, multi-module setups, injecting ViewModels
  (@HiltViewModel) and using them from Compose or Navigation, WorkManager
  injection, or testing Hilt code. Applies even when the user doesn't say
  "Hilt" by name — e.g. "wire up dependency injection on Android," "@Inject /
  @Module won't compile," "provide a Retrofit/OkHttp/Room instance to my
  ViewModel," or "swap a fake binding in an instrumented test." Skip for
  manual/constructor DI without a framework, plain Dagger on non-Android
  platforms, or DI on other platforms entirely.
---

# Hilt

Hilt is a dependency injection (DI) library for Android that reduces the boilerplate of doing manual DI by hand. Instead of constructing every class and its dependencies yourself and managing containers to reuse them, Hilt provides a container for every Android class in your project and manages those containers' lifecycles automatically.

Hilt is built on top of [Dagger](https://developer.android.com/training/dependency-injection/dagger-basics), so it inherits Dagger's compile-time correctness, runtime performance, scalability, and Android Studio tooling. It is the officially recommended DI solution for Android, optimized for Jetpack Compose and single-activity architectures.

This skill is a router. Decide what the task needs, then read the matching reference file before writing or reviewing code. Each `references/*.md` file is a task guide.

## Reference guides (`references/`)

### Setup

- New to Hilt or adding it to a project → `references/install.md`
- Multi-module / feature-module project (`:feature` modules, dynamic feature modules) → `references/multi-module.md`

### Core building blocks

- Annotate the `Application` and inject into Android classes (`@HiltAndroidApp`, `@AndroidEntryPoint`, `@Inject`, `@EntryPoint`) → `references/dependency-injection.md`
- Provide bindings Hilt can't construct itself — interfaces, third-party types, qualifiers (`@Module`, `@Binds`, `@Provides`, `@Qualifier`) → `references/modules.md`
- Understand which component to `@InstallIn`, and scopes/lifetimes (`SingletonComponent`, `ActivityComponent`, `@Singleton`, `@ActivityScoped`, …) → `references/components.md`

### Jetpack integrations

- Inject a `ViewModel` (`@HiltViewModel`, `@ViewModelScoped`, assisted injection) and use it from Compose (`hiltViewModel()`) → `references/view-model.md`
- Scope a `ViewModel` to a Navigation graph / inject into a navigation back stack → `references/navigation.md`
- Inject a `Worker` / WorkManager (`@HiltWorker`, `HiltWorkerFactory`) → `references/work.md`

### Quality

- Test Hilt code (unit tests, instrumented `@HiltAndroidTest`, replacing bindings with `@BindValue` / `@TestInstallIn`) → `references/testing.md`

## API references (`api/`)

The `references/` guides above are the task-oriented entry points. For the exact contract of a single annotation, interface, or class — its declaration, elements/methods, and defaults — read the matching file under `api/`. Each type has its own file whose name is the kebab-case form of the type name (`@HiltAndroidApp` → `hilt-android-app.md`, `@AndroidEntryPoint` → `android-entry-point.md`); nested types join parent and child (`Component.Builder` → `component-builder.md`). Every package lives in its own sibling directory named for its dotted package — run `ls api/` to see them and `ls api/<package>/` for the types within one.

These come from the [Dagger Javadoc](https://dagger.dev/api/latest/), so declarations and code examples are Java (not Kotlin).

Some primary types to start from:

- `api/dagger.hilt.android/hilt-android-app.md`, `api/dagger.hilt.android/android-entry-point.md` — mark the `Application` and the Android classes Hilt injects into
- `api/dagger/module.md`, `api/dagger/binds.md`, `api/dagger/provides.md` — declare bindings
- `api/dagger.hilt/install-in.md`, `api/dagger.hilt.components/singleton-component.md` — choose where a module/binding lives
- `api/dagger.hilt.android.lifecycle/hilt-view-model.md` — inject a `ViewModel`
- `api/dagger.hilt.android.testing/hilt-android-test.md`, `api/dagger.hilt.android.testing/bind-value.md` — instrumented Hilt tests

The `api/` tree covers these packages, each in its own directory:

- `api/dagger/` — Dagger core (`@Module`, `@Binds`, `@Provides`, `@Component`, `@Subcomponent`, `Lazy`, `MembersInjector`, …).
- `api/dagger.assisted/` — assisted injection (`@Assisted`, `@AssistedInject`, `@AssistedFactory`).
- `api/dagger.multibindings/` — multibinding (`@IntoSet`, `@IntoMap`, `@ElementsIntoSet`, map-key annotations).
- `api/dagger.hilt/` — Hilt core (`@InstallIn`, `@EntryPoint`, `EntryPoints`, `@DefineComponent`, …).
- `api/dagger.hilt.components/` — `SingletonComponent`.
- `api/dagger.hilt.android/` — Android entry points and lifecycles (`@HiltAndroidApp`, `@AndroidEntryPoint`, `ActivityRetainedLifecycle`, …).
- `api/dagger.hilt.android.components/` — the generated Android component interfaces (`ActivityComponent`, `FragmentComponent`, …).
- `api/dagger.hilt.android.lifecycle/` — `@HiltViewModel`, `RetainedLifecycle`.
- `api/dagger.hilt.android.scopes/` — scope annotations (`@ActivityScoped`, `@ViewModelScoped`, …).
- `api/dagger.hilt.android.qualifiers/` — `@ApplicationContext`, `@ActivityContext`.
- `api/dagger.hilt.android.migration/` — Dagger-interop helpers (`@CustomInject`, `@OptionalInject`).
- `api/dagger.hilt.migration/` — `@AliasOf`, `@DisableInstallInCheck`.
- `api/dagger.hilt.testing/` — `@TestInstallIn`.
- `api/dagger.hilt.android.testing/` — Android test helpers (`@HiltAndroidTest`, `HiltAndroidRule`, `@BindValue`, `@UninstallModules`, …).

## Hilt and Dagger

Hilt's goals are to create a standard set of components and scopes (easing setup, readability, and code sharing across apps) and to make it easy to provision different bindings for different build types (test, debug, release).

Because the Android OS instantiates many of its own framework classes, using Dagger directly on Android requires a lot of boilerplate. Hilt removes most of it by automatically generating:

- **Components** that integrate Android framework classes with Dagger.
- **Scope annotations** for those generated components.
- **Predefined bindings** for Android classes such as `Application` and `Activity`.
- **Predefined qualifiers** for `@ApplicationContext` and `@ActivityContext`.

Dagger and Hilt code can coexist in the same codebase, but in most cases it is best to let Hilt manage all Dagger usage on Android. To migrate an existing Dagger project, see the [Dagger-to-Hilt migration guide](https://dagger.dev/hilt/migration-guide).
