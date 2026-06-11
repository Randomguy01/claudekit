# API Reference

> Last updated 2026-06-11

# Provides

```java
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface Provides
```

Annotates methods of a [`Module`](module.md) to create a provider method binding. The method's return type is bound to its returned value; the component implementation passes the method's parameters as dependencies, which it supplies from the graph.

By default Dagger forbids injecting `null`: a `@Provides` method that returns `null` triggers a `NullPointerException` at injection time. To allow `null`, annotate the method `@Nullable` (for example `javax.annotation.Nullable`). A `@Nullable` provider may only satisfy `@Nullable` injection sites — a nullability mismatch between the provider and an injection site is a compile-time error.
</content>
