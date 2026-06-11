# API Reference

> Last updated 2026-06-11

# BindsInstance

```java
@Documented
@Retention(RUNTIME)
@Target({METHOD, PARAMETER})
@Beta
public @interface BindsInstance
```

Marks a method on a [component builder](component-builder.md) or a parameter on a [component factory](component-factory.md) as binding an instance to some key within the component. This lets clients pass in their own instances to be injected within the component.

On a builder:

```java
@Component.Builder
interface Builder {
  @BindsInstance Builder foo(Foo foo);
  @BindsInstance Builder bar(@Blue Bar bar);
  ...
}
```

On a factory:

```java
@Component.Factory
interface Factory {
  MyComponent newMyComponent(
      @BindsInstance Foo foo,
      @BindsInstance @Blue Bar bar);
}
```

Each builder method must accept a single parameter. Arguments may not be `null` unless the parameter is annotated `@Nullable`; for builders, a non-`@Nullable` instance must be set before `build()` is called. Primitives may not be marked `@Nullable`. Binding an instance is often more efficient than passing a module instance that provides it.
</content>
