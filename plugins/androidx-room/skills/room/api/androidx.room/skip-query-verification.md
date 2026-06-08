# API Reference

> Last updated 2026-06-08

# SkipQueryVerification

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation SkipQueryVerification
```

Skips database verification for the annotated element.

If it is a class annotated with [`@Database`](database.md), none of the queries for the database will be verified at compile time.

If it is a class annotated with [`@Dao`](dao.md), none of the queries in the DAO class will be verified at compile time.

If it is a method in a DAO class, just that method's SQL verification will be skipped.

If it is a class annotated with [`@DatabaseView`](database-view.md), the `SELECT` SQL for creating the view will not be verified at compile time.

You should use this as a last resort if Room cannot properly understand your query and you are 100% sure it works. Removing validation may limit the functionality of Room since it won't be able to understand the query response.

## Public Constructors

### SkipQueryVerification

```
SkipQueryVerification()
```
