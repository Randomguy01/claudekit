# API Reference

> Last updated 2026-06-05

# MapColumn

> Added in 2.6.0

```
@Target(allowedTargets = [AnnotationTarget.TYPE])
@Retention(value = AnnotationRetention.BINARY)
annotation MapColumn
```

Declares which column is used to build a map or multimap return value in a [`Dao`](dao.md) query method.

This annotation is required when the key or value of a Map (or nested map) is a single column of one of the built in types (primitives, boxed primitives, enum, String, byte[], ByteBuffer) or a type with a converter (e.g. Date, UUID, etc).

The use of this annotation provides clarity on which column should be used in retrieving information required by the return type.

Example:
```kotlin
@Query("SELECT * FROM Artist JOIN Song ON Artist.artistName = Song.artist")
fun getArtistNameToSongNames():
    Map<@MapColumn(columnName = "artistName") String,
        @MapColumn(columnName = "songName") List<String>>

@Query("SELECT *, COUNT(mSongId) as songCount FROM Artist JOIN Song ON " +
    "Artist.artistName = Song.artist GROUP BY artistName")
fun getArtistAndSongCounts(): Map<Artist, @MapColumn(columnName = "songCount") Integer>
```

Column(s) specified in the provided @MapColumn annotation must be present in the query result.

## Public Constructors

### MapColumn

> Added in 2.8.4

```
MapColumn(columnName: String, tableName: String = "")
```

## Public Properties

### columnName

```
val columnName: String
```

The name of the column to be used for the map's key or value.

### tableName

```
val tableName: String
```

The name of the table or alias to be used for the map's column.

Providing this value is optional. Useful for disambiguating between duplicate column names. For example, consider the following query: `SELECT * FROM Artist AS a JOIN Song AS s ON a.id == s.artistId`, then the `@MapColumn` for a return type `Map<String, List<Song>>` would be `Map<@MapColumn(columnName = "id", tableName = "a") String, List<Song>>`.
