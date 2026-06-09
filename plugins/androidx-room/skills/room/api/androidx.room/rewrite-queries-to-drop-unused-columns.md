# API Reference

> Last updated 2026-06-08

# RewriteQueriesToDropUnusedColumns

> Added in 2.3.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation RewriteQueriesToDropUnusedColumns
```

When present, the `@RewriteQueriesToDropUnusedColumns` annotation causes Room to rewrite your [`@Query`](query.md) methods such that only the columns that are used in the response are queried from the database.

This annotation is useful if you don't need all columns returned in a query but also don't want to spell out their names in the query projection.

For example, if you have a `User` class with 10 fields and want to return only the `name` and `lastName` fields in a POJO, you could write the query like this:

```kotlin
@Dao
interface MyDao {
  @Query("SELECT * FROM User")
  fun getAll(): List<NameAndLastName>
}

data class NameAndLastName(
  val name: String,
  val lastName: String
)
```

Normally, Room would print a [`RoomWarnings.QUERY_MISMATCH`](room-warnings.md#query_mismatch) warning since the query result has additional columns that are not used in the response. Annotate the method with `@RewriteQueriesToDropUnusedColumns` to inform Room to rewrite your query at compile time to avoid fetching extra columns.

```kotlin
@Dao
interface MyDao {
  @RewriteQueriesToDropUnusedColumns
  @Query("SELECT * FROM User")
  fun getAll(): List<NameAndLastName>
}
```

At compile time, Room converts this query to `SELECT name, lastName FROM (SELECT * FROM User)`, which gets flattened by SQLite to `SELECT name, lastName FROM User`.

When the annotation is used on a [`@Dao`](dao.md) method annotated with `@Query`, it affects only that query. You can put the annotation on the `@Dao` annotated class/interface or the [`@Database`](database.md) annotated class, where it impacts all methods in the DAO / database respectively.

Room will not rewrite the query if it has multiple columns that have the same name, as it does not yet have a way to distinguish which one is necessary.

## Public Constructors

### RewriteQueriesToDropUnusedColumns

```
RewriteQueriesToDropUnusedColumns()
```
