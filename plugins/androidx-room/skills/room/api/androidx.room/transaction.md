# API Reference

> Last updated 2026-06-05

# Transaction

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Transaction
```

Marks a method in a [`Dao`](dao.md) class as a transaction method.

When used on a non-abstract method of an abstract [`Dao`](dao.md) class, the derived implementation of the method will execute the super method in a database transaction. All the parameters and return types are preserved. The transaction will be marked as successful unless an exception is thrown in the method body.

Example:
```kotlin
@Dao
abstract class SongDao {
    @Insert
    abstract fun insert(song: Song)
    @Delete
    abstract fun delete(song: Song)
    @Transaction
    fun insertAndDeleteInTransaction(newSong: Song, oldSong: Song) {
        // Anything inside this method runs in a single transaction.
        insert(newSong)
        delete(oldSong)
    }
}
```

When used on a [`Query`](query.md) method that has a `SELECT` statement, the generated code for the [`Query`](query.md) will be run in a transaction. There are 2 main cases where you may want to do that:

- If the result of the query is fairly big, it is better to run it inside a transaction to receive a consistent result. Otherwise, if the query result does not fit into a single `android.database.CursorWindow`, the query result may be corrupted due to changes in the database in between cursor window swaps.

- If the result of the query is a POJO with [`Relation`](relation.md) fields, these fields are queried separately. To receive consistent results between these queries, you also want to run them in a single transaction.

Example:
```kotlin
data class AlbumWithSongs : Album (
    @Relation(parentColumn = "albumId", entityColumn = "songId")
    val songs: List<Song>
)

@Dao
public interface AlbumDao {
    @Transaction
    @Query("SELECT * FROM album")
    fun loadAll(): List<AlbumWithSongs>
}
```

If the query is asynchronous (e.g. returns a `androidx.lifecycle.LiveData` or RxJava Flowable), the transaction is properly handled when the query is run, not when the method is called.

Putting this annotation on an [`Insert`](insert.md), [`Update`](update.md) or [`Delete`](delete.md) method has no impact because those methods are always run inside a transaction. Similarly, if a method is annotated with [`Query`](query.md) but runs an INSERT, UPDATE or DELETE statement, it is automatically wrapped in a transaction and this annotation has no effect. Room will only perform at most one transaction at a time, additional transactions are queued and executed on a first come, first serve order.

## Public Constructors

### Transaction

```
Transaction()
```
