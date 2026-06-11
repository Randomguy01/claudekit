# API Reference

> Last updated 2026-06-11

# OptionalInjectCheck

```java
public final class OptionalInjectCheck
```

Utility methods for validating if an [`@AndroidEntryPoint`](../dagger.hilt.android/android-entry-point.md)-annotated class that is also annotated with [`@OptionalInject`](optional-inject.md) was injected by Hilt.

## Public Methods

Each overload returns `true` if the given instance was injected by Hilt, and throws `IllegalArgumentException` if the instance is not an `@AndroidEntryPoint` nor annotated with `@OptionalInject`.

### wasInjectedByHilt

```java
public static boolean wasInjectedByHilt(androidx.activity.ComponentActivity activity)
public static boolean wasInjectedByHilt(androidx.fragment.app.Fragment fragment)
public static boolean wasInjectedByHilt(android.view.View view)
public static boolean wasInjectedByHilt(android.app.Service service)
public static boolean wasInjectedByHilt(android.content.BroadcastReceiver broadcastReceiver)
```
