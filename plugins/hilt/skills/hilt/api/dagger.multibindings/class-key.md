# API Reference

> Last updated 2026-06-11

# ClassKey

```java
@Documented
@Target({METHOD, FIELD, TYPE})
@Retention(RUNTIME)
@MapKey
public @interface ClassKey
```

A [`@MapKey`](../dagger/map-key.md) annotation for maps with `Class<?>` keys, used together with [`@IntoMap`](into-map.md). When the keys can be constrained to a bounded type, prefer a custom map-key annotation with a member type like `Class<? extends Something>`.

## Elements

### value

```java
Class<?> value
```

The `Class` used as the map key.
</content>
