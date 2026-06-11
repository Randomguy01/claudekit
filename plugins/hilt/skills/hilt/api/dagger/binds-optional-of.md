# API Reference

> Last updated 2026-06-11

# BindsOptionalOf

```java
@Documented
@Beta
@Retention(RUNTIME)
@Target(METHOD)
public @interface BindsOptionalOf
```

Annotates methods that declare bindings for `Optional` containers of values from bindings that may or may not be present in the component. For example:

```java
@BindsOptionalOf abstract Foo optionalFoo();
```

Any binding in the component can then depend on an `Optional` of `Foo`. If a binding for `Foo` is present, the `Optional` is present and holds the bound value; if not, the `Optional` is absent.

A `@BindsOptionalOf` method:

- must be `abstract`.
- may have a qualifier annotation.
- must not return `void`.
- must not have parameters.
- must not throw.
- must not return an unqualified type with an `@Inject`-annotated constructor, since such a type is always present.

Other bindings may inject any of:

- `Optional<Foo>`
- `Optional<Provider<Foo>>`
- `Optional<Lazy<Foo>>`
- `Optional<Provider<Lazy<Foo>>>`

If a `@Nullable` binding for `Foo` exists, injecting `Optional<Foo>` is a compile-time error; the other forms remain valid because `Provider` and [`Lazy`](lazy.md) may return `null`. Explicit bindings for any of these forms conflict with a `@BindsOptionalOf` binding. Both `com.google.common.base.Optional` and `java.util.Optional` are supported.
