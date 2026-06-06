# API Reference

> Last updated 2026-06-05

# ProvidedTypeConverter

> Added in 2.3.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation ProvidedTypeConverter
```

Marks a class as a type converter that will be provided to Room at runtime. If Room uses the annotated type converter class, it will verify that it is provided in the builder and if not, will throw an exception. An instance of a class annotated with this annotation has to be provided to Room using `Room.databaseBuilder.addTypeConverter(Object)`.

## Public Constructors

### ProvidedTypeConverter

```
ProvidedTypeConverter()
```
