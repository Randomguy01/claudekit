# API Reference

> Last updated 2026-06-11

# BindValue

```java
@Retention(CLASS)
@Target(FIELD)
public @interface BindValue
```

An annotation that can be used on a test field to contribute the value into the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md). The annotated field's value becomes available for injection throughout the test application.

```java
public class FooTest {
  @BindValue Bar boundBar = new Bar();
}
```
