# API Reference

> Last updated 2026-06-08

# RawQuery

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation RawQuery
```

Marks a method in a [`@Dao`](dao.md) annotated class as a raw query method where you can pass the query as a `RoomRawQuery` or `SupportSQLiteQuery`.

```kotlin
@Dao
interface RawDao {
  @RawQuery
  fun getSongViaQuery(query: RoomRawQuery): Song
}

// Usage of RawDao
val query = RoomRawQuery(
  sql = "SELECT * FROM Song WHERE id = ? LIMIT 1",
  onBindStatement = { it.bindLong(1, songId) }
)
val song = rawDao.getSongViaQuery(query)
```

Room generates the code based on the return type of the function; failure to pass a proper query results in a runtime failure or an undefined result.

If you know the query at compile time, you should always prefer [`@Query`](query.md) since it validates the query at compile time and generates more efficient code (Room can compute the query result at compile time, so it does not need to account for possibly missing columns in the result).

`@RawQuery` serves as an escape hatch where you can build your own SQL query at runtime but still use Room to convert it into objects.

`@RawQuery` methods must return a non-`Unit` type. To execute a raw query that does not return any value, use the `RoomDatabase.query` methods. `@RawQuery` methods can only be used for read queries; for write queries, use `RoomDatabase.openHelper`.

**Observable Queries**

`@RawQuery` methods can return observable types, but you need to specify which tables are accessed in the query using the `observedEntities` field in the annotation.

```kotlin
@Dao
interface RawDao {
  @RawQuery(observedEntities = [Song::class])
  fun getSongs(query: RoomRawQuery): Flow<List<Song>>
}

// Usage of RawDao
val liveSongs = rawDao.getSongs(
  RoomRawQuery("SELECT * FROM song ORDER BY name DESC")
)
```

**Returning POJOs**

`@RawQuery` can also return plain old objects, similar to [`@Query`](query.md) methods.

```kotlin
data class NameAndReleaseYear(
  val name: String,
  @ColumnInfo(name = "release_year")
  val year: Int
)

@Dao
interface RawDao {
  @RawQuery
  fun getNameAndReleaseYear(query: RoomRawQuery): NameAndReleaseYear
}

// Usage of RawDao
val result: NameAndReleaseYear = rawDao.getNameAndReleaseYear(
  RoomRawQuery(
    sql = "SELECT * FROM song WHERE id = ?",
    onBindStatement = { it.bindLong(1, songId) }
  )
)
```

**POJOs with Embedded Fields**

`@RawQuery` methods can return POJOs that include [`@Embedded`](embedded.md) fields as well.

```kotlin
data class SongAndArtist(
  @Embedded
  val song: Song,
  @Embedded
  val artist: Artist
)

@Dao
interface RawDao {
  @RawQuery
  fun getSongAndArtist(query: RoomRawQuery): SongAndArtist
}

// Usage of RawDao
val result = rawDao.getSongAndArtist(
  RoomRawQuery("SELECT * FROM Song, Artist WHERE Song.artistId = Artist.id LIMIT 1")
)
```

**Relations**

`@RawQuery` return types can also be objects with [`@Relation`](relation.md).

```kotlin
data class AlbumAndSongs(
  @Embedded
  val album: Album,
  @Relation(parentColumn = "id", entityColumn = "albumId")
  val songs: List<Song>
)

@Dao
interface RawDao {
  @RawQuery
  fun getAlbumAndSongs(query: RoomRawQuery): List<AlbumAndSongs>
}

// Usage of RawDao
val result = rawDao.getAlbumAndSongs(
  RoomRawQuery("SELECT * FROM album")
)
```

## Public Constructors

### RawQuery

```
RawQuery(observedEntities: Array<KClass<*>> = [])
```

## Public Properties

### observedEntities

```
val observedEntities: Array<KClass<*>>
```

Denotes the list of entities which are accessed in the provided query and should be observed for invalidation if the query is observable.

The listed classes should either be annotated with [`@Entity`](entity.md) or reference at least one `@Entity` (via [`@Embedded`](embedded.md) or [`@Relation`](relation.md)). Providing this field in a non-observable query has no impact.

```kotlin
@Dao
interface RawDao {
  @RawQuery(observedEntities = [Song::class])
  fun getSongs(query: RoomRawQuery): Flow<List<Song>>
}

val liveSongs = rawDao.getSongs(
  RoomRawQuery("SELECT * FROM song ORDER BY name DESC")
)
```
