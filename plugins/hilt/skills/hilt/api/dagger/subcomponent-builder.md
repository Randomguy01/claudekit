# API Reference

> Last updated 2026-06-11

# Subcomponent.Builder

```java
@Retention(RUNTIME)
@Target(TYPE)
@Documented
public static @interface Subcomponent.Builder
```

A builder for a [subcomponent](subcomponent.md). It follows the same rules as [`@Component.Builder`](component-builder.md), except that it must be nested within a type annotated with [`@Subcomponent`](subcomponent.md) rather than [`@Component`](component.md).

When a subcomponent declares a builder, the parent component automatically gains a binding for that builder type, so it can be injected or returned (directly or as a `Provider`) like any other binding.
