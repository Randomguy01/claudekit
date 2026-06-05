# One-to-Many Relationship

A one-to-many relationship between two entities is a relationship where each instance of the parent entity corresponds to zero or more instances of the child entity, but each instance of the child entity can only correspond to exactly one instance of the parent entity.

efine and query one-to-many relationships in your database:
1. **Define the relationship**: Create classes for both entities, with the child entity referencing the parent's primary key.
2. **Query the entities**: Model the relationship in a new data class and implement a method to retrieve the related data.

## Define the Relationship

To define a one-to-many relationship, first create a class for the two entities. As in a one-to-one relationship, the child entity must include a variable that is a reference to the primary key of the parent entity.

```kotlin
@Entity
data class User(
    @PrimaryKey val userId: Long,
    val name: String,
    val age: Int,
)

@Entity
data class Playlist(
    @PrimaryKey val playlistId: Long,
    val userCreatorId: Long,
    val playlistName: String,
)
```

## Query the Entities

To do this, create a new data class where each instance holds an instance of the parent entity and a list of all corresponding child entity instances. Add the [`@Relation`](../api/relation.md) annotation to the instance of the child entity, with `parentColumn` set to the name of the primary key column of the parent entity and `entityColumn` set to the name of the column of the child entity that references the parent entity's primary key.

```kotlin
data class UserWithPlaylists(
    @Embedded val user: User,
    @Relation(
          parentColumn = "userId",
          entityColumn = "userCreatorId"
    )
    val playlists: List<Playlist>
)
```

Finally, add a method to the DAO class that returns all instances of the data class that pairs the parent entity and the child entity. This method requires Room to run two queries, so add the [`@Transaction`](../api/transaction.md) annotation to this method so that the whole operation is performed atomically.

```kotlin
@Transaction
@Query("SELECT * FROM User")
fun getUsersWithPlaylists(): List<UserWithPlaylists>
```
