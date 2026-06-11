# API Reference

> Last updated 2026-06-11

# EntryPoint

```java
@Retention(CLASS)
@Target(TYPE)
public @interface EntryPoint
```

Annotation for marking an interface as an entry point into a generated component. Use this when you need to access the Dagger object graph from code that cannot itself be injected — Hilt makes each specified component extend the annotated interface.

An `@EntryPoint` interface must also be annotated with [`@InstallIn`](install-in.md) to declare which component(s) it is installed into. Retrieve the interface from a component at runtime with [`EntryPoints`](entry-points.md):

```java
@EntryPoint
@InstallIn(SingletonComponent.class)
public interface FooEntryPoint {
  Foo getFoo();
}

Foo foo = EntryPoints.get(component, FooEntryPoint.class).getFoo();
```
</content>
