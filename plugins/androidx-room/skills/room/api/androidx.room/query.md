# API Reference

> Last updated 2026-06-05

# Query

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION, AnnotationTarget.PROPERTY_GETTER])
@Retention(value = AnnotationRetention.BINARY)
annotation Query
```

Marks a method in a [`Dao`](dao.md) annotated class as a query method.

The value of the annotation is the query that will be run when this method is called. **This query is verified at compile time**.

The arguments of the method will be bound to the bind arguments in the SQL statement. Room only supports named bind parameter `:name` to avoid any confusion between the method parameters and the query bind parameters. Room will automatically bind the parameters of the method into the bind arguments. This is done by matching the name of the parameters to the name of the bind arguments.

Example:
```kotlin
@Query("SELECT * FROM song WHERE release_year = :year")
public abstract fun findSongsByReleaseYear(year: Int): List<Song>
```

## Parameter Binding

Room supports binding a list of parameters to the query. At runtime, Room will build the correct query to have matching number of bind arguments.

Example:
```kotlin
@Query("SELECT * FROM song WHERE id IN(:songIds)")
public abstract fun findByIds(songIds: Array<Long>): List<Song>
```

**This type of binding only supports up to 999 items**


## Statement Types

There are 4 type of statements supported in `Query` methods: SELECT, INSERT, UPDATE, and DELETE.

### SELECT

Room will infer the result contents from the method's return type and generate the code that will automatically convert the query result into the method's return type.
- For single result queries, the return type can be any data object/class 
- For queries that return multiple values, use `java.util.List` or `Array` 
- any query may return `android.database.Cursor`
- any query result can be wrapped in a `androidx.lifecycle.LiveData`

### INSERT

Queries can return `void` or `Long`. 

If it is a `Long`, the value is the SQLite rowid of the row inserted by this query.

**Queries which insert multiple rows cannot return more than one rowid, so avoid such statements if returning `Long`**

### UPDATE & DELETE

Queries can return `void` or `Int`.

If it is an `Int`, the value is the number of rows affected by this query.

## Flow

You can also return `Flow<T>` from query methods. This creates a `Flow<T>` object that emits the results of the query and re-dispatches the query every time the data in the queried table changes.

Querying a table with a return type of `Flow<T>` always returns the first row in the result set, rather than emitting all of the rows in sequence. To observe changes over multiple rows in a table, use a return type of `Flow<List<T>>` instead.

Keep nullability in mind when choosing a return type, as it affects how the query method handles empty tables:
- When the return type is `Flow<T>`, querying an empty table throws a null pointer exception.
- When the return type is `Flow<T?>`, querying an empty table emits a null value.
- When the return type is `Flow<List<T>>`, querying an empty table emits an empty list.

You can return arbitrary data classes from your query methods as long as the properties of the data class match the column names in the query result.

If you have:
```kotlin
data class SongDuration (
  val name: String,
  @ColumnInfo(name = "duration")
  val length: String
)
```

You can write:
```kotlin
@Query("SELECT name, duration FROM song WHERE id = :songId LIMIT 1")
public abstract fun findSongDuration(songId: Int): SongDuration
```

And Room will create the correct implementation to convert the query result into a `SongDuration` object. If there is a mismatch between the query result and the properties of the data class, and as long as there is at least 1 field match, Room prints a [`RoomWarnings.QUERY_MISMATCH`](../classes/room-warnings.md#query_mismatch) warning and sets as many properties as it can.

## Public Constructors

### Query

> Added in 2.8.4

```
Query(value: String)
```

## Public Properties

### value

```
val value: String
```

The SQLite query to be run.
