# API Reference

> Last updated 2026-06-11

# Binds

```java
@Documented
@Retention(RUNTIME)
@Target(METHOD)
public @interface Binds
```

Annotates `abstract` methods of a [`Module`](module.md) that delegate bindings. For example, to bind `Random` to `SecureRandom` a module could declare:

```java
@Binds abstract Random bindRandom(SecureRandom secureRandom);
```

`@Binds` methods are a drop-in replacement for [`@Provides`](provides.md) methods that simply return an injected parameter, and may offer better runtime performance.

A `@Binds` method:

- must be `abstract`.
- may be scoped.
- may be qualified.
- must have a single parameter whose type is assignable to the return type. The return type is the bound type; the parameter is the implementation type.

For multibindings, the parameter's assignability differs:

- `@IntoSet` — the parameter must be assignable to the parameter of `Set.add(E)`.
- `@ElementsIntoSet` — the parameter must be assignable to the parameter of `Set.addAll(Collection<? extends E>)`.
- `@IntoMap` — the parameter must be assignable to the value parameter of `Map.put(K, V)`.
