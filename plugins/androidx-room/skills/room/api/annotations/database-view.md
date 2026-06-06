# API Reference

> Last updated 2026-06-05

# DatabaseView

> Added in 2.1.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation DatabaseView
```

Marks a class as an SQLite view.

The value of the annotation is a SELECT query used when the view is created.

The class will behave like normal POJO when it is used in a [`Dao`](dao.md). You can SELECT FROM a [`DatabaseView`](database-view.md) similar to an [`Entity`](entity.md), but you can not INSERT, DELETE or UPDATE into a [`DatabaseView`](database-view.md).

Similar to an [`Entity`](entity.md), you can use [`ColumnInfo`](column-info.md) and [`Embedded`](embedded.md) inside to customize the data class.

Example:
```kotlin
@DatabaseView(
  "SELECT id, name, release_year FROM Song " +
  "WHERE release_year >= 1990 AND release_year <= 1999"
)
data class SongFrom90s (
  val id: Long,
  val name: String,
  @ColumnInfo(name = "release_year")
  val releaseYear: Int
)
```

Views have to be registered to a RoomDatabase via [`Database.views`](database.md#views).

|        See also         |
|-------------------------|
| [`Dao`](dao.md)             |
| [`Database`](database.md)   |
| [`ColumnInfo`](column-info.md) |
| [`Embedded`](embedded.md)   |

## Public Constructors

### DatabaseView

> Added in 2.8.4

```
DatabaseView(value: String = "", viewName: String = "")
```

## Public Properties

### value

```
val value: String
```

The SELECT query.

### viewName

```
val viewName: String
```

The view name in the SQLite database. If not set, it defaults to the class name.
