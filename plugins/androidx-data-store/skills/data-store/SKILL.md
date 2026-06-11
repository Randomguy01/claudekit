---
name: data-store
description: >
  Store small amounts of data on Android with Jetpack DataStore. Use this skill
  when the user persists key-value pairs or typed objects locally on Android —
  saving user settings or app preferences, replacing SharedPreferences, reading
  and writing values as a Kotlin Flow, defining Preferences/Proto/JSON
  DataStores, wiring a serializer, accessing a store across processes, or
  handling file corruption. Applies even when the user doesn't say "DataStore"
  by name — e.g. "save the user's settings on Android," "store a toggle that
  survives restarts," "migrate off SharedPreferences," or "persist app config
  as a Flow." Skip for large, relational, or partially-updated datasets (use
  Room instead), and for non-Android or server-side storage.
---

# DataStore

Jetpack DataStore stores key-value pairs or typed objects on disk using Kotlin coroutines and Flow. Its API is two operations: read through a `Flow<T>` exposed by `DataStore.data`, and update transactionally with the `updateData` suspend function.

> [!TIP]
> If the data is large, relational, partially updated, or needs referential integrity, use Room instead — DataStore is for small datasets and has no partial updates.

This skill is a router. Decide what the task needs, then read the matching file before writing or reviewing code. Task workflows (define → create → read → write) live in `references/`; the exact contract of any single type — constructor arguments, function signatures, properties — lives in `api/`. Open the reference guide for the task, then drill into the `api/` file for any type it links.

## Use DataStore Correctly

These rules apply to every task — keep them in mind regardless of which reference you open:

1. **One `DataStore` per file per process.** Creating a second instance for the same file in the same process breaks DataStore — it throws `IllegalStateException` on reads and updates. Declaring the delegate at the top level of a Kotlin file enforces this.
2. **The generic type `T` must be immutable.** Mutating a type stored in a `DataStore<T>` invalidates DataStore's consistency guarantees and causes hard-to-catch bugs. Proto types help enforce immutability.
3. **Do not mix `SingleProcessDataStore` and `MultiProcessDataStore` for the same file.** To access a file from more than one process, use the multi-process construction everywhere — see `references/multiprocess.md`.

## Choose a Configuration

DataStore comes in two configurations. Pick first, then open the matching reference for the full define → create → read → write lifecycle:

> [!TIP]
> Use **Preferences** for simple key-value data with no schema. Use a **typed** DataStore to persist a custom class — **Proto** for a schema-enforced, immutable type (recommended), or **JSON** when you prefer kotlinx.serialization over Protocol Buffers.

- Key-value pairs, `SharedPreferences`-style → `references/preferences-datastore.md`
- Typed object serialized with Protocol Buffers → `references/proto-datastore.md`
- Typed object serialized with kotlinx.serialization JSON → `references/json-datastore.md`

## Reference Guides (`references/`)

### Setup

- Add DataStore to a project (dependencies, serialization plugins) → `references/install.md`

### Using DataStore

- Consume a store from Compose (ViewModel, `collectAsStateWithLifecycle`) → `references/compose.md`
- Access a store from more than one process → `references/multiprocess.md`
- Recover from a corrupted on-disk file → `references/corruption.md`

## API references (`api/`)

Each class, interface, object, and enum has its own file. Filenames are the kebab-case form of the type name (`DataStore` → `data-store.md`, `Preferences.Key` → `preferences-key.md`, `MultiProcessDataStoreFactory` → `multi-process-data-store-factory.md`). A package's top-level and extension functions live in that package's `package-functions.md`. Each package is a sibling directory under `api/` — run `ls api/` to discover the packages and `ls api/<package>/` for the full set within one.

Start here:

- **`DataStore<T>`** → `api/androidx.datastore.core/data-store.md` — the core type; read via the `data` Flow, write via `updateData`
- **Preferences (key-value)** → `api/androidx.datastore.preferences.core/preferences.md` and `api/androidx.datastore.preferences.core/package-functions.md` — the typed key builders (`stringPreferencesKey`, etc.), `edit`, `emptyPreferences`
- **`preferencesDataStore` delegate** → `api/androidx.datastore.preferences/package-functions.md` — the entry point for a Preferences store
- **`dataStore` delegate** → `api/androidx.datastore/package-functions.md` — the entry point for a typed (Proto/JSON) store
- **`Serializer<T>`** → `api/androidx.datastore.core/serializer.md` — the contract a typed store's serializer implements
- **Corruption handling** → `api/androidx.datastore.core.handlers/replace-file-corruption-handler.md` — recover by replacing corrupt data

The `api/` tree covers eleven packages, each in its own directory:

- `api/androidx.datastore/` — top-level typed-store delegates (`dataStore`, `deviceProtectedDataStore`, `Context.dataStoreFile`).
- `api/androidx.datastore.core/` — the core types (`DataStore`, `Serializer`, `Storage`, `DataMigration`, `CorruptionException`, `DataStoreFactory`, `MultiProcessDataStoreFactory`, and the rest).
- `api/androidx.datastore.core.handlers/` — corruption handlers (`ReplaceFileCorruptionHandler`, `ReThrowCorruptionHandler`).
- `api/androidx.datastore.core.okio/` — Okio-backed storage and serializers (`OkioStorage`, `OkioSerializer`, plus the JavaScript `WebStorage`/`WebSerializer`).
- `api/androidx.datastore.migrations/` — `SharedPreferences` migration (`SharedPreferencesMigration`, `SharedPreferencesView`).
- `api/androidx.datastore.preferences/` — the `preferencesDataStore` delegate and `Context.preferencesDataStoreFile`.
- `api/androidx.datastore.preferences.core/` — `Preferences`, `MutablePreferences`, the typed `Key` builders, `PreferenceDataStoreFactory`, and `DataStore<Preferences>.edit`.
- `api/androidx.datastore.rxjava2/` and `api/androidx.datastore.rxjava3/` — RxJava-based typed stores (`RxDataStore`, `RxDataStoreBuilder`, `RxDataMigration`, `RxSharedPreferencesMigration`).
- `api/androidx.datastore.preferences.rxjava2/` and `api/androidx.datastore.preferences.rxjava3/` — RxJava-based Preferences stores (`RxPreferenceDataStoreBuilder`, `rxPreferencesDataStore`).

Read the `api/` file when you need to confirm a type's exact signature or members — not for how-to workflows, which live in `references/`.
