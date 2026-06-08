# Relationship Overview

You can define relationships between entities. Unlike most object-relational mapping libraries, Room forbids entity objects from referencing each other directly; define a relationship between them instead.

## Types of Relationships

Room supports the following relationship types:

- [**One-to-one**](relationship-one-to-one.md): A single entity is related to another single entity.
- [**One-to-many**](relationship-one-to-many.md): A single entity can be related to multiple entities of another type.
- [**Many-to-many**](relationship-many-to-many.md): Multiple entities of one type can be related to multiple entities of another type. This usually requires a junction table.
- [**Nested Relationships (using embedded objects)**](relationship-nested.md): An entity contains another entity as a field, and this nested entity can further contain other entities. This uses the `@Embedded` annotation.

## Choose Between Two Approaches

Two ways to define and query a relationship between entities:
- An intermediate data class with embedded objects.
- A relational query method with a multimap return type.

> [!TIP]
> Use the multimap return type unless you have a specific reason to use intermediate data classes. See [Return a Multimap](dao.md#return-a-multimap).

The intermediate data class approach avoids complex SQL but requires extra data classes; the multimap approach needs no extra classes but puts more work in the SQL query.

### Use the Intermediate Data Class Approach

Define a data class that models the relationship between Room entities. This data class holds the pairings between instances of one entity and instances of another entity as [embedded objects](../api/annotations/embedded.md). The query methods then return instances of this data class for use in the app.
```kotlin
@Dao
interface UserBookDao {
    @Query(
        "SELECT user.name AS userName, book.name AS bookName " +
        "FROM user, book " +
        "WHERE user.id = book.user_id"
    )
    fun loadUserAndBookNames(): LiveData<List<UserBook>>
}

data class UserBook(val userName: String?, val bookName: String?)
```

### Use the Multimap Return Types Approach

**Requires Room 2.4+**

Define a multimap return type for the method based on the map structure, and define the relationship between the entities directly in the SQL query.

```kotlin
@Query(
    "SELECT * FROM user " +
    "JOIN book ON user.id = book.user_id"
)
fun loadUserAndBookNames(): Map<User, List<Book>>
```

## Create Embedded Objects

Use the [`@Embedded`](../api/annotations/embedded.md) annotation to represent an object decomposed into its subfields within a table.

For example, a `User` class can include an `Address` field composed of `street`, `city`, `state`, and `postCode`. Annotate the `Address` field with `@Embedded` to store its columns directly in the `User` table:

```kotlin
data class Address(
    val street: String?,
    val state: String?,
    val city: String?,
    @ColumnInfo(name = "post_code") val postCode: Int,
)

@Entity
data class User(
    @PrimaryKey val id: Int,
    val firstName: String?,
    @Embedded val address: Address?,
)
```

The table representing a `User` object then contains columns with the following names: `id`, `firstName`, `street`, `state`, `city`, and `post_code`.

> [!NOTE]
> Embedded fields can also include other embedded fields.

When an entity has multiple embedded fields of the same type, set the `prefix` property to keep each column name unique. Room prepends the value to each column name in the embedded object.


