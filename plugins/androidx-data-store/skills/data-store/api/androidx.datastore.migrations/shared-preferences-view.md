# API Reference

> Last updated 2026-06-10

# SharedPreferencesView

> Added in 1.0.0

```
class SharedPreferencesView
```

Read-only wrapper around `SharedPreferences`, passed into your [`SharedPreferencesMigration`](shared-preferences-migration.md) `migrate` lambda. Access is limited to the keys declared in `keysToMigrate` — every accessor throws `IllegalArgumentException` if `key` wasn't specified as part of the migration.

## Public Functions

### contains

> Added in 1.0.0

```
operator fun contains(key: String): Boolean
```

Checks whether the preferences contain `key`.

### getAll

> Added in 1.0.0

```
fun getAll(): Map<String, Any?>
```

Retrieve all values from the preferences that are in the specified key set.

### getBoolean

> Added in 1.0.0

```
fun getBoolean(key: String, defValue: Boolean): Boolean
```

Retrieves a boolean value, or `defValue` if the preference does not exist.

### getFloat

> Added in 1.0.0

```
fun getFloat(key: String, defValue: Float): Float
```

Retrieves a float value, or `defValue` if the preference does not exist.

### getInt

> Added in 1.0.0

```
fun getInt(key: String, defValue: Int): Int
```

Retrieves an int value, or `defValue` if the preference does not exist.

### getLong

> Added in 1.0.0

```
fun getLong(key: String, defValue: Long): Long
```

Retrieves a long value, or `defValue` if the preference does not exist.

### getString

> Added in 1.0.0

```
fun getString(key: String, defValue: String? = null): String?
```

Retrieves a string value, or `defValue` if the preference does not exist.

### getStringSet

> Added in 1.0.0

```
fun getStringSet(key: String, defValues: Set<String>? = null): Set<String>?
```

Retrieves a string set value, or `defValues` if the preference does not exist.
