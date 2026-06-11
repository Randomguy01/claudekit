# API Reference

> Last updated 2026-06-11

# ElementsIntoSet

```java
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface ElementsIntoSet
```

The method's return type is `Set<T>` and all of the values it returns are contributed to a `Set<T>` multibinding. Unlike [`@IntoSet`](into-set.md), which contributes a single element, this contributes every element of the returned set — which also makes it the way to contribute a default empty set. The accumulated set is immutable. See the [set multibindings](https://dagger.dev/multibindings#set-multibindings) guide.
</content>
