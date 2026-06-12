# Exposing data

The data layer's public surface is the set of functions a repository exposes. Higher layers depend on this surface and not on the implementation, so it *is* the contract — design it deliberately, and expose immutable types only (see `repositories-and-data-sources.md`).

## One-shot operations vs. observation

For each piece of data, expose one of two shapes, depending on whether the caller needs a single result or ongoing updates:

- **One-shot CRUD** → a **`suspend` function**.
- **Notified of changes over time** → a **`Flow`**.

```kotlin
class ExampleRepository(
    private val exampleRemoteDataSource: ExampleRemoteDataSource,
    private val exampleLocalDataSource: ExampleLocalDataSource,
) {
    val data: Flow<Example> = /* ... */

    suspend fun modifyData(example: Example) { /* ... */ }
}
```

> [!NOTE]
> This skill assumes Kotlin with coroutines and flows. In a Java codebase, conform to its conventions instead — callbacks or RxJava `Single`/`Maybe`/`Completable` for one-shot calls, `Observable`/`Flowable` for streams.

## Error model

Interactions with data sources either succeed or fail; the data layer surfaces failures in a way the caller can handle. Use this hybrid by default.

### Reads (`Flow`): throw, and let the consumer catch

Expose `Flow<DomainType>` and let exceptions propagate. The consumer — typically a `ViewModel` — handles them with the `catch` operator, usually mapping into a loading/content/error (LCE) state. Don't wrap reads in `Result`: `Flow` already has `catch`, so wrapping only adds overhead.

```kotlin
// Repository: an observable read that may throw.
fun getAuthorStream(id: String): Flow<Author>
```

```kotlin
// Consumer (UI layer), shown to illustrate the contract:
sealed interface AuthorUiState {
    data object Loading : AuthorUiState
    data class Success(val author: Author) : AuthorUiState
    data object Error : AuthorUiState
}

val uiState: StateFlow<AuthorUiState> =
    authorsRepository.getAuthorStream(id)
        .map<Author, AuthorUiState> { AuthorUiState.Success(it) }
        .catch { emit(AuthorUiState.Error) }
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), AuthorUiState.Loading)
```

### Writes (`suspend`): throw or return `Result`, by intent

```kotlin
interface UserDataRepository {
    // Exceptional, rare failure → throw; the caller wraps in try/catch.
    suspend fun refreshUser()

    // The caller must branch on failure → return Result.
    suspend fun updateBookmark(id: String, bookmarked: Boolean): Result<Unit>
}
```

- Failure is **exceptional / rare** → **throw** a typed exception.
- The caller **must branch** on failure — an online-only write, a conflict, "save failed, tell the user" → return **`Result<Unit>`** (or a domain-specific sealed result). One-shot calls don't suffer the operator-threading overhead that makes `Result` awkward inside flows.

### Type your failures

Model known, recoverable failures as **typed** values — a typed exception like `UserNotAuthenticatedException`, or a sealed error inside a `Result` — never a bare `Exception`. That's what lets a caller tell an expected condition apart from a programming error.

> [!NOTE]
> On an existing codebase, conform to the error model already in use rather than introducing a second one — see `extending-existing-code.md`. The hybrid above is the default for new data layers.
