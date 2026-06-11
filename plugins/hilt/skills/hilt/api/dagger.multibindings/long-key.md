# API Reference

> Last updated 2026-06-11

# LongKey

```java
@Documented
@Target({METHOD, FIELD, TYPE})
@Retention(RUNTIME)
@MapKey
public @interface LongKey
```

A [`@MapKey`](../dagger/map-key.md) annotation for maps with `long` keys, used together with [`@IntoMap`](into-map.md).

## Elements

### value

```java
long value
```

The `long` used as the map key.
