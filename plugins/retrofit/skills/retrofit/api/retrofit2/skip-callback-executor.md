# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# SkipCallbackExecutor

Package `retrofit2`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface SkipCallbackExecutor
```

Change the behavior of a `Call<BodyType>` return type to not use the [callback executor](retrofit.md#callbackexecutor) for invoking the [`onResponse`](callback.md#onresponse) or [`onFailure`](callback.md#onfailure) methods.

```java
@SkipCallbackExecutor
@GET("user/{id}/token")
Call<String> getToken(@Path("id") long id);
```

This annotation can also be used when a [`CallAdapter.Factory`](call-adapter-factory.md) *explicitly* delegates to the built-in factory for [`Call`](call.md) via [`Retrofit.nextCallAdapter`](retrofit.md#nextcalladapter) in order for the returned [`Call`](call.md) to skip the executor. (Note: by default, a [`Call`](call.md) supplied directly to a [`CallAdapter`](call-adapter.md) will already skip the callback executor. The annotation is only useful when looking up the built-in adapter.)
