# Choosing the right library

The data layer is built on Jetpack and other recommended libraries. Match each need to a library, then use that library's skill for implementation. Be opinionated: pick the default below unless an explicit instruction or an existing codebase choice says otherwise (see `extending-existing-code.md`) — and whenever you introduce a dependency the project doesn't already have, **call it out**.

## Decision matrix

| Need | Library | Skill |
|---|---|---|
| Network requests / remote data source | **Retrofit** | `retrofit` |
| Large, queryable, relational data; partial updates; referential integrity | **Room** | `room` |
| Small key-value or typed preferences (settings, flags) | **DataStore** | `data-store` |
| A chunk of data like a JSON blob or a bitmap | **a `File`** | — |
| Persistent, deferrable background work that must survive process death | **WorkManager** | `work-manager` |
| Providing and scoping dependencies | **Hilt** | `hilt` |

## Local storage: Room vs. DataStore vs. file

Data that must survive process death goes to disk. Choose by shape:

- **Room** — large datasets that need queries, referential integrity, or partial updates. *News articles, authors.*
- **DataStore** — small datasets you only get and set, not query. *Display preferences, notification settings, feature flags.* DataStore reads are exposed as a `Flow` that emits on every change, so group related preferences in one DataStore — a `NotificationsDataStore`, a `NewsPreferencesDataStore` — to keep each one's updates tightly scoped.
- **File** — large opaque objects like a JSON document or a bitmap.

Each data source still works with one source for one type of data, and the repository never reveals which — that's what lets you swap Room for DataStore later without touching callers.

## Network: Retrofit behind an interface

Hide the network client behind an interface the data source depends on, so the implementation (Retrofit, or anything else) is swappable and can be faked in tests:

```kotlin
// The data source depends on this, not on Retrofit directly.
interface NewsApi {
    suspend fun fetchLatestNews(): List<ArticleHeadline>
}
```

Build the interface and its Retrofit implementation with the `retrofit` skill.

## Business-oriented work: WorkManager as a data source

Work that can't be canceled and must survive process death — see the operation types in `source-of-truth-and-lifecycle.md` — belongs to WorkManager. Encapsulate it in its own data source named after the data it concerns (`NewsTasksDataSource`), keeping the repository unaware that WorkManager is involved:

```kotlin
class NewsTasksDataSource(
    private val workManager: WorkManager,
) {
    fun fetchNewsPeriodically() {
        val request = PeriodicWorkRequestBuilder<RefreshLatestNewsWorker>(
            REFRESH_RATE_HOURS, TimeUnit.HOURS,
        ).setConstraints(
            Constraints.Builder()
                .setRequiredNetworkType(NetworkType.TEMPORARILY_UNMETERED)
                .setRequiresCharging(true)
                .build()
        ).build()

        workManager.enqueueUniquePeriodicWork(
            FETCH_LATEST_NEWS_TASK,
            ExistingPeriodicWorkPolicy.KEEP,
            request,
        )
    }
}
```

Keep the task's business logic in its own class and treat WorkManager as just the scheduler — that keeps implementations swappable. Build workers, constraints, and requests with the `work-manager` skill.

## Dependency injection: Hilt

Wire repositories, data sources, dispatchers, and scopes together with Hilt rather than constructing them by hand. See the `hilt` skill, and the scoping guidance in `source-of-truth-and-lifecycle.md`.

## When network and local meet: offline-first

When a repository has **both** a network source and a local/disk persistence need for **non-sensitive** data, default to making the local source its source of truth and applying the offline-first pattern — see `offline-first.md` for the trigger (including the sensitive-data carve-out) and the read/write/sync strategies.

> [!IMPORTANT]
> When a need calls for a library the project doesn't already depend on, surface that you're adding it — a new dependency is a project-level change, not a silent implementation detail.
