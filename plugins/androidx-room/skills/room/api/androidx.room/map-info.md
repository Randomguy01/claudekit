# API Reference

> Last updated 2026-06-08

# MapInfo

> Added in 2.4.0
> Deprecated in 2.6.0

```
@Target(allowedTargets = [AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation MapInfo
```

**Deprecated — use [`@MapColumn`](map-column.md) instead.**

Declares which column(s) are used to build a map or multimap return value in a [`@Dao`](dao.md) query method.

This annotation is required when the key or value of the `Map` is a single column of one of the built-in types (primitives, boxed primitives, enum, `String`, `byte[]`, `ByteBuffer`) or a type with a converter (e.g. `Date`, `UUID`, etc.). It provides clarity on which column should be used in retrieving information required by the return type.

```kotlin
@MapInfo(keyColumn = "artistName", valueColumn = "songName")
@Query("SELECT * FROM Artist JOIN Song ON Artist.artistName = Song.artist")
fun getArtistNameToSongNames(): Map<String, List<String>>

@MapInfo(valueColumn = "songCount")
@Query("SELECT *, COUNT(mSongId) AS songCount FROM Artist JOIN Song ON Artist.artistName = Song.artist GROUP BY artistName")
fun getArtistAndSongCounts(): Map<Artist, Int>
```

To use the `@MapInfo` annotation, you must provide either the key column name, the value column name, or both, based on the `@Dao` method's return type. Column(s) specified in the provided `@MapInfo` annotation must be present in the query result.

## Public Constructors

### MapInfo

> Added in 2.8.4
> Deprecated in 2.8.4

```
MapInfo(
    keyColumn: String = "",
    keyTable: String = "",
    valueColumn: String = "",
    valueTable: String = ""
)
```

**Deprecated — use [`@MapColumn`](map-column.md) instead.**

## Public Properties

### keyColumn

```
val keyColumn: String
```

**Deprecated — use [`@MapColumn`](map-column.md) instead.**

The name of the column to be used for the map's keys.

### keyTable

```
val keyTable: String
```

**Deprecated — use [`@MapColumn`](map-column.md) instead.**

The name of the table or alias to be used for the map's keys.

Providing this value is optional. It is useful for disambiguating between duplicate column names. For example, given the query `SELECT * FROM Artist AS a JOIN Song AS s ON a.id == s.artistId`, the `@MapInfo` for a return type `Map<String, List<Song>>` would be `@MapInfo(keyColumn = "id", keyTable = "a")`.

### valueColumn

```
val valueColumn: String
```

**Deprecated — use [`@MapColumn`](map-column.md) instead.**

The name of the column to be used for the map's values.

### valueTable

```
val valueTable: String
```

**Deprecated — use [`@MapColumn`](map-column.md) instead.**

The name of the table or alias to be used for the map's values.

Providing this value is optional. It is useful for disambiguating between duplicate column names. For example, given the query `SELECT * FROM Song AS s JOIN Artist AS a ON s.artistId == a.id`, the `@MapInfo` for a return type `Map<Song, String>` would be `@MapInfo(valueColumn = "id", valueTable = "a")`.
