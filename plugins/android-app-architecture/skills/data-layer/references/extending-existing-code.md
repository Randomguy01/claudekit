# Working on an existing data layer

Before adding to or modifying an existing data layer, understand what's there. New code should look like whoever wrote the rest of the layer wrote it.

## Orient first

Map the existing layer before writing anything:

- **Structure** — where the data layer lives (which module/package), and how it's organized (`data/local`, `data/network`, `data/model`, `data/repository`, or otherwise).
- **Repositories and data sources** — what already exists, what each owns, and which data sources back them.
- **Libraries in use** — Room, Retrofit, DataStore, WorkManager, and how Hilt wires them.
- **Models and mappers** — whether network/entity/domain models are separated, and the mapper style (`asEntity()` / `asExternalModel()`, or another).

## Conventions to detect and follow

Match the codebase's existing choices over any default:

- **Error model** — typed exceptions vs. `Result` / sealed types (see `expose-data.md`).
- **Async shape** — `Flow` vs. `suspend`; how dispatchers and scopes are injected.
- **Naming** — repository and data-source naming, and package layout.
- **Source of truth** — whether the app is already offline-first with a local source of truth.

> [!IMPORTANT]
> Precedence when choosing an approach: an explicit instruction wins; otherwise follow the existing codebase's conventions; only fall back to this skill's defaults when the codebase hasn't established one. Conform to what's there rather than introducing a second pattern.

## Extending vs. modifying

- **Additive** work — a new repository, data source, or endpoint — follows the conventions above and slots in alongside the existing code.
- **Modifying** existing code — changing a model, swapping a library, a migration — risks regressions. Lean on the existing test suite to prove behavior is preserved (see `testing.md`), and keep changes surgical: preserve unrelated code and don't refactor what you weren't asked to.

> [!NOTE]
> Migrating a data source to a new backing technology? Put both implementations behind a data-source interface so the repository is unaffected during the migration — see the migration note in `repositories-and-data-sources.md`.
