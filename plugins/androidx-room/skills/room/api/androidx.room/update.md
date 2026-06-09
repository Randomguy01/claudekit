# API Reference

> Last updated 2026-06-05

# Update

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Update
```

Marks a method in a [`Dao`](dao.md) annotated class as an update method.

The generated implementation of the method will update its parameters in the database only if they already exist (by primary keys).

All of the parameters of the Update method must either be classes annotated with [`Entity`](entity.md) or collections/array of it.

Example:
```kotlin
@Dao
public interface MusicDao {
    @Update
    fun updateSong(song: Song)

    @Update
    fun updateSongs(songs: List<Song>): Int
}
```

If the target entity is specified via [`entity`](#entity) then the parameters can be of arbitrary POJO types that will be interpreted as partial entities. For example:
```kotlin
@Entity
data class Playlist (
    @PrimaryKey(autoGenerate = true)
    val playlistId: Long,
    val name: String,
    @ColumnInfo(defaultValue = "")
    val description: String,
    @ColumnInfo(defaultValue = "normal")
    val category: String,
    @ColumnInfo(defaultValue = "CURRENT_TIMESTAMP")
    val createdTime: String,
    @ColumnInfo(defaultValue = "CURRENT_TIMESTAMP")
    val lastModifiedTime: String
)

data class PlaylistCategory (
  val playlistId: Long,
  val category: String,
  val lastModifiedTime: String
)

@Dao
public interface PlaylistDao {
  @Update(entity = Playlist::class)
  fun updateCategory(varargs category: Category)
}
```

|      See also       |
|---------------------|
| [`Insert`](insert.md) |
| [`Delete`](delete.md) |

## Public Constructors

### Update

> Added in 2.8.4

```
Update(
    entity: KClass<*> = Any::class,
    onConflict: Int = OnConflictStrategy.ABORT
)
```

## Public Properties

### entity

```
val entity: KClass<*>
```

The target entity of the update method.

When this is declared, the update method parameters are interpreted as partial entities when the type of the parameter differs from the target. The POJO class that represents the entity must contain a subset of the fields of the target entity along with its primary keys.

Only the columns represented by the partial entity fields will be updated if an entity with equal primary key is found.

By default the target entity is interpreted by the method parameters.

### onConflict

```
val onConflict: Int
```

What to do if a conflict happens.

Use [`OnConflictStrategy.ABORT`](on-conflict-strategy.md#abort) (default) to roll back the transaction on conflict. Use [`OnConflictStrategy.REPLACE`](on-conflict-strategy.md#replace) to replace the existing rows with the new rows. Use [`OnConflictStrategy.IGNORE`](on-conflict-strategy.md#ignore) to keep the existing rows.
