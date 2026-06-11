# API Reference

> Last updated 2026-06-10

# RxDataMigration

> Added in 1.0.0

```
interface RxDataMigration<T>
```

Interface for migrations to DataStore, expressed with RxJava 3 types. `shouldMigrate`, `migrate`, and `cleanUp` may each be called multiple times, so their implementations must be idempotent — they may re-run if DataStore hits an error writing the migrated data to disk or if any migration installed in the same DataStore throws. To migrate from `SharedPreferences`, see [`RxSharedPreferencesMigration`](rx-shared-preferences-migration.md) instead.

- `T` — the data type managed by the DataStore.

## Public Functions

### shouldMigrate

```
fun shouldMigrate(currentData: T?): Single<Boolean!>
```

Returns whether this migration needs to be performed. If the `Single` emits `false`, neither `migrate` nor `cleanUp` runs. Do the cheapest possible check here — it is called every time the DataStore is initialized, and may run multiple times when a failure is encountered. Always called before each call to `migrate`.

- `currentData` — the current data (which may already be populated from previous runs of this or other migrations). Only nullable if the DataStore type is nullable.

### migrate

```
fun migrate(currentData: T?): Single<T!>
```

Performs the migration and emits the migrated data. Must be idempotent since it may be called multiple times. If it fails, DataStore commits nothing to disk, `cleanUp` is not called, and the error propagates back to the DataStore call that triggered the migration; future DataStore calls retry the migrations. Always called before `cleanUp`.

- `currentData` — the current data (possibly populated from other migrations or manual changes made before this migration was added). Only nullable if the DataStore type is nullable.

### cleanUp

```
fun cleanUp(): Completable
```

Cleans up any old state/data that was migrated into the DataStore. Not called if the migration fails. If `cleanUp` throws, the error propagates back to the triggering DataStore call and future DataStore calls retry the migrations. May run multiple times when a failure is encountered.
