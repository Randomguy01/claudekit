# API Reference

> Last updated 2026-06-11

# MembersInjector

```java
public interface MembersInjector<T extends @Nullable Object>
```

Injects dependencies into the fields and methods on instances of type `T`, ignoring the presence or absence of an injectable constructor.

When a [`Component`](component.md) creates an instance, it performs this members injection automatically after the constructor completes, so using `MembersInjector` directly is unnecessary when the component creates every instance.

## Public Methods

### injectMembers

```java
void injectMembers(T instance)
```

Injects dependencies into the fields and methods of `instance`, ignoring whether an injectable constructor exists.

- `instance` — the instance to inject members into.

Throws `NullPointerException` if `instance` is `null`. (`injectMembers(T)` rejecting `null` was added in 2.0.)
</content>
