# API Reference

> Last updated 2026-06-05

# TypeConverter

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation TypeConverter
```

Marks a method as a type converter. A class can have as many @TypeConverter methods as it needs.

Each converter method should receive 1 parameter and have non-void return type.
```kotlin
// example converter for java.util.Date
class Converters {
    @TypeConverter
    fun fromTimestamp(value: Long?): Date? {
        return value?.let { Date(it) }
    }

    @TypeConverter
    fun dateToTimestamp(date: Date?): Long? {
        return date?.time
    }
}
```

|        See also         |
|-------------------------|
| [`TypeConverters`](type-converters.md) |

## Public Constructors

### TypeConverter

```
TypeConverter()
```
