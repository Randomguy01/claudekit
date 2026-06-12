# Models and mappers

Each data source and each layer should work with the model that suits it. Don't leak a network or database model out of the data layer.

## Trim external models to what the app needs

A data source often returns more than the app needs. Define your own model and expose only the required fields. Given a verbose network model:

```kotlin
data class ArticleApiModel(
    val id: Long,
    val title: String,
    val content: String,
    val publicationDate: Date,
    val modifications: Array<ArticleApiModel>,
    val comments: Array<CommentApiModel>,
    val lastModificationDate: Date,
    val authorId: Long,
    val authorName: String,
    val authorDateOfBirth: Date,
    val readTimeMin: Int,
)
```

expose a trimmed domain model:

```kotlin
data class Article(
    val id: Long,
    val title: String,
    val content: String,
    val publicationDate: Date,
    val authorName: String,
    val readTimeMin: Int,
)
```

Separating models this way:

- Saves memory by carrying only what's needed.
- Adapts external types to the app's types — for example, a different date representation.
- Improves separation of concerns — teams can work on the network and UI sides independently once the model is agreed.

> [!IMPORTANT]
> At minimum, define a new model whenever a data source returns data that doesn't match what the rest of the app expects.

## Three models in an offline-first repository

A repository with both a network and a local source typically has three representations of the same concept, each owned by its layer:

- a **network model** — how the data is serialized over the wire (`NetworkAuthor`)
- a **local entity** — how it's persisted (`AuthorEntity`, a Room `@Entity`)
- an **external / domain model** — what the data layer exposes (`Author`)

Keep the network model and the entity **internal to the data layer**, and expose only the third type. This protects higher layers from minor changes to either source that don't change the app's behavior.

A common directory layout:

```
data/
├─ local/
│  ├─ entities/AuthorEntity
│  ├─ dao/
│  └─ AppDatabase
├─ network/
│  ├─ models/NetworkAuthor
│  └─ ...
├─ model/Author
└─ repository/
```

## Mappers

Map between representations with extension functions named for the direction:

```kotlin
// network → local, for persisting by the local data source
fun NetworkAuthor.asEntity() = AuthorEntity(/* ... */)

// local → external, for layers outside the data layer
fun AuthorEntity.asExternalModel() = Author(/* ... */)
```

> [!NOTE]
> In a multi-module app, mappers often bridge models defined in different modules. Define each mapper in the module that uses it, to avoid coupling the modules together.
