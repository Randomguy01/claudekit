# API Reference

> Last updated 2026-06-11

# AssistedInject

```java
@Documented
@Retention(RUNTIME)
@Target(CONSTRUCTOR)
public @interface AssistedInject
```

Annotates the constructor of a type that will be created via assisted injection — a mix of dependencies provided by Dagger and parameters supplied by the caller. An assisted-injection type cannot be scoped, and must be paired with an [`@AssistedFactory`](assisted-factory.md).

Mark the caller-supplied parameters with [`@Assisted`](assisted.md); Dagger provides the rest from the graph:

```java
final class DataService {
  private final DataFetcher dataFetcher;
  private final Config config;

  @AssistedInject
  DataService(DataFetcher dataFetcher, @Assisted Config config) {
    this.dataFetcher = dataFetcher;
    this.config = config;
  }
}
```

The factory declares a single abstract, non-`default` method taking the assisted parameters in order and returning the assisted type:

```java
@AssistedFactory
interface DataServiceFactory {
  DataService create(Config config);
}
```

Inject the generated factory and call it to build instances:

```java
class MyApplication {
  @Inject DataServiceFactory dataServiceFactory;
  dataService = dataServiceFactory.create(new Config(...));
}
```
</content>
