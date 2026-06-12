# Offline-first

An offline-first app performs all, or a critical subset, of its functionality without a network — at minimum, it can **read** data offline. Build this in the data layer.

## When to apply this pattern

Default to offline-first for a repository when **both** hold:

- it has a **network source and a local / disk persistence** need, and
- the data is **not sensitive**.

For **sensitive** data — credentials, auth tokens, payment details, PII, anything that must stay server-authoritative — don't cache it as a local source of truth. Keep it online-authoritative (see online-only writes below); if it genuinely must be stored, route it to **encrypted** storage (an encrypted DataStore, or a SQLCipher-backed Room database) rather than a plain local source of truth. When sensitivity is ambiguous, treat the data as sensitive.

Purely ephemeral network reads, or purely local data, don't need this pattern — keep them simple.

## Model the data

An offline-first repository that uses the network has at least two data sources:

- **Local data source** — the canonical **source of truth**, and the exclusive source for anything higher layers read. Backed by disk (Room, DataStore, or files). This is what guarantees consistency across connection states.
- **Network data source** — the *actual* state of the application. The local source syncs toward it; either can lag the other. Only the repository talks to the network; the domain and UI layers never do.

> [!IMPORTANT]
> A repository with network access in an offline-first app must always have a local data source, and reads must come from it.

Each source often needs its own model — see the three-model pattern in `models-and-mappers.md`.

## Reads

Reads are the fundamental operation. Expose them as **observable** types (`Flow`) read directly from the local source of truth, so readers update automatically whenever the local data changes:

```kotlin
class OfflineFirstTopicsRepository(
    private val localDataSource: TopicsLocalDataSource,
    /* ... */
) {
    fun getTopicsStream(): Flow<List<Topic>> = localDataSource.getTopicsStream()
}
```

Because readers observe the local source, every update — including one triggered when connectivity returns — must be **written to the local source first** so it propagates to readers.

### Read error handling

- **Local source** — minimize failures; protect readers with the `catch` operator on the `Flow`, emitting a fallback or an error state. (`catch` stops the exception from crashing the app, but the flow still terminates; use `retry` to resume collecting.)
- **Network source** — retry with a heuristic:
  - **Exponential backoff** — retry with growing intervals until success or a stop condition. Retry connectivity errors; don't retry an unauthorized request until credentials exist; cap the number of attempts.
  - **Network connectivity monitoring** — queue reads until the network is available, then drain the queue, read, and update the local source. On Android, back the queue with Room and drain it as persistent work with WorkManager.

## Writes

Expose writes as **asynchronous** `suspend` functions (not observable types) — this avoids blocking the UI thread and surfaces failures that happen at the network boundary. Choose a strategy by the data's needs:

- **Online-only writes** — write across the network; on success update the local source, on failure throw and let the caller respond. Use for transactions that must happen online in near real time (a bank transfer). Often you disable or hide the write UI when offline, or notify the user. **This is the default for sensitive, server-authoritative data.**
- **Queued writes** — enqueue the write, drain the queue with exponential backoff when back online. Good when it's not essential the write ever reaches the network, it isn't time-sensitive, and the user needn't be told on failure (analytics, logging). Drain with WorkManager.
- **Lazy writes** — write to the local source first, then queue a network update for the earliest opportunity. The correct choice when the data is critical and must not be lost (tasks in an offline-first to-do app). Requires conflict resolution — see below.

> [!NOTE]
> Offline-first apps don't have to support offline *writes* to be considered offline-first; offline reads are the minimum.

## Synchronization

When connectivity returns, reconcile the local and network sources:

- **Pull-based** — fetch the latest data on demand, often just before showing it (navigation-based). Simple; works when offline periods are brief. Prone to over-fetching and scales poorly with relational data. The Paging library's `RemoteMediator` follows this pattern.
- **Push-based** — the local source mirrors a replica of the network: fetch a baseline at first startup, then rely on server notifications to learn what's stale and fetch only that. Far less network-dependent; works well for relational data and for long offline periods. Versioning for conflicts is harder, and the network source must support synchronization.
- **Hybrid** — pull for some data, push for others. A social app might pull a fast-changing feed and push the signed-in user's profile.

The choice depends on product requirements and the available infrastructure.

## Conflict resolution

If the app wrote data locally while offline that diverges from the network, resolve the conflict before syncing. This usually needs **versioning** — track when each change happened and pass that metadata to the network, which holds the absolute source of truth.

A common mobile approach is **last write wins**: devices attach a timestamp to each write; the network keeps whichever write is newer and discards older ones.

## WorkManager in offline-first

Both reads and writes rely on two utilities that are exactly the persistent work WorkManager handles:

- **Queues** — defer reads or writes until connectivity is available, and requeue writes for retry.
- **Connectivity monitors** — signal when to drain a queue and when to synchronize.

A typical startup sync enqueues unique sync work constrained to `NetworkType.CONNECTED`, so it waits for the network before running, and returns `Result.retry()` on failure to get automatic exponential backoff:

```kotlin
class SyncWorker(/* ... */) : CoroutineWorker(appContext, params) {
    override suspend fun doWork(): Result = withContext(ioDispatcher) {
        val ok = awaitAll(
            async { topicRepository.sync() },
            async { newsRepository.sync() },
        ).all { it }
        if (ok) Result.success() else Result.retry()
    }
}
```

Build the worker, its constraints, and unique-work scheduling with the `work-manager` skill.
