# API Reference

> Last updated 2026-06-10

# DataMigration

> Added in 1.0.0

```
interface DataMigration<T : Any?>
```

Interface for migrations to DataStore. The methods [`shouldMigrate`](#shouldmigrate), [`migrate`](#migrate), and [`cleanUp`](#cleanup) may be called multiple times, so their implementations must be idempotent — DataStore retries them if it hits issues writing the newly migrated data to disk, or if any migration installed in the same DataStore throws.

When migrating from SharedPreferences, use [`SharedPreferencesMigration`](../androidx.datastore.migrations/shared-preferences-migration.md).

## Known Direct Subtypes

| | |
|---|---|
| [`SharedPreferencesMigration`](../androidx.datastore.migrations/shared-preferences-migration.md) | `DataMigration` instance for migrating from SharedPreferences to DataStore. |

## Public Functions

### shouldMigrate

```
suspend fun shouldMigrate(currentData: T): Boolean
```

Returns whether this migration needs to be performed. If it returns false, no migration or cleanup occurs. Do the cheapest possible check here — it is called every time the DataStore is initialized, and may run multiple times on failure. Always called before each call to [`migrate`](#migrate).

Accessing data from DataStore directly inside this function deadlocks, since DataStore doesn't return data until all migrations complete.

- `currentData` — the current data, which might already be populated from previous runs of this or other migrations.

### migrate

```
suspend fun migrate(currentData: T): T
```

Perform the migration; implementations should be idempotent. If `migrate` fails, DataStore commits no data, [`cleanUp`](#cleanup) is not called, and the exception is propagated to the triggering DataStore call (future calls retry the migrations). Always called before [`cleanUp`](#cleanup). Accessing DataStore data directly here deadlocks.

- `currentData` — the current data (possibly populated from other migrations or manual changes before this migration was added).

Returns the migrated data.

### cleanUp

> Added in 1.0.0

```
suspend fun cleanUp(): Unit
```

Clean up any old state/data that was migrated into the DataStore. Not called if the migration fails. If `cleanUp` throws, the exception is propagated to the triggering DataStore call and future calls retry the migrations. May run multiple times on failure.

Useful for cleaning up files or data outside of DataStore. Accessing DataStore data directly here deadlocks.
