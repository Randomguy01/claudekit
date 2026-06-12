# Source of truth, lifecycle, and threading

## Source of truth

Each repository defines a single source of truth (SSOT) — the place that always holds consistent, correct, up-to-date data. The data a repository exposes always comes directly from its source of truth.

The source of truth can be a data source (a database) or an in-memory cache the repository owns. The repository combines its data sources, resolves conflicts between them, and updates the source of truth — on a schedule or in response to a user event.

Different repositories can have different sources of truth: `LoginRepository` might use an in-memory cache, while `PaymentsRepository` uses its network source.

> [!IMPORTANT]
> For offline-first support, a local data source — usually a database — is the recommended source of truth. See `offline-first.md`.

## Types of data operations

Classify each operation by how long it must outlive the caller — this drives where you run it and which library you use:

- **UI-oriented** — relevant only while the user is on a screen; canceled when they leave. Triggered by the UI layer and follows the caller's lifecycle (the `ViewModel`'s). *Loading data to display.*
- **App-oriented** — relevant as long as the app is open; canceled on process death. *Caching a network result for later.* Runs in a scope tied to the data layer or `Application` — see below.
- **Business-oriented** — must not be canceled, and must survive process death. *Finishing a photo upload.* Use **WorkManager** — see `library-selection.md`.

## Threading and main-safety

Calling a data source or repository must be **main-safe** — safe to call from the main thread. Each class moves its own long-running blocking work to the appropriate thread; it knows what work it's doing and where that work should run.

Most data sources already provide main-safe APIs — the `suspend` calls in Room and Retrofit, for example — and a repository can rely on those. When a source isn't main-safe, move the work yourself by injecting a `CoroutineDispatcher` and wrapping the call:

```kotlin
class NewsRemoteDataSource(
    private val newsApi: NewsApi,
    private val ioDispatcher: CoroutineDispatcher,
) {
    suspend fun fetchLatestNews(): List<ArticleHeadline> =
        withContext(ioDispatcher) {
            newsApi.fetchLatestNews()
        }
}
```

> [!NOTE]
> Inject the dispatcher rather than hardcoding it, so tests can substitute a test dispatcher.

## In-memory caching

To preserve data while the user is in the app (an app-oriented operation), cache it in the repository. A cache can be as simple as a variable; protect concurrent reads and writes with a `Mutex`:

```kotlin
class NewsRepository(
    private val newsRemoteDataSource: NewsRemoteDataSource,
) {
    private val latestNewsMutex = Mutex()
    private var latestNews: List<ArticleHeadline> = emptyList()

    suspend fun getLatestNews(refresh: Boolean = false): List<ArticleHeadline> {
        if (refresh || latestNews.isEmpty()) {
            val networkResult = newsRemoteDataSource.fetchLatestNews()
            latestNewsMutex.withLock { this.latestNews = networkResult }
        }
        return latestNewsMutex.withLock { this.latestNews }
    }
}
```

## Make an operation outlive the screen

If the user leaves the screen mid-request, a coroutine tied to the caller is canceled and the result is never cached. For an app-oriented operation, don't use the caller's `CoroutineScope` — inject an external scope (configured with `Dispatchers.Default` or your own thread pool) and run the work in it:

```kotlin
class NewsRepository(
    private val newsRemoteDataSource: NewsRemoteDataSource,
    private val externalScope: CoroutineScope,
) {
    suspend fun getLatestNews(refresh: Boolean = false): List<ArticleHeadline> =
        if (refresh) {
            externalScope.async {
                newsRemoteDataSource.fetchLatestNews().also { result ->
                    latestNewsMutex.withLock { latestNews = result }
                }
            }.await()
        } else {
            latestNewsMutex.withLock { latestNews }
        }
}
```

`async` starts the work in the external scope; `await` suspends the caller for the result. If the user leaves, `await` is canceled but the `async` block keeps running and still updates the cache. Inject the scope rather than creating it inside the repository.

## Lifecycle and scoping

Data-layer instances live as long as something references them. When a class holds in-memory state you want to reuse, scope its instance to a lifecycle:

- Crucial to the whole app → scope to the `Application`, so it follows the application's lifecycle.
- Used only within one flow — registration, login → scope to that flow's owner, such as its navigation graph.

Manage scoping through dependency injection. See the `hilt` skill for the available scopes.
