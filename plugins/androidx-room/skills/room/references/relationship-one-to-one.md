# One-to-One Relationship

A one-to-one relationship between two entities is a relationship where each instance of the parent entity corresponds to exactly one instance of the child entity, and the reverse is also true.

Follow these steps to define and query one-to-one relationships in a database:
1. **Define the relationship**: Create classes for both entities, ensuring one references the other's primary key.
2. **Query the entities**: Model the relationship in a new data class and create a method to retrieve the related data.

## Define the Relationship

To define a one-to-one relationship, first create a class for each of your two entities. One of the entities must include a variable that is a reference to the primary key of the other entity.
```kotlin

@Entity
data class User(
    @PrimaryKey val userId: Long,
    val name: String,
    val age: Int,
)

@Entity
data class Library(
    @PrimaryKey val libraryId: Long,
    val userOwnerId: Long,
)
```

## Query the Entities

To query the list of users and corresponding libraries, you must first model the one-to-one relationship between the two entities.

To do this, create a new data class where each instance holds an instance of the parent entity and the corresponding instance of the child entity. Add the [`@Relation`](../api/annotations/relation.md) annotation to the instance of the child entity, with `parentColumn` set to the name of the primary key column of the parent entity and `entityColumn` set to the name of the column of the child entity that references the parent entity's primary key.

```kotlin
data class UserAndLibrary(
    @Embedded val user: User,
    @Relation(
        parentColumn = "userId",
        entityColumn = "userOwnerId",
    )
    val library: Library,
)
```

Finally, add a method to the DAO class that returns all instances of the data class that pairs the parent entity and the child entity. This method requires Room to run two queries. You should therefore add the [`@Transaction`](../api/annotations/transaction.md) annotation to this method. This ensures that the whole operation runs atomically.

```kotlin
@Transaction
@Query("SELECT * FROM User")
fun getUsersAndLibraries(): List<UserAndLibrary>
```
