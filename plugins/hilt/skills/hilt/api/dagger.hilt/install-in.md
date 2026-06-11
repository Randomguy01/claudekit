# API Reference

> Last updated 2026-06-11

# InstallIn

```java
@Retention(CLASS)
@Target(TYPE)
public @interface InstallIn
```

An annotation that declares which component(s) the annotated class should be included in when Hilt generates the components. It applies to classes annotated with [`@Module`](../dagger/module.md) or [`@EntryPoint`](entry-point.md).

```java
@Module
@InstallIn(SingletonComponent.class)
public final class FooModule {
  @Provides
  static Foo provideFoo() {
    return new Foo();
  }
}
```

## Elements

### value

```java
Class<?>[] value
```

The Hilt component(s) into which the annotated module or entry point is installed. Required.
