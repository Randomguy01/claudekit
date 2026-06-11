# API Reference

> Last updated 2026-06-11

# CustomTestApplication

```java
@Target(ElementType.TYPE)
public @interface CustomTestApplication
```

An annotation that creates an application with the given base type that can be used for any test in the given build. This annotation is useful for creating an application that can be used with instrumentation tests in Gradle, since every instrumentation test must share the same application type.

## Elements

### value

```java
Class<?> value
```

Returns the base `Application` class.
