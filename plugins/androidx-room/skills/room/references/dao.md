# DAO

Data access objects (DAOs) contain the methods that access the database. Room generates DAO implementations at compile time.

## Defining a DAO

- Define each DAO as either an interface (preferred) or an abstract class.
- You must annotate it with [`@Dao`](../api/androidx.room/dao.md).

```kotlin
@Dao
interface UserDao {
    @Insert
    fun insertAll(vararg users: User)

    @Delete
    fun delete(user: User)

    @Query("SELECT * FROM user")
    fun getAll(): List<User>
}
```

> [!NOTE]
> Room does not allow database access on the main thread. For `suspend` and `Flow` return types, see [Asynchronous DAO Queries](dao-async.md).

## Convenience Methods

> [!TIP]
> For behavior beyond insert, update, and delete, use a query method instead.

### Insert

The [`@Insert`](../api/androidx.room/insert.md) annotation defines methods that insert their parameters into the table.

Each parameter for an `@Insert` method must be an instance of an [entity](../api/androidx.room/entity.md) annotated with [`@Entity`](../api/androidx.room/entity.md), or a collection of entity instances.

If the [`@Insert`](../api/androidx.room/insert.md) method receives a single parameter, it can return the `long` value `rowId` for the inserted item. If the parameter is an array or a collection, then it can return an array or a collection of `long` values instead. To learn more about returning `rowId` values, see the reference documentation for the [`@Insert`](../api/androidx.room/insert.md) annotation and the [SQLite documentation for rowid tables](https://www.sqlite.org/rowidtable.html).

The `onConflict` parameter sets how Room resolves a conflict with an existing row, such as `REPLACE` or `IGNORE`. See [`OnConflictStrategy`](../api/androidx.room/on-conflict-strategy.md).

```kotlin
@Dao
interface UserDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertUsers(vararg users: User)

    @Insert
    fun insertBothUsers(user1: User, user2: User)

    @Insert
    fun insertUsersAndFriends(user: User, friends: List<User>)
}
```

### Update

The [`@Update`](../api/androidx.room/update.md) annotation marks a method that updates specific rows in a database table. Like [`@Insert`](../api/androidx.room/insert.md) methods, [`@Update`](../api/androidx.room/update.md) methods accept data entity instances as parameters.

Room uses the [primary key](../api/androidx.room/primary-key.md) to match passed entity instances to rows in the database. If there is no row with the same primary key, Room makes no changes.

An [`@Update`](../api/androidx.room/update.md) method can optionally return an `int` value indicating the number of rows that were updated successfully.


```kotlin
@Dao
interface UserDao {
    @Update
    fun updateUsers(vararg users: User)
}
```

### Delete

The [`@Delete`](../api/androidx.room/delete.md) annotation lets you define methods that delete rows from a database table. Like [`@Insert`](../api/androidx.room/insert.md), [`@Delete`](../api/androidx.room/delete.md) accepts data entity instances as parameters.

Room uses the [primary key](../api/androidx.room/primary-key.md) to match passed entity instances to rows in the database. If there is no row with the same primary key, Room makes no changes.

A [`@Delete`](../api/androidx.room/delete.md) method can optionally return an `int` value indicating the number of rows that were deleted successfully.

```kotlin
@Dao
interface UserDao {
    @Delete
    fun deleteUsers(vararg users: User)
}
```

### Upsert

The [`@Upsert`](../api/androidx.room/upsert.md) annotation combines insert and update: it inserts an entity if it isn't already present, or updates it if it is.

## Query Methods

The [`@Query`](../api/androidx.room/query.md) annotation defines raw SQL statements and exposes them as DAO methods. Use query methods to read data, or to perform complex insertions, updates, and deletions.

> [!NOTE]
> Room validates SQL queries at compile time.

### Simple Queries

```kotlin
@Query("SELECT * FROM user")
fun loadAllUsers(): Array<User>
```

### Return a Subset of a Table's Columns

> [!TIP]
> To save resources, query only the **fields you need**.

Return a simple object from a query when the result columns map onto the object's fields. For example, define an object to hold a user's first and last name:
```kotlin
data class NameTuple(
    @ColumnInfo(name = "first_name") val firstName: String?,
    @ColumnInfo(name = "last_name") val lastName: String?,
)
```

Then return that object from a query method:
```kotlin
@Query("SELECT first_name, last_name FROM user")
fun loadFullName(): List<NameTuple>
```

If the query returns a column that doesn't map onto a field in the returned object, Room displays a warning.

### Pass Simple Parameters to a Query

Room supports method parameters as bind parameters in queries.

```kotlin
@Query("SELECT * FROM user WHERE age > :minAge")
fun loadAllUsersOlderThan(minAge: Int): Array<User>
```

Pass multiple parameters or reference the same parameter multiple times:
```kotlin
@Query("SELECT * FROM user WHERE age BETWEEN :minAge AND :maxAge")
fun loadAllUsersBetweenAges(minAge: Int, maxAge: Int): Array<User>

@Query("SELECT * FROM user WHERE first_name LIKE :search " +
       "OR last_name LIKE :search")
fun findUserWithName(search: String): List<User>
```

### Pass a Collection of Parameters to a Query

Room understands when a parameter represents a collection and automatically expands it at runtime based on the number of parameters provided.

Pass in a variable number of parameters that is not known until runtime:
```kotlin
@Query("SELECT * FROM user WHERE region IN (:regions)")
fun loadUsersFromRegions(regions: List<String>): List<User>
```

### Query Multiple Tables

Use JOIN clauses to reference more than one table.

> [!NOTE]
> To model relationships between entities instead of joining tables manually, see [Relationships](relationship-overview.md).

```kotlin
@Query(
    "SELECT * FROM book " +
    "INNER JOIN loan ON loan.book_id = book.id " +
    "INNER JOIN user ON user.id = loan.user_id " +
    "WHERE user.name LIKE :userName"
)
fun findBooksBorrowedByNameSync(userName: String): List<Book>
```

Define simple objects to return a subset of columns from multiple joined tables:
```kotlin
interface UserBookDao {
    @Query(
        "SELECT user.name AS userName, book.name AS bookName " +
        "FROM user, book " +
        "WHERE user.id = book.user_id"
    )
    fun loadUserAndBookNames(): LiveData<List<UserBook>>

    // You can also define this class in a separate file.
    data class UserBook(val userName: String?, val bookName: String?)
}
```

### Return a Multimap

**Requires Room 2.4+**

Query columns from multiple tables without an extra data class by returning a multimap.

Return a mapping of User to Book directly instead of a custom data class:
```kotlin
@Query(
    "SELECT * FROM user " +
    "JOIN book ON user.id = book.user_id"
)
fun loadUserAndBookNames(): Map<User, List<Book>>
```

Use GROUP BY clauses for advanced calculations and filtering:
```kotlin
@Query(
    "SELECT * FROM user " +
    "JOIN book ON user.id = book.user_id " +
    "GROUP BY user.name HAVING COUNT(book.id) >= 3"
)
fun loadUserAndBookNames(): Map<User, List<Book>>
```

Return mappings between specific columns in the query by setting the `keyColumn` and `valueColumn` attributes in a `@MapInfo` annotation on the query method:
```kotlin
@MapInfo(keyColumn = "userName", valueColumn = "bookName")
@Query(
    "SELECT user.name AS username, book.name AS bookname FROM user " +
    "JOIN book ON user.id = book.user_id"
)
fun loadUserAndBookNames(): Map<String, List<String>>
```

## Special Return Types

Room provides special return types for integration with other libraries.

### Paginated Queries with the Paging Library

**Requires Room 2.3.0-alpha01+**

Room supports paginated queries through integration with the [Paging library](https://developer.android.com/topic/libraries/architecture/paging). DAOs can return [`PagingSource`](https://developer.android.com/reference/kotlin/androidx/paging/PagingSource) objects for use with [Paging 3](https://developer.android.com/topic/libraries/architecture/paging/v3-overview).

```kotlin
@Dao
interface UserDao {
  @Query("SELECT * FROM users WHERE label LIKE :query")
  fun pagingSource(query: String): PagingSource<Int, User>
}
```

### Direct Cursor Access

> [!CAUTION]
> The Cursor API doesn't guarantee that rows exist or what values they contain. Only use it if you already have code that expects a cursor and can't easily refactor it.

To give your app's logic direct access to the returned rows, write a DAO method that returns a [`Cursor`](https://developer.android.com/reference/kotlin/android/database/Cursor) object.

```kotlin
@Dao
interface UserDao {
    @Query("SELECT * FROM user WHERE age > :minAge LIMIT 5")
    fun loadRawUsersOlderThan(minAge: Int): Cursor
}
```
