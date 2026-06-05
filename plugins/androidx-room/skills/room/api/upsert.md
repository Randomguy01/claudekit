# API Reference

> Last updated 2026-06-05

# Upsert

> Added in 2.5.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Upsert
```

Marks a method in a [`Dao`](dao.md) annotated class as an upsert (insert or update) method.

The generated implementation of the method will insert its parameters into the database if it does not already exist (by primary key). If it already exists, it will update its parameters in the database.

All of the parameters of the upsert method must either be classes annotated with [`Entity`](entity.md) or collections/array of it.

Example:
```kotlin
@Dao
interface MusicDao {
  @Upsert
  fun upsertSongs(varargs songs: Song)

  @Upsert
  fun upsertBoth(song1: Song, song2: Song)

  @Upsert
  fun upsertAlbumWithSongs(album: Album, songs: List<Song>)
}
```

If the target entity is specified via [`entity`](#entity) then the parameters can be of arbitrary POJO types that will be interpreted as partial entities. For example:
```kotlin
@Entity
data class Playlist (
  @PrimaryKey(autoGenerate = true)
  val playlistId: Long,
  val name: String,
  val description: String?,

  @ColumnInfo(defaultValue = "normal")
  val category: String,

  @ColumnInfo(defaultValue = "CURRENT_TIMESTAMP")
  val createdTime: String,

  @ColumnInfo(defaultValue = "CURRENT_TIMESTAMP")
  val lastModifiedTime: String
)

data class NameAndDescription (
  val name: String,
  val description: String
)

@Dao
interface PlaylistDao {
  @Upsert(entity = Playlist::class)
  fun upsertNewPlaylist(nameDescription: NameAndDescription)
}
```

|      See also       |
|---------------------|
| [`Insert`](insert.md) |
| [`Update`](update.md) |

## Public Constructors

### Upsert

> Added in 2.8.4

```
Upsert(entity: KClass<*> = Any::class)
```

## Public Properties

### entity

```
val entity: KClass<*>
```

The target entity of the upsert method.

When this is declared, the upsert method parameters are interpreted as partial entities when the type of the parameter differs from the target. The POJO class that represents the entity must contain all of the non-null fields without default values of the target entity.

If the target entity contains a [`PrimaryKey`](primary-key.md) that is auto generated, then the POJO class doesn't need an equal primary key field, otherwise primary keys must also be present in the POJO. If the primary key already exists, only the columns represented by the partial entity fields will be updated.

By default the target entity is interpreted by the method parameters.
