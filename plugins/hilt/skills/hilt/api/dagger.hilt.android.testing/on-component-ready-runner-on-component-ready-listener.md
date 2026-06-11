# API Reference

> Last updated 2026-06-11

# OnComponentReadyRunner.OnComponentReadyListener

```java
public static interface OnComponentReadyRunner.OnComponentReadyListener<T>
```

Rules should register an implementation of this to get access to the singleton component. Register it with [`OnComponentReadyRunner.addListener`](on-component-ready-runner.md).

## Public Methods

### onComponentReady

```java
void onComponentReady(T entryPoint) throws Throwable
```

Called once the component is available, allowing the rule to interact with the Hilt singleton component during testing.
