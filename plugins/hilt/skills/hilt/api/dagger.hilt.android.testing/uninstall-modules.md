# API Reference

> Last updated 2026-06-11

# UninstallModules

```java
@Target(ElementType.TYPE)
public @interface UninstallModules
```

An annotation used to uninstall modules that have previously been installed with [`@InstallIn`](../dagger.hilt/install-in.md). This is useful in tests to replace production bindings with test implementations. The classes listed must be annotated with both [`@Module`](../dagger/module.md) and `@InstallIn`.

A module that is included as part of another module's [`Module.includes`](../dagger/module.md) cannot be truly uninstalled until the including module is also uninstalled.

```java
@HiltAndroidTest
@UninstallModules({ProdFooModule.class})
public class MyTest {
  @Module
  @InstallIn(SingletonComponent.class)
  interface FakeFooModule {
    @Binds Foo bindFoo(FakeFoo fakeFoo);
  }
}
```

## Elements

### value

```java
Class<?>[] value default {}
```

Returns the list of classes to uninstall. These classes must be annotated with both `@Module` and `@InstallIn`.
