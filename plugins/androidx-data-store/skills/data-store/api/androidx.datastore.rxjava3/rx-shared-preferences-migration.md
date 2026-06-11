# API Reference

> Last updated 2026-06-10

# RxSharedPreferencesMigration

> Added in 1.0.0

```
interface RxSharedPreferencesMigration<T : Any?>
```

Client-implemented `SharedPreferences`-to-DataStore migration interface, expressed with RxJava 3 types. Wrap an implementation with [`RxSharedPreferencesMigrationBuilder`](rx-shared-preferences-migration-builder.md) to produce a [`DataMigration`](../androidx.datastore.core/data-migration.md).

## Public Functions

### migrate

```
fun migrate(
    sharedPreferencesView: SharedPreferencesView,
    currentData: T
): Single<T>
```

Maps `SharedPreferences` into `T`. Implementations should be idempotent since this may be called multiple times — see [`DataMigration.migrate`](../androidx.datastore.core/data-migration.md#migrate). Receives a [`SharedPreferencesView`](../androidx.datastore.migrations/shared-preferences-view.md) (limited to the keys to migrate) and the current data, and must return the migrated data. If `SharedPreferences` is empty or contains none of the specified keys, this callback does not run.

- `sharedPreferencesView` — the current state of the `SharedPreferences`.
- `currentData` — the most recently persisted data.

### shouldMigrate

```
open fun shouldMigrate(currentData: T): Single<Boolean>
```

Whether the migration should run. Use this to skip a read from the `SharedPreferences`.

- `currentData` — the most recently persisted data.
