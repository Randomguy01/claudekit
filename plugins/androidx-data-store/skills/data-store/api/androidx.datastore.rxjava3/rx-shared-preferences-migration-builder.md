# API Reference

> Last updated 2026-06-10

# RxSharedPreferencesMigrationBuilder

> Added in 1.0.0

```
class RxSharedPreferencesMigrationBuilder<T : Any?>
```

Builder that turns an [`RxSharedPreferencesMigration`](rx-shared-preferences-migration.md) into a [`DataMigration`](../androidx.datastore.core/data-migration.md).

## Public Constructors

### RxSharedPreferencesMigrationBuilder

```
<T : Any?> RxSharedPreferencesMigrationBuilder(
    context: Context,
    sharedPreferencesName: String,
    rxSharedPreferencesMigration: RxSharedPreferencesMigration<T>
)
```

- `context` — the context from which the `SharedPreferences` is retrieved.
- `sharedPreferencesName` — the name of the `SharedPreferences` to migrate from.
- `rxSharedPreferencesMigration` — the [`RxSharedPreferencesMigration`](rx-shared-preferences-migration.md) that maps the preferences into `T`.

## Public Functions

### setKeysToMigrate

```
fun setKeysToMigrate(vararg keys: String): RxSharedPreferencesMigrationBuilder<T>
```

Set the keys to migrate. The keys are mapped into DataStore `Preferences` with the same values; a key already present in the new `Preferences` is not migrated again, and a key absent from the `SharedPreferences` is skipped. Optional — if not set, all keys are migrated from the existing `SharedPreferences`. Returns `this`.

### build

```
fun build(): DataMigration<T>
```

Build and return the [`DataMigration`](../androidx.datastore.core/data-migration.md) instance.
