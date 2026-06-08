# Entity

Each entity corresponds to a table in the Room database, and each instance represents a row in the table. Use Room entities to define the database schema.

## Defining an Entity

- Define each Room entity as a class annotated with [`@Entity`](../api/annotations/entity.md). 
- A Room entity includes fields for each column in the table, including one or more columns that make up the [primary key](../api/annotations/primary-key.md).

```kotlin
@Entity
data class User(
    @PrimaryKey val id: Int,
    val firstName: String?,
    val lastName: String?,
)
```

> [!NOTE]
> Room must be able to access each persisted field. Make a field accessible by declaring it public or by providing getter and setter methods.

## Naming an Entity

- Room uses the class name as the table name. Set the `tableName` property of [`@Entity`](../api/annotations/entity.md) to override it.
- Room uses the field names as column names. Add the [`@ColumnInfo`](../api/annotations/column-info.md) annotation to a field and set its `name` property to override.

```kotlin
@Entity(tableName = "users")
data class User (
    @PrimaryKey val id: Int,
    @ColumnInfo(name = "first_name") val firstName: String?,
    @ColumnInfo(name = "last_name") val lastName: String?,
)
```

> [!NOTE]
> Table and column names in SQLite are case-insensitive.

## Primary Key

Each Room entity must define a primary key that uniquely identifies each row in its table.

Annotate a single column with [`@PrimaryKey`](../api/annotations/primary-key.md):
```kotlin
@Entity
data class User(
    @PrimaryKey val id: Int,
    val firstName: String?,
    val lastName: String?,
)
```

> [!NOTE]
> To have Room assign automatic IDs to entity instances, set the `autoGenerate` property of `@PrimaryKey` to `true`.

Define a composite primary key by listing the columns in the `primaryKeys` property of [`@Entity`](../api/annotations/entity.md):
```kotlin
@Entity(primaryKeys = ["firstName", "lastName"])
data class User(
    val firstName: String?,
    val lastName: String?,
)
```

## Ignore Fields

To exclude fields from persistence, annotate them with [`@Ignore`](../api/annotations/ignore.md):
```kotlin
@Entity
data class User(
    @PrimaryKey val id: Int,
    val name: String?,
    @Ignore val picture: Bitmap?,
)
```

When an entity inherits fields from a parent entity, use the `ignoredColumns` property of the [`@Entity`](../api/annotations/entity.md) attribute.
```kotlin
open class User {
    var picture: Bitmap? = null
}

@Entity(ignoredColumns = ["picture"])
data class RemoteUser(
    @PrimaryKey val id: Int,
    val hasVpn: Boolean,
) : User()
```

## Full-Text Search

**Requires Room 2.1.0+ and `minSdkVersion` >= 16**

For very quick access to database information through full-text search (FTS), have your entities backed by a virtual table that uses either the FTS3 or FTS4 SQLite extension module. Add the [`@Fts3`](../api/annotations/fts3.md) or [`@Fts4`](../api/annotations/fts4.md) annotation.
```kotlin
// Use `@Fts3` only if your app has strict disk space requirements or if you require compatibility with an older SQLite version.
@Fts4
@Entity(tableName = "users")
data class User(
    /* Specifying a primary key for an FTS-table-backed entity is optional, but
       if you include one, it must use this type and column name. */
    @PrimaryKey @ColumnInfo(name = "rowid") val id: Int,
    @ColumnInfo(name = "first_name") val firstName: String?,
)
```

> [!NOTE]
> FTS-enabled tables always use a primary key of type `INTEGER` with the column name `"rowid"`. If your FTS-table-backed entity defines a primary key, it **must** use that type and column name.

In cases where a table supports content in multiple languages, use the `languageId` option to specify the column that stores language information for each row.
```kotlin
@Fts4(languageId = "lid")
@Entity(tableName = "users")
data class User(
    // ...
    @ColumnInfo(name = "lid") val languageId: Int,
)
```

Room provides several other options for defining FTS-backed entities, including result ordering, tokenizer types, and tables managed as external content. For more details about these options, see the [`FtsOptions`](../api/objects/fts-options.md) reference.

## Table Index

Index columns to speed up queries that filter or sort on them. Add the `indices` property within the [`@Entity`](../api/annotations/entity.md) annotation.
```kotlin
@Entity(indices = [Index(value = ["last_name", "address"])])
data class User(
    @PrimaryKey val id: Int,
    val firstName: String?,
    val address: String?,
    @ColumnInfo(name = "last_name") val lastName: String?,
)
```

Enforce uniqueness by setting the `unique` property of an [`@Index`](../api/annotations/index.md) annotation to `true`. 
```kotlin
@Entity(indices = [Index(value = ["first_name", "last_name"], unique = true)])
data class User(
    @PrimaryKey val id: Int,
    @ColumnInfo(name = "first_name") val firstName: String?,
    @ColumnInfo(name = "last_name") val lastName: String?,
)
```

## AutoValue-Based Objects

> [!NOTE]
> This capability is for Java-based entities only. Use data classes for Kotlin-based entities.

**Requires Room 2.1.0 or above**

Use Java-based immutable value classes, annotated with [`@AutoValue`](../api/auto-value.md), when two instances of an entity should be equal if their columns contain identical values.

Annotate the class's abstract methods with [`@PrimaryKey`](../api/annotations/primary-key.md), [`@ColumnInfo`](../api/annotations/column-info.md), [`@Embedded`](../api/annotations/embedded.md), and [`@Relation`](../api/annotations/relation.md). You must include [`@CopyAnnotations`](../api/copy-annotations.md) so Room can interpret the methods' auto-generated implementations.

```kotlin
@AutoValue
@Entity
public abstract class User {
    // Supported annotations must include `@CopyAnnotations`.
    @CopyAnnotations
    @PrimaryKey
    public abstract long getId();

    public abstract String getFirstName();
    public abstract String getLastName();

    // Room uses this factory method to create User objects.
    public static User create(long id, String firstName, String lastName) {
        return new AutoValue_User(id, firstName, lastName);
    }
}
```
