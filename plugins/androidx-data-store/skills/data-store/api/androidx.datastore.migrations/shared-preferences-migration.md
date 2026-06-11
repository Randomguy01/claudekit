# API Reference

> Last updated 2026-06-10

# SharedPreferencesMigration

> Added in 1.0.0

```
class SharedPreferencesMigration<T : Any?> : DataMigration
```

A [`DataMigration`](../androidx.datastore.core/data-migration.md) instance for migrating from `SharedPreferences` to DataStore.

This migration only supports the basic `SharedPreferences` types: boolean, float, int, long, string, and string set. Other types returned by `getAll` are ignored.

For migrating a Preferences DataStore specifically, prefer the [`SharedPreferencesMigration` factory functions](../androidx.datastore.preferences/package-functions.md#sharedpreferencesmigration) in `androidx.datastore.preferences`, which return `SharedPreferencesMigration<Preferences>`.

## Public Constructors

### SharedPreferencesMigration

```
<T : Any?> SharedPreferencesMigration(
    produceSharedPreferences: () -> SharedPreferences,
    keysToMigrate: Set<String> = MIGRATE_ALL_KEYS,
    shouldRunMigration: suspend (T) -> Boolean = { true },
    migrate: suspend (SharedPreferencesView, T) -> T
)
```

```kotlin
val sharedPrefsMigration = SharedPreferencesMigration(
    produceSharedPreferences = { EncryptedSharedPreferences.create(...) }
) { prefs: SharedPreferencesView, myData: MyData ->
    myData.toBuilder().setCounter(prefs.getInt(COUNTER_KEY, default = 0)).build()
}
```

- `produceSharedPreferences` — returns the `SharedPreferences` instance to migrate from.
- `keysToMigrate` — the keys to migrate, mapped to `Preferences` with their same values. A key already present in the new `Preferences` is not migrated again; a key absent from `SharedPreferences` is not migrated. Defaults to `MIGRATE_ALL_KEYS` (all keys).
- `shouldRunMigration` — accepts the current data of type `T` and returns whether the migration should run.
- `migrate` — maps the `SharedPreferences` into `T`. Should be idempotent (may be called multiple times); see [`DataMigration.migrate`](../androidx.datastore.core/data-migration.md#migrate). It receives a [`SharedPreferencesView`](shared-preferences-view.md) (limited to `keysToMigrate`) and the current data, and must return the migrated data. If `SharedPreferences` is empty or contains none of the specified keys, this callback does not run.

### SharedPreferencesMigration

```
<T : Any?> SharedPreferencesMigration(
    context: Context,
    sharedPreferencesName: String,
    keysToMigrate: Set<String> = MIGRATE_ALL_KEYS,
    shouldRunMigration: suspend (T) -> Boolean = { true },
    migrate: suspend (SharedPreferencesView, T) -> T
)
```

As above, but resolves the `SharedPreferences` from a `Context` and name. If the `SharedPreferences` is empty once the migration completes, this migration attempts to delete it.

```kotlin
val sharedPrefsMigration = SharedPreferencesMigration(
    context,
    mySharedPreferencesName
) { prefs: SharedPreferencesView, myData: MyData ->
    myData.toBuilder().setCounter(prefs.getInt(COUNTER_KEY, default = 0)).build()
}
```

- `context` — context used to get the `SharedPreferences`.
- `sharedPreferencesName` — the name of the `SharedPreferences`.
- `keysToMigrate`, `shouldRunMigration`, `migrate` — as in the overload above.

## Public Functions

These override [`DataMigration`](../androidx.datastore.core/data-migration.md); see it for the full contract.

### shouldMigrate

```
open suspend fun shouldMigrate(currentData: T): Boolean
```

Returns whether this migration needs to be performed (delegates to the `shouldRunMigration` lambda). Always called before [`migrate`](#migrate).

### migrate

```
open suspend fun migrate(currentData: T): T
```

Performs the migration via the `migrate` lambda. Idempotent; on failure no data is committed, [`cleanUp`](#cleanup) is not called, and the exception propagates to the triggering DataStore call.

### cleanUp

> Added in 1.0.0

```
open suspend fun cleanUp(): Unit
```

Cleans up old state/data that was migrated. Not called if the migration fails.
