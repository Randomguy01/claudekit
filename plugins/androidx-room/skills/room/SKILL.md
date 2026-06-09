---
name: room
description: >
  Build and maintain an Android Room persistence layer. Use this skill when
  the user works with Room or on-device SQLite storage on Android — defining
  entities, DAOs, and queries; setting up the database and DI wiring; schema
  migrations; entity relationships; type converters for custom column types;
  views, FTS, and prepopulated databases; or testing and debugging the
  database. Applies even when the user doesn't say "Room" by name — e.g.
  "save this data locally on Android," "persist app state to a database,"
  "@Entity / @Dao / @Query won't compile," or "migrate my SQLite app." Skip
  for server-side or non-Android databases and for plain ORMs on other
  platforms.
---

# Room

Room is a persistence library that provides an abstraction layer over SQLite for Android. Prefer it over the raw `android.database.sqlite` APIs: it adds compile-time SQL verification, annotation-driven boilerplate reduction, and migration support.

This skill is a router. Decide what the task needs, then read the matching file before writing or reviewing code:

- **`references/*.md`** — task guides. How to define and wire up Room features. **Read these first.**
- **`api/<package>/*.md`** — per-type API references. Exact annotation attributes, method signatures, and parameters. Read these when you need the precise contract of a specific type.

When in doubt, open the reference guide for the task, then drill into the `api/` file for any type it links.

## Reference guides (`references/`)

### Setup

- New to Room or adding it to a project → `references/install.md`
- App already uses raw SQLite and you're moving it to Room → `references/sqlite-to-room.md`
- Background on the low-level SQLite APIs and why Room is preferred → `references/sqlite.md`

### Core building blocks

- Define tables (the schema) → `references/entity.md`
- Query, insert, update, delete data → `references/dao.md`
- Keep DAO queries off the main thread (Flow, coroutines, LiveData, RxJava) → `references/dao-async.md`
- Store custom/complex types in a column with type converters → `references/complex-data.md`
- Encapsulate a read-only query as a view → `references/view.md`

### Relationships between entities

- Start here to choose a relationship type → `references/relationship-overview.md`
- One-to-one → `references/relationship-one-to-one.md`
- One-to-many → `references/relationship-one-to-many.md`
- Many-to-many → `references/relationship-many-to-many.md`
- Three or more related tables → `references/relationship-nested.md`

### Database lifecycle

- Migrate the schema while preserving user data (automated and manual) → `references/migrate.md`
- Ship the app with a pre-loaded database → `references/prepopulate.md`

### Quality

- Test the database → `references/test.md`
- Debug a database (Database Inspector, etc.) → `references/debug.md`

## API references (`api/`)

Each annotation, class, and interface has its own file. Filenames are the kebab-case form of the type name (`@PrimaryKey` → `primary-key.md`, `RoomDatabase.Builder` → `room-database-builder.md`). Run `ls api/<package>/` to discover the full set.

The three primary components and their annotations:

- **Database** → `api/androidx.room/database.md` — the access point; built with `api/androidx.room/room-database-builder.md`
- **Entity** → `api/androidx.room/entity.md` — a table; see also `primary-key.md`, `column-info.md`, `index.md`, `embedded.md`, `ignore.md`
- **DAO** → `api/androidx.room/dao.md` — query interface; see also `query.md`, `insert.md`, `update.md`, `delete.md`, `upsert.md`, `transaction.md`, `on-conflict-strategy.md`

Packages:

- `api/androidx.room/` — annotations and core types (entities, DAOs, queries, type converters, FTS, relations, raw queries).
- `api/androidx.room.migration/` — `migration.md`, `auto-migration-spec.md`.
- `api/androidx.room.testing/` — `migration-test-helper.md`.

Read the `api/` file when you need to confirm an annotation's attributes or a method's exact signature — not for how-to workflows, which live in `references/`.
