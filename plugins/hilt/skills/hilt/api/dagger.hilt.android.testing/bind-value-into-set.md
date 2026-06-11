# API Reference

> Last updated 2026-06-11

# BindValueIntoSet

```java
@Retention(CLASS)
@Target(FIELD)
public @interface BindValueIntoSet
```

An annotation that can be used on a test field to contribute the value into the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md) as an [`@IntoSet`](../dagger.multibindings/into-set.md) for the given type. Multiple annotated fields contribute their values to a single set available throughout the test application. See [`@BindElementsIntoSet`](bind-elements-into-set.md) to instead gather individual elements into one set.
