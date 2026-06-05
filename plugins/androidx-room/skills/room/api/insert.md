# API Reference

> Last updated 2026-06-05

# Insert

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Insert
```

Marks a method in a [`Dao`](dao.md) annotated class as an insert method.

The generated implementation of the method will insert its parameters into the database.

All of the parameters of the Insert method must either be classes annotated with [`Entity`](entity.md) or collections/array of it.

Example:
```kotlin
@Dao
interface MusicDao {
  @Insert(onConflict = OnConflictStrategy.REPLACE)
  fun insertSongs(varargs songs: Song)

  @Insert
  fun insertBoth(song1: Song, song2: Song)

  @Insert
  fun insertAlbumWithSongs(album: Album, songs: List<Song>)
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
  @Insert(entity = Playlist::class)
  fun insertNewPlaylist(nameDescription: NameAndDescription)
}
```

|      See also       |
|---------------------|
| [`Update`](update.md) |
| [`Delete`](delete.md) |

## Public Constructors

### Insert

> Added in 2.8.4

```
Insert(
    entity: KClass<*> = Any::class,
    onConflict: Int = OnConflictStrategy.ABORT
)
```

## Public Properties

### entity

```
val entity: KClass<*>
```

The target entity of the insert method.

When this is declared, the insert method parameters are interpreted as partial entities when the type of the parameter differs from the target. The POJO class that represents the entity must contain all of the non-null fields without default values of the target entity.

If the target entity contains a [`PrimaryKey`](primary-key.md) that is auto generated, then the POJO class doesn't need an equal primary key field, otherwise primary keys must also be present in the POJO.

By default the target entity is interpreted by the method parameters.

### onConflict

```
val onConflict: Int
```

What to do if a conflict happens.

Use [`OnConflictStrategy.ABORT`]() (default) to roll back the transaction on conflict. Use [`OnConflictStrategy.REPLACE`]() to replace the existing rows with the new rows. Use [`OnConflictStrategy.IGNORE`]() to keep the existing rows.
