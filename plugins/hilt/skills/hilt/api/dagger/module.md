# API Reference

> Last updated 2026-06-11

# Module

```java
@Documented
@Retention(RUNTIME)
@Target(TYPE)
public @interface Module
```

Annotates a class that contributes to the object graph. A `@Module`-annotated class provides bindings — through [`@Provides`](provides.md) and [`@Binds`](binds.md) methods — that Dagger uses to construct and inject dependencies.

## Elements

### includes

```java
Class<?>[] includes default {}
```

Additional `@Module`-annotated classes from which this module is composed. The de-duplicated contributions of the modules in `includes`, and of their inclusions recursively, are all contributed to the object graph.

### subcomponents

```java
Class<?>[] subcomponents default {}
```

> Since 2.7 · @Beta

Any [`@Subcomponent`](subcomponent.md)- or `@ProductionSubcomponent`-annotated classes which should be children of the component in which this module is installed. A subcomponent may be listed in more than one module within a single component.
</content>
