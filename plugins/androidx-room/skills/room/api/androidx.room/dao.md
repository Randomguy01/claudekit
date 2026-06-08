# API Reference

> Last updated 2026-06-04 UTC

# Dao

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation Dao
```

Marks the class as a Data Access Object.

Data Access Objects are the main classes where you define your database interactions. They can include a variety of query methods.

The class marked with `@Dao` should either be an interface or an abstract class. At compile time, Room will generate an implementation of this class when it is referenced by a [Database](database.md).

An abstract `@Dao` class can optionally have a constructor that takes a [Database](database.md) as its only parameter.

It is recommended to have multiple `Dao` classes in your codebase depending on the tables they touch.  

|      See also       |
|---------------------|
| [Query](query.md)   |
| [Delete](delete.md) |
| [Insert](insert.md) |

## Public Constructors

### Dao

```
Dao()
```
