# API Reference

> Last updated 2026-06-11

# Assisted

```java
@Documented
@Retention(RUNTIME)
@Target(PARAMETER)
public @interface Assisted
```

Annotates a parameter within an [`@AssistedInject`](assisted-inject.md)-annotated constructor — an assisted parameter is supplied by the caller at creation time rather than by the Dagger graph.

Each assisted parameter must be uniquely defined by the combination of its identifier and type. The identifier defaults to the empty string, so `@Assisted Foo foo` and `@Assisted("") Foo foo` are equivalent. The parameters of an [`@AssistedFactory`](assisted-factory.md) method are matched to the constructor's assisted parameters by identifier and type; an unannotated factory parameter takes the default empty-string identifier.

```java
final class DataService {
  @AssistedInject
  DataService(
      BindingFromDagger bindingFromDagger,
      @Assisted String name,
      @Assisted("id") String id,
      @Assisted("repo") String repo) {}
}

@AssistedFactory
interface DataServiceFactory {
  DataService create(
      String name,
      @Assisted("id") String id,
      @Assisted("repo") String repo);
}
```

## Elements

### value

```java
String value default ""
```

An identifier for the assisted parameter, used to disambiguate assisted parameters of the same type.
