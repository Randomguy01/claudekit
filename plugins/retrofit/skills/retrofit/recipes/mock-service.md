# Provide a Mock Implementation

The `retrofit-mock` module backs a service interface with fake data while still exercising the real [`Call`](../api/retrofit2/call.md) contract and simulated network behavior — useful in tests and for developing against an unfinished API.

Wrap the existing [`Retrofit`](../api/retrofit2/retrofit.md) instance in a [`MockRetrofit`](../api/retrofit2.mock/mock-retrofit.md) via its [builder](../api/retrofit2.mock/mock-retrofit-builder.md), tune the [`NetworkBehavior`](../api/retrofit2.mock/network-behavior.md), and create a [`BehaviorDelegate`](../api/retrofit2.mock/behavior-delegate.md) for the interface. The delegate produces `Call` instances that honor the configured delays and failure rate.

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.github.com/")
    .build();

NetworkBehavior behavior = NetworkBehavior.create();
MockRetrofit mockRetrofit = new MockRetrofit.Builder(retrofit)
    .networkBehavior(behavior)
    .build();

BehaviorDelegate<GitHub> delegate = mockRetrofit.create(GitHub.class);
```

Implement the interface, delegating each method to `delegate.returningResponse(...)`:

```java
final class MockGitHub implements GitHub {
  private final BehaviorDelegate<GitHub> delegate;

  MockGitHub(BehaviorDelegate<GitHub> delegate) {
    this.delegate = delegate;
  }

  @Override public Call<List<Contributor>> contributors(String owner, String repo) {
    List<Contributor> response = lookUp(owner, repo); // fake data
    return delegate.returningResponse(response).contributors(owner, repo);
  }
}
```

Adjust `behavior.setDelay(...)`, `setFailurePercent(...)`, and friends to simulate slow or flaky networks. For full control without an interface implementation, return canned `Call` values directly with [`Calls`](../api/retrofit2.mock/calls.md).
