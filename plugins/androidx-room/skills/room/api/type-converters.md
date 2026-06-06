# API Reference

> Last updated 2026-06-05

# TypeConverters

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.VALUE_PARAMETER, AnnotationTarget.FIELD, AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation TypeConverters
```

Specifies additional type converters that Room can use. The TypeConverter is added to the scope of the element so if you put it on a class / interface, all methods / fields in that class will be able to use the converters.

TypeConverters can only be used to convert columns / fields, hence cannot be used by a method with a row return value such as DAO methods that query rows.
- If you put it on a [`Database`](database.md), all Daos and Entities in that database will be able to use it.
- If you put it on a [`Dao`](dao.md), all methods in the Dao will be able to use it.
- If you put it on an [`Entity`](entity.md), all fields of the Entity will be able to use it.
- If you put it on a POJO, all fields of the POJO will be able to use it.
- If you put it on an [`Entity`](entity.md) field, only that field will be able to use it.
- If you put it on a [`Dao`](dao.md) method, all parameters of the method will be able to use it.
- If you put it on a [`Dao`](dao.md) method parameter, just that field will be able to use it.

|        See also         |
|-------------------------|
| [`TypeConverter`](type-converter.md) |

## Public Constructors

### TypeConverters

> Added in 2.8.4

```
TypeConverters(
    vararg value: KClass<*> = [],
    builtInTypeConverters: BuiltInTypeConverters = BuiltInTypeConverters()
)
```

## Public Properties

### builtInTypeConverters

```
val builtInTypeConverters: BuiltInTypeConverters
```

Configure whether Room can use various built in converters for common types. See [`BuiltInTypeConverters`](built-in-type-converters.md) for details.

### value

```
val value: Array<KClass<*>>
```

The list of type converter classes. If converter methods are not static, Room will create an instance of these classes.
