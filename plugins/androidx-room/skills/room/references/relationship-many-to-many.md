# Many-to-Many Relationship

A many-to-many relationship between two entities is a relationship where each instance of the parent entity corresponds to zero or more instances of the child entity, and the reverse is also true.

Follow these steps to define and query many-to-many relationships in your database:
1. **Define the relationship**: Establish the entities and the associative entity (cross-reference table) to represent the many-to-many relationship.
2. **Query the entities**: Determine how you want to query the related entities and create data classes to represent the intended output.

## Define the Relationship

To define a many-to-many relationship, create a class for each entity. Many-to-many relationships are distinct from other relationship types because there is generally no reference to the parent entity in the child entity. Instead, create a third class to represent an associative entity, or cross-reference table, between the two entities. The cross-reference table must have a column for each entity's primary key. In this example, each row in the cross-reference table corresponds to a pairing of a `Playlist` instance and a `Song` instance where the referenced song is included in the referenced playlist.

```kotlin
@Entity
data class Playlist(
    @PrimaryKey val playlistId: Long,
    val playlistName: String,
)

@Entity
data class Song(
    @PrimaryKey val songId: Long,
    val songName: String,
    val artist: String,
)

@Entity(primaryKeys = ["playlistId", "songId"])
data class PlaylistSongCrossRef(
    val playlistId: Long,
    val songId: Long,
)
```

## Query the Entities

The next step depends on how you want to query these related entities.
- If you want to query *playlists* and a list of the corresponding *songs* for each playlist, create a new data class that contains a single `Playlist` object and a list of all of the `Song` objects that the playlist includes.
- If you want to query *songs* and a list of the corresponding *playlists* for each, create a new data class that contains a single `Song` object and a list of all of the `Playlist` objects in which the song is included.

In either case, model the relationship between the entities by using the `associateBy` property in the [`@Relation`](../api/annotations/relation.md) annotation in each of these classes to identify the cross-reference entity providing the relationship between the `Playlist` entity and the `Song` entity.

```kotlin
data class PlaylistWithSongs(
    @Embedded val playlist: Playlist,
    @Relation(
        parentColumn = "playlistId",
        entityColumn = "songId",
        associateBy = Junction(PlaylistSongCrossRef::class),
    )
    val songs: List<Song>,
)

data class SongWithPlaylists(
    @Embedded val song: Song,
    @Relation(
        parentColumn = "songId",
        entityColumn = "playlistId",
        associateBy = Junction(PlaylistSongCrossRef::class),
    )
    val playlists: List<Playlist>,
)
```

Finally, add a method to the DAO class to expose the query function your app needs.
- `getPlaylistsWithSongs`: this method queries the database and returns all the resulting `PlaylistWithSongs` objects.
- `getSongsWithPlaylists`: this method queries the database and returns all the resulting `SongWithPlaylists` objects.

These methods each require Room to run two queries, so add the [`@Transaction`](../api/annotations/transaction.md) annotation to both methods to run the whole operation atomically.

```kotlin
@Transaction
@Query("SELECT * FROM Playlist")
fun getPlaylistsWithSongs(): List<PlaylistWithSongs>

@Transaction
@Query("SELECT * FROM Song")
fun getSongsWithPlaylists(): List<SongWithPlaylists>
```

> [!NOTE]
> If the [`@Relation`](../api/annotations/relation.md) annotation doesn't meet your use case, use the `JOIN` keyword in your SQL queries to define the relationships manually. See [Query Multiple Tables](dao.md#query-multiple-tables).
