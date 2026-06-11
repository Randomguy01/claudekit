# API Reference

> Last updated 2026-06-11

# Component.Builder

```java
@Retention(RUNTIME)
@Target(TYPE)
@Documented
public static @interface Component.Builder
```

A builder for a [component](component.md). A component may declare at most one nested `static abstract class` or `interface` annotated with `@Component.Builder`, and Dagger generates its implementation. A component may not have both a `@Component.Builder` and a [`@Component.Factory`](component-factory.md).

A `@Component.Builder` type must follow these rules:

- exactly one abstract no-argument **build method** returning the component type or a supertype of it.
- an abstract setter method for each component dependency.
- an abstract setter method for each non-abstract module with non-static binding methods, unless Dagger can instantiate it itself with a visible no-argument constructor.
- setter methods for modules that Dagger can instantiate, or does not need, are optional.
- optional `@BindsInstance`-annotated setters that bind the passed instance within the component.
- each setter must take a single argument and return `void`, the builder type, or a supertype of the builder.
- non-abstract methods are allowed but ignored during validation and generation.

```java
@Component(modules = {BackendModule.class, FrontendModule.class})
interface MyComponent {
  MyWidget myWidget();

  @Component.Builder
  interface Builder {
    Builder backendModule(BackendModule bm);
    Builder frontendModule(FrontendModule fm);
    @BindsInstance
    Builder foo(Foo foo);
    MyComponent build();
  }
}
```
</content>
