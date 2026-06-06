# Relationship Overview

**You can define relationships between entities, but Room explicitly forbids entity objects from referencing each other, instead use relationships**

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

**Use multimap unless you have a specific reason to use intermediate data classes**

Intermediate data classes avoid writing complex SQL queries, but can also result in increased code complexity because it requires additional data classes.

The multimap return type approach requires your SQL queries to do more work, and the intermediate data class approach requires your code to do more work.

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

Example:
```kotlin
@Query(
    "SELECT * FROM user " +
    "JOIN book ON user.id = book.user_id"
)
fun loadUserAndBookNames(): Map<User, List<Book>>
```

## Create Embedded Objects

Use the [`@Embedded`](../api/annotations/embedded.md) annotation to represent an object decomposed into its subfields within a table.

For example, your `User` class can include a field of type `Address` that represents a composition of fields named `street`, `city`, `state`, and `postCode`. To store the composed columns separately in the table, include an `Address` field. This should appear in the `User` class annotated with `@Embedded`. The following code snippet demonstrates this:

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

**Embedded fields can also include other embedded fields**

If an entity has multiple embedded fields of the same type, you can keep each column unique by setting the `prefix` property. Room then adds the provided value to the beginning of each column name in the embedded object.


