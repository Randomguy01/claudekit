# API Reference

> Last updated 2026-06-11

# BindValueIntoMap

```java
@Retention(CLASS)
@Target(FIELD)
public @interface BindValueIntoMap
```

An annotation that can be used on a test field to contribute the value into the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md) as an [`@IntoMap`](../dagger.multibindings/into-map.md) for the given type. The field must also carry a map key annotation. The resulting map is available for injection throughout the test application.
