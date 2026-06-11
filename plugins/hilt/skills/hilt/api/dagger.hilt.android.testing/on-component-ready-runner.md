# API Reference

> Last updated 2026-06-11

# OnComponentReadyRunner

```java
public final class OnComponentReadyRunner
```

Provides access to the [`SingletonComponent`](../dagger.hilt.components/singleton-component.md) in tests, so that rules can access it after custom test modules have been added.

## Nested Types

| Type | Description |
| --- | --- |
| [`OnComponentReadyRunner.OnComponentReadyListener`](on-component-ready-runner-on-component-ready-listener.md) | Rules should register an implementation of this to get access to the singleton component. |
| [`OnComponentReadyRunner.OnComponentReadyRunnerHolder`](on-component-ready-runner-on-component-ready-runner-holder.md) | Public for use by generated code and `TestApplicationComponentManager`. |

## Public Constructors

### OnComponentReadyRunner

```java
public OnComponentReadyRunner()
```

## Public Methods

### addListener

```java
public static <T> void addListener(
    android.content.Context context,
    Class<T> entryPoint,
    OnComponentReadyRunner.OnComponentReadyListener<T> listener)
```

Must be called on the test thread, before the `Statement` is evaluated.

### setComponentManager

```java
public void setComponentManager(
    dagger.hilt.internal.GeneratedComponentManager<?> componentManager)
```

Used by generated code, to notify listeners that the component has been created.

### isEmpty

```java
public boolean isEmpty()
```
