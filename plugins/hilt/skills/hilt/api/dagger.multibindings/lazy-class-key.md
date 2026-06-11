# API Reference

> Last updated 2026-06-11

# LazyClassKey

```java
@Documented
@Target({METHOD, FIELD, TYPE})
@Retention(RUNTIME)
@MapKey
public @interface LazyClassKey
```

A [`@MapKey`](../dagger/map-key.md) annotation for maps with `Class<?>` keys, used together with [`@IntoMap`](into-map.md). Unlike [`@ClassKey`](class-key.md), Dagger generates a string representation of the class to use as the key under the hood, which avoids loading unused classes at runtime.

## Elements

### value

```java
Class<?> value
```

The `Class` used as the map key.
