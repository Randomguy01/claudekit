---
name: data-layer
description: >
  Build and maintain the data layer of an Android app — repositories and data
  sources, immutable data models and mappers, source of truth and caching,
  error handling, threading, offline-first sync, and testing. Use this skill
  when the user works on the data or business-logic layer of an Android app —
  creating a repository or data source, deciding how to expose data (suspend
  vs. Flow), separating network/database/domain models, choosing local storage,
  making an app work offline, or wiring the data layer with dependency
  injection. Applies even when the user doesn't say "data layer" by name —
  e.g. "create a repository for X," "cache this network response," "make my
  app work offline," "where should this API call live," or "expose this as a
  Flow." Skip for UI/ViewModel state (UI layer) and for pure use-case
  orchestration (domain layer); for library specifics use the room, retrofit,
  data-store, work-manager, or hilt skills.
---

# Data layer

The data layer holds the app's *application data* and *business logic* — the real-world rules that determine how data is created, stored, and changed — and exposes that data to the rest of the app through **repositories**. The UI and domain layers depend on these repositories and stay independent of where data actually comes from.

This skill builds on the **`app-architecture`** foundation (single source of truth, unidirectional data flow, the dependency rule); read that skill for the underlying principles.

This skill is a router. Decide what the task needs, then read the matching reference before writing or reviewing code.

## Reference guides (`references/`)

### Structure

- The shape of the layer — repositories, data sources, responsibilities, naming → `references/repositories-and-data-sources.md`
- The public surface the layer exposes — one-shot `suspend` vs. observable `Flow`, the error model → `references/expose-data.md`
- Separating network/database/domain models and mapping between them → `references/models-and-mappers.md`

### Behavior

- Source of truth, in-memory caching, threading/main-safety, scoping, and the UI/app/business operation types → `references/source-of-truth-and-lifecycle.md`
- Choosing the right library for each need — the decision matrix → `references/library-selection.md`
- Making the app work offline — local source of truth, reads, writes, sync, conflicts → `references/offline-first.md`

### Quality and maintenance

- Testing the data layer → `references/testing.md`
- Working on an existing data layer — orient, conform, extend → `references/extending-existing-code.md`

## Implementation libraries

The data layer is assembled from these libraries; `references/library-selection.md` routes each need to the right one, and each has its own skill for implementation:

- **Room** — local database → `room`
- **Retrofit** — network → `retrofit`
- **DataStore** — key-value / typed preferences → `data-store`
- **WorkManager** — persistent background work → `work-manager`
- **Hilt** — dependency-injection wiring → `hilt`
