# API Reference

> Last updated 2026-06-11

# MapKey

```java
@Documented
@Target(ANNOTATION_TYPE)
@Retention(RUNTIME)
public @interface MapKey
```

Identifies annotation types that are used to associate keys with values returned by provider methods in order to compose a map. Every provider method annotated with [`@Provides`](provides.md) and `@IntoMap` must also have an annotation whose type is itself annotated with `@MapKey`.

With `unwrapValue = true` (the default), the single member of the key annotation is used as the map key:

```java
@MapKey
@interface SomeEnumKey {
  SomeEnum value();
}

@Module
class SomeModule {
  @Provides
  @IntoMap
  @SomeEnumKey(SomeEnum.FOO)
  Integer provideFooValue() {
    return 2;
  }
}

class SomeInjectedType {
  @Inject
  SomeInjectedType(Map<SomeEnum, Integer> map) {
    assert map.get(SomeEnum.FOO) == 2;
  }
}
```

With `unwrapValue = false`, the annotation instance itself is used as the map key, and Dagger generates an implementation of the annotation for use as the lookup key:

```java
@MapKey(unwrapValue = false)
@interface MyMapKey {
  String someString();
  MyEnum someEnum();
}

@Module
class SomeModule {
  @Provides
  @IntoMap
  @MyMapKey(someString = "foo", someEnum = BAR)
  Integer provideFooBarValue() {
    return 2;
  }
}

class SomeInjectedType {
  @Inject
  SomeInjectedType(Map<MyMapKey, Integer> map) {
    assert map.get(new MyMapKeyImpl("foo", MyEnum.BAR)) == 2;
  }
}
```

## Elements

### unwrapValue

```java
boolean unwrapValue default true
```

`true` to use the value of the single member of the annotated annotation as the map key; `false` to use the annotation instance itself as the map key. When `true`, the single member may not be an array.
</content>
