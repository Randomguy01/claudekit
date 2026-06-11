# API Reference

> Last updated 2026-06-11

# TestInstallIn

```java
@Retention(CLASS)
@Target(TYPE)
public @interface TestInstallIn
```

An annotation that replaces one or more [`@InstallIn`](../dagger.hilt/install-in.md) modules with the annotated module in tests. The annotated class must also be a [`@Module`](../dagger/module.md). Use it to swap a production module for a fake across an entire test source set (as opposed to `@UninstallModules`, which uninstalls per-test).

```java
@Module
@TestInstallIn(components = SingletonComponent.class, replaces = FooModule.class)
public final class FakeFooModule {
  @Provides
  static Foo provideFoo() {
    return new FakeFoo();
  }
}
```

Here `FakeFooModule` replaces `FooModule` and is installed into the same component for tests.

## Elements

### components

```java
Class<?>[] components
```

The Hilt component(s) the annotated module is installed in (as with [`@InstallIn`](../dagger.hilt/install-in.md)).

### replaces

```java
Class<?>[] replaces
```

The [`@InstallIn`](../dagger.hilt/install-in.md) module(s) that the annotated module replaces in tests.
