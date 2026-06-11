# API Reference

> Last updated 2026-06-11

# Reusable

```java
@Documented
@Beta
@Retention(RUNTIME)
@Scope
public @interface Reusable
```

A scope that indicates that the object returned by a binding may be (but might not be) reused. `@Reusable` is useful when you want to limit the number of times a type is provisioned but do not need a strict single-instance lifetime — a `@Reusable` binding has no defined owning component, so different components (or even different injection sites) may each cache their own instance.

See the [Reusable scope](https://dagger.dev/users-guide#reusable-scope) section of the users' guide for details.
