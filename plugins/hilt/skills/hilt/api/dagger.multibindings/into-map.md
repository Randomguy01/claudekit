# API Reference

> Last updated 2026-06-11

# IntoMap

```java
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface IntoMap
```

The returned value is contributed to a `Map` multibinding. Applied to a [`@Provides`](../dagger/provides.md) (or [`@Binds`](../dagger/binds.md)) method whose return type is the value type `V`, it adds one entry to an injectable `Map<K, V>` (also injectable as `Map<K, Provider<V>>`). The method must also carry a map-key annotation — one of the built-in keys ([`@ClassKey`](class-key.md), [`@StringKey`](string-key.md), [`@IntKey`](int-key.md), [`@LongKey`](long-key.md), [`@LazyClassKey`](lazy-class-key.md)) or a custom annotation annotated with [`@MapKey`](../dagger/map-key.md). The accumulated map is immutable. See the [map multibindings](https://dagger.dev/multibindings#map-multibindings) guide.
