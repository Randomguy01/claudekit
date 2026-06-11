# API Reference

> Last updated 2026-06-11

# EarlyEntryPoint

```java
@Beta
@Retention(RUNTIME)
@Target(TYPE)
public @interface EarlyEntryPoint
```

An escape hatch for when a Hilt entry point usage needs to be called before the singleton component is available in a Hilt test. In tests Hilt may delay creating the `SingletonComponent`; code that must reach an entry point before then (for example from `Application#onCreate`) would otherwise fail.

Replace the entry point's [`@EntryPoint`](../dagger.hilt/entry-point.md) annotation with `@EarlyEntryPoint`, and retrieve it through [`EarlyEntryPoints`](early-entry-points.md) rather than `EntryPoints`. It is restricted to entry points installed in the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md). See <https://dagger.dev/hilt/early-entry-point> for details.
</content>
