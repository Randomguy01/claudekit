# API Reference

> Last updated 2026-06-10

# ExperimentalWorkRequestBuilderApi

> Added in 2.11.2

```
@Retention(value = AnnotationRetention.BINARY)
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.PROPERTY, AnnotationTarget.PROPERTY_GETTER, AnnotationTarget.CLASS])
@RequiresOptIn(level = RequiresOptIn.Level.WARNING)
annotation ExperimentalWorkRequestBuilderApi
```

Annotation indicating experimental APIs for [`WorkRequest.Builder`](work-request-builder.md). APIs annotated with `ExperimentalWorkRequestBuilderApi` require opt-in.

## Public Constructors

### ExperimentalWorkRequestBuilderApi

```
ExperimentalWorkRequestBuilderApi()
```
