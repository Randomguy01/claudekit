# View

**Requires Room 2.1.0+**

Room provides support for [SQLite database views](https://www.sqlite.org/lang_createview.html), allowing you to encapsulate a query into a class, called a *view*. They behave the same as simple data objects when used in a [DAO](../api/dao.md).

**`SELECT` statements can be run against views. However, you cannot run `INSERT`, `UPDATE`, or `DELETE` statements against views**

## Create a View

To create a view, add the [`@DatabaseView`](../api/database-view.md) annotation to a class. Set the annotation's value to the query that the class should represent.

Example:
```kotlin
@DatabaseView("SELECT user.id, user.name, user.departmentId, " +
        "department.name AS departmentName FROM user " +
        "INNER JOIN department ON user.departmentId = department.id")
data class UserDetail(
    val id: Long,
    val name: String?,
    val departmentId: Long,
    val departmentName: String?,
)
```

## Associate a View with Your Database

To include this view as part of your app's database, add the [`views`](../api/database.md) property to the [`@Database`](../api/database.md) annotation.

Example:
```kotlin
@Database(entities = [User::class],
          views = [UserDetail::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
}
```
