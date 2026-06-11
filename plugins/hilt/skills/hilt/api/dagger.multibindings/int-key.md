# API Reference

> Last updated 2026-06-11

# IntKey

```java
@Documented
@Target({METHOD, FIELD, TYPE})
@Retention(RUNTIME)
@MapKey
public @interface IntKey
```

A [`@MapKey`](../dagger/map-key.md) annotation for maps with `int` keys, used together with [`@IntoMap`](into-map.md).

## Elements

### value

```java
int value
```

The `int` used as the map key.
