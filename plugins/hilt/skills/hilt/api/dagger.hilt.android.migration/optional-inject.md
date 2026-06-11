# API Reference

> Last updated 2026-06-11

# OptionalInject

```java
@Target(TYPE)
public @interface OptionalInject
```

When placed on an [`@AndroidEntryPoint`](../dagger.hilt.android/android-entry-point.md)-annotated activity / fragment / view / etc, allows injection to occur optionally based on whether or not the application is using Hilt. Use [`OptionalInjectCheck.wasInjectedByHilt`](optional-inject-check.md) to check at runtime if Hilt injected the class. The Hilt code generator also generates a `wasInjectedByHilt()` method in the generated base class for direct subclasses that are not using the Gradle plugin.

This is useful for library developers that need to support both Hilt and non-Hilt applications. Injection occurs only when the parent component (such as an `Activity` for a `Fragment`) is both `@AndroidEntryPoint`-annotated and injected by Hilt.
