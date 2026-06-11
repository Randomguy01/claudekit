# API Reference

> Last updated 2026-06-11

# HiltAndroidRule

```java
public final class HiltAndroidRule implements org.junit.rules.TestRule
```

A `TestRule` for Hilt that can be used with JVM or Instrumentation tests. Used with a test class annotated with [`@HiltAndroidTest`](hilt-android-test.md).

## Public Constructors

### HiltAndroidRule

```java
public HiltAndroidRule(Object testInstance)
```

Creates a new instance of the rule. Tests should pass `this`.

## Public Methods

### apply

```java
public org.junit.runners.model.Statement apply(
    org.junit.runners.model.Statement baseStatement,
    org.junit.runner.Description description)
```

### inject

```java
public void inject()
```

Completes Dagger injection. Must be called before accessing inject types. Must be called after any non-static test module has been added. If `delayComponentReady()` was used, this must be called after `componentReady()`.

### delayComponentReady

```java
public HiltAndroidRule delayComponentReady()
```

Delays creating the component until `componentReady()` is called. This is only necessary in the case that a dynamically bound value (e.g. configuring a [`@BindValue`](bind-value.md) field in an `@Before` or `@Test` method) is requested before test case execution begins.

### componentReady

```java
public HiltAndroidRule componentReady()
```

Completes Dagger component creation if `delayComponentReady()` was used. Binds the current value of [`@BindValue`](bind-value.md) fields. Normally this happens automatically.
