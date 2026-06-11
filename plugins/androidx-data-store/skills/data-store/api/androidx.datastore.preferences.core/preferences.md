# API Reference

> Last updated 2026-06-10

# Preferences

> Added in 1.0.0

```
abstract class Preferences
```

`Preferences` and [`MutablePreferences`](mutable-preferences.md) are a lot like a generic `Map` and `MutableMap` keyed by the [`Preferences.Key`](preferences-key.md) class. They are intended for use with DataStore — construct a `DataStore<Preferences>` using [`PreferenceDataStoreFactory.create`](preference-data-store-factory.md#create).

## Nested Types

| | |
|---|---|
| [`Preferences.Key`](preferences-key.md) | Key for values stored in `Preferences`. |
| [`Preferences.Pair`](preferences-pair.md) | Key-value pairs for `Preferences`. |

## Known Direct Subtypes

| | |
|---|---|
| [`MutablePreferences`](mutable-preferences.md) | Mutable version of `Preferences`. |

## Public Functions

### asMap

> Added in 1.0.0

```
abstract fun asMap(): Map<Preferences.Key<*>, Any>
```

Retrieve a map of all key-preference pairs. The returned map is unmodifiable and throws runtime exceptions if mutated.

### contains

> Added in 1.0.0

```
abstract operator fun <T : Any?> contains(key: Preferences.Key<T>): Boolean
```

Returns true if this `Preferences` contains the specified `key`.

### copy

> Added in 1.3.0-alpha09

```
fun copy(block: (MutablePreferences) -> Unit): Preferences
```

Creates a new read-only `Preferences` with the changes from `block`. The `block` runs on a [`MutablePreferences`](mutable-preferences.md) copy of this object, so any changes inside it are present in the returned `Preferences`.

```kotlin
val newPrefs = prefs.copy { preferences ->
    preferences[COUNTER_KEY] = 1
}
```

### get

> Added in 1.0.0

```
abstract operator fun <T : Any?> get(key: Preferences.Key<T>): T?
```

Get a preference by key, or `null` if it is not set. If `T` is a `Set`, the returned set is unmodifiable and throws if mutated. Use [`MutablePreferences.set`](mutable-preferences.md#set) (inside a `DataStore.edit` block) to change a value.

- `key` — the key for the preference.

Throws `ClassCastException` if something is stored under the same name but cannot be cast to `T`.

### toMutablePreferences

> Added in 1.0.0

```
fun toMutablePreferences(): MutablePreferences
```

Gets a mutable copy containing all the preferences in this `Preferences`. Useful for updating preferences without building a new object from scratch inside [`DataStore.updateData`](../androidx.datastore.core/data-store.md#updatedata).

### toPreferences

> Added in 1.0.0

```
fun toPreferences(): Preferences
```

Gets a read-only copy containing all the preferences in this `Preferences`.
