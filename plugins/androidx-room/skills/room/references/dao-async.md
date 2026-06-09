# Asynchronous DAO Queries

To prevent queries from blocking the UI, Room does not allow database access on the main thread, so [DAO queries](dao.md) must be asynchronous.

DAO queries fall into three categories:

- *One-shot write* queries that insert, update, or delete.
- *One-shot read* queries that read data only once and return a result with a snapshot of the data.
- *Observable read* queries that read data every time the underlying database tables change and emit new values.

## Language and Framework Options

Return types by query type:
| Query type      | Kotlin language features |
|-----------------|--------------------------|
| One-shot write  | Coroutines (`suspend`)   |
| One-shot read   | Coroutines (`suspend`)   |
| Observable read | `Flow<T>`                |

### Kotlin with Flow and Coroutines

Kotlin provides language features for writing asynchronous queries without third-party frameworks:
- **Room 2.2+** Use Kotlin's [`Flow`](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/-flow/) functionality to write observable queries.
- **Room 2.1+** Use the `suspend` keyword to make your DAO queries asynchronous using [Kotlin coroutines](https://developer.android.com/kotlin/coroutines).

> [!NOTE]
> Kotlin Flow and coroutines with Room require the `room-ktx` artifact. See [Installation Reference](install.md).

## Write Asynchronous One-Shot Queries

One-shot queries are database operations that only run once and grab a snapshot of data at the time of execution.

```kotlin
@Dao
interface UserDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertUsers(vararg users: User)

    @Update
    suspend fun updateUsers(vararg users: User)

    @Delete
    suspend fun deleteUsers(vararg users: User)

    @Query("SELECT * FROM user WHERE id = :id")
    suspend fun loadUserById(id: Int): User

    @Query("SELECT * FROM user WHERE region IN (:regions)")
    suspend fun loadUsersByRegion(regions: List<String>): List<User>
}
```

## Write Observable Queries

Observable queries are read operations that emit new values whenever any referenced table changes. Use them to keep a displayed list up to date as items are inserted, updated, or removed.

```kotlin
@Dao
interface UserDao {
    @Query("SELECT * FROM user WHERE id = :id")
    fun loadUserById(id: Int): Flow<User>

    @Query("SELECT * FROM user WHERE region IN (:regions)")
    fun loadUsersByRegion(regions: List<String>): Flow<List<User>>
}
```

> [!NOTE]
> Observable queries have one important limitation: the query reruns whenever any row in the table changes, even a row outside the result set. Apply the `distinctUntilChanged()` operator to notify the UI only when the actual results change.
