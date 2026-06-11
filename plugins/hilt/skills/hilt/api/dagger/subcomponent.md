# API Reference

> Last updated 2026-06-11

# Subcomponent

> Since 2.0

```java
@Retention(RUNTIME)
@Target(TYPE)
@Documented
public @interface Subcomponent
```

A subcomponent that inherits the bindings from a parent [`@Component`](component.md) or `@Subcomponent`. The details of how to associate a subcomponent with a parent are described in the [`@Component`](component.md) documentation.

## Nested Types

| Type | Summary |
|------|---------|
| [`Subcomponent.Builder`](subcomponent-builder.md) | A builder for a subcomponent. |
| [`Subcomponent.Factory`](subcomponent-factory.md) | A factory for a subcomponent. |

## Elements

### modules

```java
Class<?>[] modules default {}
```

A list of classes annotated with [`@Module`](module.md) whose bindings are used to generate the subcomponent implementation. Through `Module.includes()` the full set of modules used may be larger than those listed here.
