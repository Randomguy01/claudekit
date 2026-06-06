# API Reference

> Last updated 2026-06-05

# ProvidedAutoMigrationSpec

> Added in 2.4.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation ProvidedAutoMigrationSpec
```

Marks a class as an auto migration spec that will be provided to Room at runtime.

An instance of a class annotated with this annotation has to be provided to Room using `Room.databaseBuilder.addAutoMigrationSpec(AutoMigrationSpec)`. Room will verify that the spec is provided in the builder configuration and if not, an `IllegalArgumentException` will be thrown.

## Public Constructors

### ProvidedAutoMigrationSpec

```
ProvidedAutoMigrationSpec()
```
