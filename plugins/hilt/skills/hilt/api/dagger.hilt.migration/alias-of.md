# API Reference

> Last updated 2026-06-11

# AliasOf

```java
@Target(ANNOTATION_TYPE)
@Retention(CLASS)
public @interface AliasOf
```

Defines an alias between an existing Hilt scope and the annotated scope. For example, `@MyScope` can be made an alias of [`@ActivityScoped`](../dagger.hilt.android.scopes/activity-scoped.md) by annotating it with `@AliasOf(ActivityScoped.class)`.

## Elements

### value

```java
Class<? extends Annotation>[] value
```

Returns the existing Hilt scope(s) that the annotated scope is aliasing.
