# API Reference

> Last updated 2026-06-08

# Relation

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.FIELD, AnnotationTarget.FUNCTION])
@Retention(value = AnnotationRetention.BINARY)
annotation Relation
```

A convenience annotation which can be used in a POJO to automatically fetch relation entities. When the POJO is returned from a query, all of its relations are also fetched by Room.

```kotlin
@Entity
data class Song(
  @PrimaryKey
  val songId: Int,
  val albumId: Int,
  val name: String
  // other fields
)

data class AlbumNameAndAllSongs(
  val id: Int,
  val name: String,
  @Relation(parentColumn = "id", entityColumn = "albumId")
  val songs: List<Song>
)

@Dao
interface MusicDao {
  @Query("SELECT id, name FROM Album")
  fun loadAlbumAndSongs(): List<AlbumNameAndAllSongs>
}
```

For a one-to-many or many-to-many relationship, the type of the field annotated with `@Relation` must be a `List` or `Set`.

By default, the `Entity` type is inferred from the return type. To return a different object, specify the `entity` property in the annotation:

```kotlin
data class Album(
  val id: Int
  // other fields
)

data class SongNameAndId(
  val songId: Int,
  val name: String
)

data class AlbumAllSongs(
  @Embedded
  val album: Album,
  @Relation(parentColumn = "id", entityColumn = "albumId", entity = Song::class)
  val songs: List<SongNameAndId>
)

@Dao
interface MusicDao {
  @Query("SELECT * FROM Album")
  fun loadAlbumAndSongs(): List<AlbumAllSongs>
}
```

Above, `SongNameAndId` is a regular POJO whose fields are all fetched from the `entity` defined in the `@Relation` annotation, `Song`. `SongNameAndId` could also define its own relations, which would be fetched automatically.

To specify which columns are fetched from the child entity, use the `projection` property:

```kotlin
data class AlbumAndAllSongs(
  @Embedded
  val album: Album,
  @Relation(
    parentColumn = "id",
    entityColumn = "albumId",
    entity = Song::class,
    projection = ["name"]
  )
  val songNames: List<String>
)
```

If the relationship is defined by an associative table (also known as a junction table), use `associateBy` to specify it. This is useful for fetching many-to-many relations.

The `@Relation` annotation can be used only in POJO classes; an `Entity` class cannot have relations. This is a design decision to avoid common pitfalls in `Entity` setups. Work around this limitation by creating POJO classes that extend the `Entity`.

|         See also         |
| ------------------------ |
| [`Junction`](junction.md) |

## Public Constructors

### Relation

> Added in 2.8.4

```
Relation(
    entity: KClass<*> = Any::class,
    parentColumn: String,
    entityColumn: String,
    associateBy: Junction = Junction(Any::class),
    projection: Array<String> = []
)
```

## Public Properties

### associateBy

```
val associateBy: Junction
```

The entity or view to be used as an associative table (also known as a junction table) when fetching the relating entities. By default, no junction is specified and none will be used.

|         See also         |
| ------------------------ |
| [`Junction`](junction.md) |

### entity

```
val entity: KClass<*>
```

The entity or view to fetch the item from. You don't need to set this if the entity or view matches the type argument in the return type. By default, inherited from the return type.

### entityColumn

```
val entityColumn: String
```

The column to match in the `entity`.

In a one-to-one or one-to-many relation, this value is matched against the column defined in `parentColumn`. In a many-to-many using `associateBy`, this value is matched against [`Junction.entityColumn`](junction.md#entitycolumn).

### parentColumn

```
val parentColumn: String
```

Reference column in the parent POJO.

In a one-to-one or one-to-many relation, this value is matched against the column defined in `entityColumn`. In a many-to-many using `associateBy`, this value is matched against [`Junction.parentColumn`](junction.md#parentcolumn).

### projection

```
val projection: Array<String>
```

If sub columns should be fetched from the entity, you can specify them using this field. By default, inferred from the return type.
