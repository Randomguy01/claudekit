# API Reference

> Last updated 2026-06-11

# Multibinds

```java
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface Multibinds
```

Annotates `abstract` [`@Module`](../dagger/module.md) methods that declare multibindings. Declare a multibound set or map by annotating an `abstract` method that returns the set or map you want to declare. You do not need `@Multibinds` for a set or map that has at least one contribution, but you must declare one that may be empty.

```java
@Module abstract class MyModule {
  @Multibinds abstract Set<Foo> aSet();
  @Multibinds abstract @MyQualifier Set<Foo> aQualifiedSet();
  @Multibinds abstract Map<String, Foo> aMap();
  @Multibinds abstract @MyQualifier Map<String, Foo> aQualifiedMap();

  @Provides
  static Object usesMultibindings(Set<Foo> set, @MyQualifier Map<String, Foo> map) {
    return …
  }
}
```
</content>
