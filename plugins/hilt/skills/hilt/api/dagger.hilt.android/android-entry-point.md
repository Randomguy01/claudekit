# API Reference

> Last updated 2026-06-11

# AndroidEntryPoint

```java
@Target(TYPE)
public @interface AndroidEntryPoint
```

Marks an Android component class to be set up for injection with the standard Hilt Dagger Android components. Supported on activities, fragments, views, services, and broadcast receivers. Hilt generates a base class named `Hilt_<ClassName>` that performs members injection and manages the component at the right point in the Android lifecycle.

With the Hilt Gradle plugin the base class is inferred from the current superclass, so the annotation needs no argument:

```java
@AndroidEntryPoint
public final class FooActivity extends FragmentActivity {
  @Inject Foo foo;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);  // foo injected here
  }
}
```

Without the plugin, name the base class in the annotation and extend the generated `Hilt_` class directly:

```java
@AndroidEntryPoint(FragmentActivity.class)
public final class FooActivity extends Hilt_FooActivity {
  @Inject Foo foo;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);  // foo injected here
  }
}
```

## Elements

### value

```java
Class<?> value default Void.class
```

The base class for the generated Hilt class. Optional when using the Hilt Gradle plugin, where it is inferred from the current superclass.
