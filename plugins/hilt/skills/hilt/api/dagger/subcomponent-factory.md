# API Reference

> Last updated 2026-06-11

# Subcomponent.Factory

> Since 2.22

```java
@Retention(RUNTIME)
@Target(TYPE)
@Documented
public static @interface Subcomponent.Factory
```

A factory for a [subcomponent](subcomponent.md). It follows the same rules as [`@Component.Factory`](component-factory.md), except that it must be nested within a type annotated with [`@Subcomponent`](subcomponent.md) rather than [`@Component`](component.md).

When a subcomponent declares a factory, the parent component automatically gains a binding for that factory type, so it can be injected or returned from a component method like any other binding.
