# API Reference

> Last updated 2026-06-11

# BindElementsIntoSet

```java
@Retention(CLASS)
@Target(FIELD)
public @interface BindElementsIntoSet
```

An annotation that can be used on a test field to contribute the value into the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md) as an [`@ElementsIntoSet`](../dagger.multibindings/elements-into-set.md) for the given type. The annotated set becomes available throughout the test application, functionally equivalent to installing a [`@Module`](../dagger/module.md) with an `@Provides` method annotated with `@ElementsIntoSet`. See [`@BindValueIntoSet`](bind-value-into-set.md) to instead gather individual elements into a single set.
