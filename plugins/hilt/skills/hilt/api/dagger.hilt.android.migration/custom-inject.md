# API Reference

> Last updated 2026-06-11

# CustomInject

```java
@Target(TYPE)
public @interface CustomInject
```

When placed on a [`@HiltAndroidApp`](../dagger.hilt.android/hilt-android-app.md)-annotated application, this causes the application to no longer inject itself in `onCreate` and instead allows it to be injected at some other time. To inject the application, use [`CustomInjection.inject`](custom-injection.md) or the generated `customInject()` method in the Hilt base class.

```java
@CustomInject
@HiltAndroidApp(Application.class)
public final class MyApplication extends Hilt_MyApplication {

  @Inject Foo foo;

  @Override
  public void onCreate() {
    super.onCreate();
    doSomethingBeforeInjection();
    CustomInjection.inject(this);
  }
}
```
