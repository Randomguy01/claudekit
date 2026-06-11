# API Reference

> Last updated 2026-06-11

# DefineComponent

```java
@Retention(CLASS)
@Target(TYPE)
public @interface DefineComponent
```

Defines a Hilt component. The annotated type is an empty interface that names a new component in the Hilt hierarchy; a matching [`@DefineComponent.Builder`](define-component-builder.md) supplies its builder. Use a scope annotation on the same type to scope bindings to the component.

A root component declares no parent:

```java
@ParentScoped
@DefineComponent
interface ParentComponent {}
```

A child component names its parent, inheriting the parent's bindings:

```java
@ChildScoped
@DefineComponent(parent = ParentComponent.class)
interface ChildComponent {}
```

## Nested Types

| Type | Summary |
|------|---------|
| [`DefineComponent.Builder`](define-component-builder.md) | Defines a builder for a Hilt component. |

## Elements

### parent

```java
Class<?> parent default DefineComponentNoParent.class
```

The parent of this component, if it exists. Defaults to an internal sentinel (`DefineComponentNoParent`) that marks the component as a root with no parent.
