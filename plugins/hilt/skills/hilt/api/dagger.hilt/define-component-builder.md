# API Reference

> Last updated 2026-06-11

# DefineComponent.Builder

```java
@Retention(CLASS)
@Target(TYPE)
public static @interface DefineComponent.Builder
```

Defines a builder for a Hilt component declared with [`@DefineComponent`](define-component.md). The annotated interface declares any seed-data setters along with a no-argument build method that returns the component type:

```java
@DefineComponent.Builder
interface ParentComponentBuilder {
  ParentComponentBuilder seedData(SeedData seed);
  ParentComponent build();
}
```
</content>
