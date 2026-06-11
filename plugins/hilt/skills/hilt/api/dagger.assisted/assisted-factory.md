# API Reference

> Last updated 2026-06-11

# AssistedFactory

```java
@Documented
@Retention(RUNTIME)
@Target(TYPE)
public @interface AssistedFactory
```

Annotates an abstract class or interface used to create an instance of a type via an [`@AssistedInject`](assisted-inject.md) constructor. Dagger generates the factory's implementation, which can be injected wherever the assisted type needs to be created.

An `@AssistedFactory`-annotated type must:

- be an abstract class or interface.
- declare exactly one abstract, non-`default` method whose return type exactly matches the assisted-injection type, and whose parameters match — in order — the [`@Assisted`](assisted.md) parameters of the target constructor.
</content>
