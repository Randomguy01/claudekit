# API Reference

> Last updated 2026-06-11

# HiltAndroidTest

```java
@Retention(RUNTIME)
@Target(TYPE)
public @interface HiltAndroidTest
```

Annotation used for marking an Android emulator test that requires injection. Pair it with a [`HiltAndroidRule`](hilt-android-rule.md) on the test class.
