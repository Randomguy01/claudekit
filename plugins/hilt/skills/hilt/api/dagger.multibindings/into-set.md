# API Reference

> Last updated 2026-06-11

# IntoSet

```java
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface IntoSet
```

The returned value is contributed to a `Set` multibinding. Applied to a [`@Provides`](../dagger/provides.md) (or [`@Binds`](../dagger/binds.md)) method, the method's return type `T` becomes an element of an injectable `Set<T>`. Multiple modules may each contribute, and the resulting set is immutable. Dagger supplies the method's parameters as dependencies. See the [set multibindings](https://dagger.dev/multibindings#set-multibindings) guide.
</content>
