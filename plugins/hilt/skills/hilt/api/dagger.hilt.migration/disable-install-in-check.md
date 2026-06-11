# API Reference

> Last updated 2026-06-11

# DisableInstallInCheck

```java
public @interface DisableInstallInCheck
```

Marks a [`@Module`](../dagger/module.md)-annotated class to allow it to have no [`@InstallIn`](../dagger.hilt/install-in.md) annotation, suppressing the error of a missing `@InstallIn` annotation. This is useful in cases where non-Hilt Dagger code must be used long-term. If this issue is widespread, consider the compiler flag `dagger.hilt.disableModulesHaveInstallInCheck` instead.
