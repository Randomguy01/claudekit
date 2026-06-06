# DAO

At compile time, Room automatically generates implementations of the DAOs.

DAOs preserve separation of concerns, a critical architectural principle. DAOs make it easier to mock database access during testing.

## Defining a DAO

- Define each DAO as either an interface (preferred) or an abstract class. 
- You must annotate it with [`@Dao`](../api/annotations/dao.md).

Example:
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

## Convenience Methods

**For more complex behavior use a query method**

### Insert

The [`@Insert`](../api/annotations/insert.md) annotation defines methods that insert their parameters into the table.

Each parameter for an `@Insert` method must be either an instance of an [entity](../api/annotations/entity.md) annotated with [`@Entity`](../api/annotations/entity.md) or a collection of data entity class instances. When an [`@Insert`](../api/annotations/insert.md) method is called, Room inserts each passed entity instance into the table.

If the [`@Insert`](../api/annotations/insert.md) method receives a single parameter, it can return the `long` value `rowId` for the inserted item. If the parameter is an array or a collection, then it can return an array or a collection of `long` values instead. To learn more about returning `rowId` values, see the reference documentation for the [`@Insert`](../api/annotations/insert.md) annotation and the [SQLite documentation for rowid tables](https://www.sqlite.org/rowidtable.html).

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

The [`@Update`](../api/annotations/update.md) annotation marks a method that updates specific rows in a database table. Like [`@Insert`](../api/annotations/insert.md) methods, [`@Update`](../api/annotations/update.md) methods accept data entity instances as parameters.

Room uses the [primary key](../api/annotations/primary-key.md) to match passed entity instances to rows in the database. If there is no row with the same primary key, Room makes no changes.

An [`@Update`](../api/annotations/update.md) method can optionally return an `int` value indicating the number of rows that were updated successfully.


```kotlin
@Dao
interface UserDao {
    @Update
    fun updateUsers(vararg users: User)
}
```

### Delete

The [`@Delete`](../api/annotations/delete.md) annotation lets you define methods that delete rows from a database table. Like [`@Insert`](../api/annotations/insert.md), [`@Delete`](../api/annotations/delete.md) accepts data entity instances as parameters.

Room uses the [primary key](../api/annotations/primary-key.md) to match passed entity instances to rows in the database. If there is no row with the same primary key, Room makes no changes.

A [`@Delete`](../api/annotations/delete.md) method can optionally return an `int` value indicating the number of rows that were deleted successfully.

```kotlin
@Dao
interface UserDao {
    @Delete
    fun deleteUsers(vararg users: User)
}
```

## Query Methods

The [`@Query`](../api/annotations/query.md) annotation defines raw SQL statements and exposes them as DAO methods. Use these query methods to query data or when you need to perform more complex insertions, updates, and deletions.

**Room validates SQL queries at compile time**

### Simple Queries

```kotlin
@Query("SELECT * FROM user")
fun loadAllUsers(): Array<User>
```

### Return a Subset of a Table's Columns

**To save resources and streamline your query's execution, only query the fields that you need**

You can return a simple object from any of your queries as long as you can map the set of result columns onto the returned object. For example, you can define the following object to hold a user's first and last name:
```kotlin
data class NameTuple(
    @ColumnInfo(name = "first_name") val firstName: String?,
    @ColumnInfo(name = "last_name") val lastName: String?,
)
```

Then, you can return that simple object from your query method:
```kotlin
@Query("SELECT first_name, last_name FROM user")
fun loadFullName(): List<NameTuple>
```

If the query returns a column that doesn't map onto a field in the returned object, Room displays a warning.

### Pass Simple Parameters to a Query

Room supports using method parameters as bind parameters in your queries.

Example:
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

You can use JOIN clauses in your SQL queries to reference more than one table.

Example:
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

Query columns from multiple tables without defining an additional data class by writing query methods that return a multimap.

Instead of returning a list of instances of a custom data class that holds pairings of User and Book instances, you can return a mapping of User and Book directly:
```kotlin
@Query(
    "SELECT * FROM user " +
    "JOIN book ON user.id = book.user_id"
)
fun loadUserAndBookNames(): Map<User, List<Book>>
```

You can write queries that use GROUP BY clauses, letting you take advantage of SQL's capabilities for advanced calculations and filtering:
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

Room provides some special return types for integration with other API libraries.

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

**Caution: NOT RECOMMENDED: The Cursor API doesn't guarantee that the rows exist or what values the rows contain. Only use this functionality if you already have code that expects a cursor and that you can't refactor easily.

If your app's logic requires direct access to the return rows, you can write your DAO methods to return a [`Cursor`](https://developer.android.com/reference/kotlin/android/database/Cursor) object.

Example:
```kotlin
@Dao
interface UserDao {
    @Query("SELECT * FROM user WHERE age > :minAge LIMIT 5")
    fun loadRawUsersOlderThan(minAge: Int): Cursor
}
```
