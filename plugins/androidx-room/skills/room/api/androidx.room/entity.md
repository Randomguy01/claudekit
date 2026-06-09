# API Reference

> Last updated 2026-06-05

# Entity

> Added in 2.0.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation Entity
```

Marks a class as an entity. Creates a mapping SQLite table in the database.

Each entity must have at least 1 field annotated with [`@PrimaryKey`](primary-key.md) or set the `primaryKeys` attribute.

Each entity class must have either a no-arg constructor or a constructor whose parameters match properties (based on type and name). If a constructor does not have all properties as parameters, the missing properties must either be public or have a public setter. If you don't want Room to use a constructor, annotate it with [`@Ignore`](ignore.md).

Room persists all properties of classes marked `@Entity`. To exclude properties, mark them with [`@Ignore`](ignore.md).

**`transient` properties are automatically ignored, unless marked with [`@ColumnInfo`](column-info.md), [`@Embedded`](embedded.md), or [`@Relation`](relation.md).**

Example:
```kotlin
@Entity
data class Song (
    @PrimaryKey
    val id: Long,
    val name: String,
    @ColumnInfo(name = "release_year")
    val releaseYear: Int
)
```

|      See also     |
|-------------------|
| [`Dao`](dao.md)               |
| [`Database`](database.md)     |
| [`PrimaryKey`](primary-key.md) |
| [`ColumnInfo`](column-info.md) |
| [`Index`](index.md)           |

## Public Constructors

### Entity

> Added in 2.8.4

```
Entity(
    tableName: String = "",
    indices: Array<Index> = [],
    inheritSuperIndices: Boolean = false,
    primaryKeys: Array<String> = [],
    foreignKeys: Array<ForeignKey> = [],
    ignoredColumns: Array<String> = []
)
```

## Public Properties

### foreignKeys

```
val foreignKeys: Array<ForeignKey>
```

List of [`ForeignKey`](foreign-key.md) constraints on this entity.

### ignoredColumns

```
val ignoredColumns: Array<String>
```

The list of column names that should be ignored by Room.

**Use this to ignore properties inherited from parents or [`Embedded`](embedded.md)**

### indices

```
val indices: Array<Index>
```

List of indices on the table.

### inheritSuperIndices

```
val inheritSuperIndices: Boolean
```

If set to `true`, this `Entity` will inherit indices from parent classes. 

**Setting this to true will override any parent entities with `inheritSuperIndices = false`**

Inherited indices are **always** renamed following the default naming convention. See [`@Index`](index.md) for the naming convention.

**Parent indices are dropped by default** producing a [`RoomWarning`](room-warnings.md) at compile time.

### primaryKeys

```
val primaryKeys: Array<String>
```

The list of Primary Key column names.

**To define an auto generated primary key** see [`@PrimaryKey`](primary-key.md).

### tableName

```
val tableName: String
```

The table name in the SQLite database. If not set, defaults to the class name.
