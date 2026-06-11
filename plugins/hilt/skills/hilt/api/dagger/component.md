# API Reference

> Last updated 2026-06-11

# Component

> Since 2.0

```java
@Retention(RUNTIME)
@Target(TYPE)
@Documented
public @interface Component
```

Annotates an interface or abstract class for which a fully-formed, dependency-injected implementation is to be generated from a set of [modules](module.md). The generated class has the name of the type annotated with `@Component` prepended with `Dagger`. For example, `@Component interface MyComponent {...}` generates `DaggerMyComponent`.

## Component methods

Every type annotated with `@Component` must contain at least one abstract component method, which is either a provision method or a members-injection method.

**Provision methods** have no parameters and return an injected or provided type, optionally wrapped or qualified:

```java
SomeType getSomeType();
Set<SomeType> getSomeTypes();
@PortNumber int getPortNumber();
```

They may also return a `Provider` or [`Lazy`](lazy.md) to control provision semantics:

```java
Provider<SomeType> getSomeTypeProvider();
Lazy<SomeType> getLazySomeType();
```

**Members-injection methods** take the injected type as their single parameter and inject its `@Inject`-annotated fields and methods, returning either `void` or the parameter:

```java
void injectSomeType(SomeType someType);
SomeType injectAndReturnSomeType(SomeType someType);
```

A method returning a [`MembersInjector`](members-injector.md) does equivalent work:

```java
MembersInjector<SomeType> getSomeTypeMembersInjector();
```

When a members-injection method or `MembersInjector` is for a supertype, only members of the supertype and its supertypes are injected; members declared on subtypes are not.

## Instantiation

Components are instantiated with a generated builder or factory. If the component declares a nested [`@Component.Builder`](component-builder.md) or [`@Component.Factory`](component-factory.md), Dagger implements it; otherwise Dagger generates a default builder with a setter for each module and dependency, named in lower camel case. The generated component exposes a static `builder()` or `factory()` method:

```java
MyComponent component = DaggerMyComponent.builder()
    .otherComponent(otherComponent)
    .flagsModule(new FlagsModule(args))
    .build();
```

```java
MyComponent component = DaggerMyComponent.factory()
    .create(otherComponent, new FlagsModule(args), new MyApplicationModule());
```

For a component with no dependencies and only no-arg modules, a static `create()` method is generated as well.

## Scope

A component may carry scope annotations that constrain the lifetimes of the objects it provides. The implementation guarantees a scoped binding is provisioned at most once per component instance:

```java
@Singleton @Component
interface MyApplicationComponent {
  // Only unscoped or @Singleton bindings are allowed.
}
```

## Subcomponents and dependencies

A [`@Subcomponent`](subcomponent.md) inherits and extends the parent's entire binding graph; it is associated with its parent either through `Module.subcomponents()` or through a factory method on the parent:

```java
@Singleton @Component
interface ApplicationComponent {
  RequestComponent newRequestComponent(RequestModule requestModule);
}
```

A **component dependency**, by contrast, exposes only the bindings declared as provision methods on the dependency type, keeping the two components loosely coupled.

## Nested Types

| Type | Summary |
|------|---------|
| [`Component.Builder`](component-builder.md) | A builder for a component. |
| [`Component.Factory`](component-factory.md) | A factory for a component. |

## Elements

### modules

```java
Class<?>[] modules default {}
```

A list of classes annotated with [`@Module`](module.md) whose bindings are used to generate the component implementation. Through `Module.includes()` the full set of modules used may be larger than those listed here.

### dependencies

```java
Class<?>[] dependencies default {}
```

A list of types that are to be used as component dependencies.
</content>
