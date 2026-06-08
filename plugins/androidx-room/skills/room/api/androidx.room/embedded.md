# API Reference

> Last updated 2026-06-08

# Embedded

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FIELD, AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Embedded
```

Marks a field of an `Entity` or POJO to allow nested fields (i.e. fields of the annotated field's class) to be referenced directly in SQL queries.

If the container is an `Entity`, these sub fields will be columns in the `Entity`'s database table.

```kotlin
data class Coordinates(
  val latitude: Double,
  val longitude: Double
)

data class Address(
  val street: String,
  @Embedded
  val coordinates: Coordinates
)
```

Room will consider `latitude` and `longitude` as if they are fields of the `Address` class when mapping a SQLite row to `Address`. A query returning `street, latitude, longitude` will properly construct an `Address`.

If `Address` is annotated with `@Entity`, its table will have 3 columns: `street`, `latitude`, and `longitude`.

If there is a name conflict between sub-object fields and owner fields, use `prefix` to disambiguate. The prefix is always applied to sub fields even if they have a [`@ColumnInfo`](column-info.md) with a specific `name`.

Sub fields annotated with [`@PrimaryKey`](primary-key.md) **will not** be treated as primary keys in the owner `Entity`.

When an embedded field is read, if all of its columns in the `Cursor` are `null`, the embedded field is set to `null`. Even if a `TypeConverter` maps a null column to a non-null value, the converter will not be called in this case — annotate the field with `@NonNull` to override this behavior.

## Public Constructors

### Embedded

> Added in 2.8.4

```
Embedded(prefix: String = "")
```

## Public Properties

### prefix

```
val prefix: String
```

Specifies a prefix to prepend to the column names of the embedded fields.

```kotlin
@Embedded(prefix = "loc_")
val coordinates: Coordinates
```

With the example above, `latitude` and `longitude` become `loc_latitude` and `loc_longitude`. Default is an empty string.
