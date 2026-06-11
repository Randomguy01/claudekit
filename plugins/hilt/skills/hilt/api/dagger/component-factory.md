# API Reference

> Last updated 2026-06-11

# Component.Factory

> Since 2.22

```java
@Retention(RUNTIME)
@Target(TYPE)
@Documented
public static @interface Component.Factory
```

A factory for a [component](component.md). A component may declare at most one nested `static abstract class` or `interface` annotated with `@Component.Factory`, with a single abstract method that returns the component type or a supertype of it. Dagger generates the factory's implementation, and for a root component a static `factory()` method to obtain it. A component may not have both a `@Component.Factory` and a [`@Component.Builder`](component-builder.md).

The single abstract factory method must:

- return the component type or a supertype of it.
- include a parameter for each component dependency.
- include a parameter for each non-abstract module with non-static binding methods, unless Dagger can instantiate it with a visible no-argument constructor.
- parameters for modules that Dagger can instantiate, or does not need, are optional.
- may include `@BindsInstance`-annotated parameters that bind the passed instance within the component.

Non-abstract methods are allowed but ignored during generation.

```java
@Component(modules = {BackendModule.class, FrontendModule.class})
interface MyComponent {
  MyWidget myWidget();

  @Component.Factory
  interface Factory {
    MyComponent newMyComponent(
        BackendModule bm, FrontendModule fm, @BindsInstance Foo foo);
  }
}
```
</content>
