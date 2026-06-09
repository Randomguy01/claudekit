# View

**Requires Room 2.1.0+**

Room supports SQLite database views, which encapsulate a query in a class called a *view*. A view behaves like a simple data object when used in a [DAO](../api/androidx.room/dao.md).

> [!NOTE]
> Like [entities](entity.md), you can run `SELECT` statements against views, but not `INSERT`, `UPDATE`, or `DELETE` statements.

## Create a View

To create a view, add the [`@DatabaseView`](../api/androidx.room/database-view.md) annotation to a class. Set the annotation's value to the query that the class should represent.

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

To include this view as part of your app's database, add the [`views`](../api/androidx.room/database.md) property to the [`@Database`](../api/androidx.room/database.md) annotation.

```kotlin
@Database(entities = [User::class],
          views = [UserDetail::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
}
```
