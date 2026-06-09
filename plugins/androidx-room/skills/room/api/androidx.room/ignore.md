# API Reference

> Last updated 2026-06-05

# Ignore

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.FIELD, AnnotationTarget.CONSTRUCTOR, AnnotationTarget.PROPERTY_GETTER])
@Retention(value = AnnotationRetention.BINARY)
annotation Ignore
```

Ignores the marked element from Room's processing logic.

This annotation can be used in multiple places where the Room processor runs. For instance, you can add it to a field of an [Entity](entity.md) and Room will not persist that field.

## Public Constructors

### Ignore

```
Ignore()
```
