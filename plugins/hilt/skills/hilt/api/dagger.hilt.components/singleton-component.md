# API Reference

> Last updated 2026-06-11

# SingletonComponent

```java
@Singleton
public interface SingletonComponent
```

A Hilt component for singleton bindings. It is the root of the Hilt component hierarchy, created with the [`@HiltAndroidApp`](../dagger.hilt.android/hilt-android-app.md) application and living for the entire lifetime of the app. Bindings scoped to it with `@Singleton` have a single instance per application. Modules and entry points installed with [`@InstallIn(SingletonComponent.class)`](../dagger.hilt/install-in.md) are available to every component below it.
</content>
