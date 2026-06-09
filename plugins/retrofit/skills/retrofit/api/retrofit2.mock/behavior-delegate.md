# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# BehaviorDelegate

Package `retrofit2.mock` · Artifact `com.squareup.retrofit2:retrofit-mock`

```java
public final class BehaviorDelegate<T>
```

Applies [`NetworkBehavior`](network-behavior.md) to responses and adapts them into the appropriate return type using the call adapters of the underlying [`Retrofit`](../retrofit2/retrofit.md). Obtained from [`MockRetrofit.create`](mock-retrofit.md#create).

A mock service implementation wraps each method's canned value with the delegate:

```java
class MockMyApi implements MyApi {
  private final BehaviorDelegate<MyApi> delegate;

  MockMyApi(BehaviorDelegate<MyApi> delegate) {
    this.delegate = delegate;
  }

  @Override public Call<User> getUser() {
    User user = new User("Bob");
    return delegate.returningResponse(user).getUser();
  }
}
```

## Public Methods

### returningResponse

```java
T returningResponse(@Nullable java.lang.Object response)
```

Returns a proxy of the service type whose next called method will yield `response` as a successful body (subject to the configured behavior).

### returning

```java
<R> T returning(retrofit2.Call<R> call)
```

Returns a proxy of the service type whose next called method will delegate to `call` (subject to the configured behavior). Pair with [`Calls`](calls.md) to supply canned responses or failures.
