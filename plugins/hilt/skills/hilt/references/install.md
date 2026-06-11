# Installing Hilt

## Latest Version

Run [versions.sh](../scripts/versions.sh) to get the latest stable version of an artifact group, or `versions.sh --all <artifact>` to list every published version. Default to the latest stable version unless instructed otherwise.

There are three independent version lines — query each separately:

- `versions.sh hilt` — the Dagger Hilt artifacts (`com.google.dagger:*`).
- `versions.sh hilt-plugin` — the `com.google.dagger.hilt.android` Gradle plugin.
- `versions.sh androidx-hilt` — the AndroidX Hilt Jetpack extensions (`androidx.hilt:*`), versioned independently of the Dagger artifacts.
- `versions.sh ksp` — the `com.google.devtools.ksp` Gradle plugin (its version tracks the Kotlin version, so pick the entry matching your Kotlin version).

## Plugins

Required, in the **root** `build.gradle`, declared but not applied:
- `com.google.dagger.hilt.android` — add with `apply false`

Required, in the **app** `build.gradle`:
- `com.google.devtools.ksp`
- `com.google.dagger.hilt.android`

## Dependencies (app-level)

Required:
- `implementation("com.google.dagger:hilt-android")`
- `ksp("com.google.dagger:hilt-compiler")`

> [!NOTE]
> Hilt requires Java 17 (also required by Jetpack Compose). Set both `sourceCompatibility` and `targetCompatibility` to `JavaVersion.VERSION_17` in the app module's `compileOptions`.

Optional — Jetpack integrations (`androidx.hilt:*`, use the `androidx-hilt` version line):
- Compose / Navigation ViewModels (`hiltViewModel()`, nav-graph scoping): `androidx.hilt:hilt-navigation-compose` — see `view-model.md` and `navigation.md`
- Navigation ViewModels in the Fragment/View world: `androidx.hilt:hilt-navigation-fragment` — see `navigation.md`
- WorkManager (`@HiltWorker`): `androidx.hilt:hilt-work` plus `ksp("androidx.hilt:hilt-compiler")` — see `work.md`

> [!NOTE]
> In androidx.hilt 1.3.0+ the core `hiltViewModel()` lives in `androidx.hilt:hilt-lifecycle-viewmodel-compose`; `hilt-navigation-compose` depends on it and adds the navigation-specific helpers, so adding `hilt-navigation-compose` is enough for both. Use `hilt-lifecycle-viewmodel-compose` directly only if you need `hiltViewModel()` without Navigation Compose.

Optional — testing (`com.google.dagger:*`, use the `hilt` version line):
- `androidTestImplementation("com.google.dagger:hilt-android-testing")` plus `kspAndroidTest("com.google.dagger:hilt-compiler")` for instrumented tests
- `testImplementation("com.google.dagger:hilt-android-testing")` plus `kspTest("com.google.dagger:hilt-compiler")` for Robolectric unit tests
- See `testing.md`

## Instructions

Apply the required plugins and install the required dependencies, set Java 17, then determine whether any optional Jetpack integration or testing dependencies are necessary.
