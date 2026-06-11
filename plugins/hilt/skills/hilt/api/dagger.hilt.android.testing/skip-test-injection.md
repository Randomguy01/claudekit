# API Reference

> Last updated 2026-06-11

# SkipTestInjection

```java
@Retention(CLASS)
@Target(TYPE)
public @interface SkipTestInjection
```

Annotation used for skipping test injection in a Hilt Android test. This may be useful if building separate custom test infrastructure to inject the test class from another Hilt component. This may be used on either the test class or an annotation that annotates the test class.
