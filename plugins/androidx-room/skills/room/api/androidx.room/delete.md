# API Reference

> Last updated 2026-06-05

# Delete

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Delete
```

Marks a method in a [`Dao`](dao.md) annotated class as a delete method.

The generated implementation of the method will delete its parameters from the database.

All of the parameters of the Delete method must either be classes annotated with [`Entity`](entity.md) or collections/array of it.

Example:
```kotlin
@Dao
public interface MusicDao {
    @Delete
    public fun deleteSongs(vararg songs: Song)

    @Delete
    public fun deleteAlbumAndSongs(album: Album, songs: List<Song>)
}
```

If the target entity is specified via [`entity`](#entity) then the parameters can be of arbitrary POJO types that will be interpreted as partial entities. For example:
```kotlin
@Entity
data class Playlist (
    @PrimaryKey
    val playlistId: Long,
    val ownerId: Long,
    val name: String,
    @ColumnInfo(defaultValue = "normal")
    val category: String
)

data class OwnerIdAndCategory (
    val ownerId: Long,
    val category: String
)

@Dao
public interface PlaylistDao {
    @Delete(entity = Playlist::class)
    fun deleteByOwnerIdAndCategory(varargs idCategory: OwnerIdAndCategory)
}
```

|      See also       |
|---------------------|
| [`Insert`](insert.md) |
| [`Update`](update.md) |

## Public Constructors

### Delete

> Added in 2.8.4

```
Delete(entity: KClass<*> = Any::class)
```

## Public Properties

### entity

```
val entity: KClass<*>
```

The target entity of the delete method.

When this is declared, the delete method parameters are interpreted as partial entities when the type of the parameter differs from the target. The POJO class that represents the entity must contain a subset of the fields of the target entity. The fields value will be used to find matching entities to delete.

By default the target entity is interpreted by the method parameters.
