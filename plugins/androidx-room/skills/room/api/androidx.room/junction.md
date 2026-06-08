# API Reference

> Last updated 2026-06-08

# Junction

> Added in 2.2.0

```
@Target(allowedTargets = [])
@Retention(value = AnnotationRetention.BINARY)
annotation Junction
```

Declares a junction to be used for joining a relationship.

If a [`@Relation`](relation.md) should use an associative table (also known as a junction table or join table), use this annotation to reference such a table. This is useful for fetching many-to-many relations.

```kotlin
@Entity(primaryKeys = ["pId", "sId"])
data class PlaylistSongXRef(
  val pId: Int,
  val sId: Int
)

data class PlaylistWithSongs(
  @Embedded
  val playlist: Playlist,
  @Relation(
    parentColumn = "playlistId",
    entity = Song::class,
    entityColumn = "songId",
    associateBy = Junction(
      value = PlaylistSongXRef::class,
      parentColumn = "pId",
      entityColumn = "sId"
    )
  )
  val songs: List<String>
)

@Dao
interface MusicDao {
  @Query("SELECT * FROM Playlist")
  fun getAllPlaylistsWithSongs(): List<PlaylistWithSongs>
}
```

In the example above, the many-to-many relationship between a `Song` and a `Playlist` has an associative table defined by the entity `PlaylistSongXRef`.

|       See also       |
| -------------------- |
| [`Relation`](relation.md) |

## Public Constructors

### Junction

> Added in 2.8.4

```
Junction(value: KClass<*>, parentColumn: String = "", entityColumn: String = "")
```

## Public Properties

### entityColumn

```
val entityColumn: String
```

The junction column that will be used to match against [`Relation.entityColumn`](relation.md#entitycolumn). If not specified, it defaults to `Relation.entityColumn`.

### parentColumn

```
val parentColumn: String
```

The junction column that will be used to match against [`Relation.parentColumn`](relation.md#parentcolumn). If not specified, it defaults to `Relation.parentColumn`.

### value

```
val value: KClass<*>
```

An entity or database view to be used as a junction table when fetching the relating entities.
