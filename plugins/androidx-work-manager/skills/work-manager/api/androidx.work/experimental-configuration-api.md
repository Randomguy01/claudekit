# API Reference

> Last updated 2026-06-10

# ExperimentalConfigurationApi

> Added in 2.10.0

```
@Retention(value = AnnotationRetention.BINARY)
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.PROPERTY, AnnotationTarget.PROPERTY_GETTER, AnnotationTarget.CLASS])
@RequiresOptIn(level = RequiresOptIn.Level.WARNING)
annotation ExperimentalConfigurationApi
```

Annotation indicating experimental API for new WorkManager [`Configuration`](configuration.md) APIs.

These APIs allow fine-grained tuning of WorkManager's behavior. However, the full effects of these flags on OS health and WorkManager's throughput aren't fully known and are currently being explored. After that research, either the best default value for a flag will be chosen and the associated API removed, or guidance on how to choose a value depending on an app's specifics will be developed and the associated API promoted to stable.

As a result, APIs annotated with `ExperimentalConfigurationApi` require opt-in.

## Public Constructors

### ExperimentalConfigurationApi

```
ExperimentalConfigurationApi()
```
