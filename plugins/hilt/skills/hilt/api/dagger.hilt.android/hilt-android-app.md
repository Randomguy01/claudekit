# API Reference

> Last updated 2026-06-11

# HiltAndroidApp

```java
@Retention(RUNTIME)
@Target(TYPE)
public @interface HiltAndroidApp
```

Annotation for marking the `Application` class where the Dagger components should be generated. Every module and entry point that needs to be installed must be a transitive compile-time dependency of the annotated application. Like [`@AndroidEntryPoint`](android-entry-point.md), it generates a `Hilt_<ClassName>` base class — but it applies only to the application and triggers generation of the Hilt component tree.

With the Hilt Gradle plugin (base class inferred):

```java
@HiltAndroidApp
public final class FooApplication extends Application {
  @Inject Foo foo;

  @Override
  public void onCreate() {
    super.onCreate();  // foo injected in super.onCreate()
  }
}
```

Without the plugin (extend the generated base class):

```java
@HiltAndroidApp(Application.class)
public final class FooApplication extends Hilt_FooApplication {
  @Inject Foo foo;

  @Override
  public void onCreate() {
    super.onCreate();  // foo injected in super.onCreate()
  }
}
```

## Elements

### value

```java
Class<?> value default Void.class
```

The base class for the generated Hilt application. Inferred from the current superclass when using the Hilt Gradle plugin.
</content>
