# API Reference

> Last updated 2026-06-05

# PrimaryKey

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FIELD, AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation PrimaryKey
```

Marks a field in an [`Entity`](entity.md) as the primary key.

If you would like to define a composite primary key, you should use [`Entity.primaryKeys`](entity.md#primarykey) method.

Each [`Entity`](entity.md) must declare a primary key unless one of its super classes declares a primary key. If both an [`Entity`](entity.md) and its super class defines a [`PrimaryKey`](primary-key.md), the child's [`PrimaryKey`](primary-key.md) definition will override the parent's [`PrimaryKey`](primary-key.md).

If `PrimaryKey` annotation is used on an [`Embedded`](embedded.md) field, all columns inherited from that embedded field becomes the composite primary key (including its grand children fields).

## Public Constructors

### PrimaryKey

> Added in 2.8.4

```
PrimaryKey(autoGenerate: Boolean = false)
```

## Public Properties

### autoGenerate

```
val autoGenerate: Boolean
```

Set to true to let SQLite generate the unique id.

When set to `true`, the SQLite type affinity for the field should be `INTEGER`.

**[`Insert`](insert.md) methods treat `0` and `null` as not-set while inserting into a field of type `Long` or `Int` (or its TypeConverter converts it to a `Long` or `Int`)**
