# Repositories and data sources

The data layer is made of **repositories**, each containing zero to many **data sources**. Create one repository per type of data you handle — `MoviesRepository` for movie data, `PaymentsRepository` for payments.

## Responsibilities

A repository is responsible for:

- Exposing data to the rest of the app.
- Centralizing changes to the data.
- Resolving conflicts between multiple data sources.
- Abstracting the sources of data from the rest of the app.
- Containing business logic.

A data source works with **only one** source of data — a file, a network endpoint, or a local database. It is the bridge between the app and the system for data operations.

> [!IMPORTANT]
> Repositories are the only entry point to the data layer. Higher layers — state holders in the UI layer, use cases in the domain layer — must never depend on a data source directly. Routing everything through repositories lets the layers scale independently.

## Immutability

The data this layer exposes must be **immutable**, so other classes can't tamper with it and put it in an inconsistent state. Immutable data is also safe to hand across threads — see `source-of-truth-and-lifecycle.md`.

## Constructor injection

Following dependency-injection best practices, a repository takes its data sources as constructor parameters:

```kotlin
class ExampleRepository(
    private val exampleRemoteDataSource: ExampleRemoteDataSource, // network
    private val exampleLocalDataSource: ExampleLocalDataSource,    // database
) { /* ... */ }
```

Wire these dependencies with the `hilt` skill.

> [!NOTE]
> When a repository has a single data source and depends on no other repositories, it's common to merge the data-source responsibilities into the repository class. If you do, remember to split them back out when the repository later needs a second source.

## Naming conventions

Name a repository after the data it owns — *type of data* + `Repository`: `NewsRepository`, `MoviesRepository`, `PaymentsRepository`.

Name a data source after the data and its source — *type of data* + *type of source* + `DataSource`. Use **Remote** or **Local** to stay generic (`NewsRemoteDataSource`, `NewsLocalDataSource`), or name the concrete source when it matters (`NewsNetworkDataSource`, `NewsDiskDataSource`).

> [!WARNING]
> Don't name a data source after an implementation detail — avoid `UserSharedPreferencesDataSource`. Repositories shouldn't know how data is stored, so naming a source after its backing technology leaks that detail and blocks you from swapping the implementation (for example, SharedPreferences → DataStore) without touching the caller.

> [!NOTE]
> While migrating a data source to a new backing technology, it's fine to *temporarily* name the implementations after the technology: define a data-source interface and give it two implementations, old and new. The repository sees only the interface. Rename once the migration is done.

## Repositories that depend on repositories

When business requirements are more complex, a repository can depend on other repositories — because the data aggregates several sources, or to encapsulate a responsibility elsewhere. A `UserRepository` might depend on `LoginRepository` and `RegistrationRepository`.

> [!NOTE]
> Some teams call a repository that depends on other repositories a *manager* — `UserManager` instead of `UserRepository`. Use that convention if you prefer.
