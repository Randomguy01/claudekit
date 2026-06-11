# API Reference

> Last updated 2026-06-11

# StringKey

```java
@Documented
@Target({METHOD, FIELD, TYPE})
@Retention(RUNTIME)
@MapKey
public @interface StringKey
```

A [`@MapKey`](../dagger/map-key.md) annotation for maps with `String` keys, used together with [`@IntoMap`](into-map.md).

## Elements

### value

```java
String value
```

The `String` used as the map key.
</content>
