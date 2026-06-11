# API Reference

> Last updated 2026-06-10

# androidx.datastore.preferences.core — Top-Level & Extension Functions

The package-level helpers for `androidx.datastore.preferences.core`: typed key builders, `Preferences` factories, and the `edit` extension. The types they return ([`Preferences`](preferences.md), [`Preferences.Key`](preferences-key.md), [`MutablePreferences`](mutable-preferences.md), [`Preferences.Pair`](preferences-pair.md)) are documented in the per-type files in this directory.

## Typed Key Builders

Each returns a [`Preferences.Key`](preferences-key.md) for the named preference. Do not use multiple keys with the same name for the same `Preferences` — overlapping keys with different types can throw `ClassCastException`.

### booleanPreferencesKey

> Added in 1.0.0

```
fun booleanPreferencesKey(name: String): Preferences.Key<Boolean>
```

### byteArrayPreferencesKey

> Added in 1.1.0

```
fun byteArrayPreferencesKey(name: String): Preferences.Key<ByteArray>
```

`ByteArray`s returned by DataStore are copies — mutating them does nothing to the underlying store; they must be set explicitly.

### doublePreferencesKey

> Added in 1.0.0

```
fun doublePreferencesKey(name: String): Preferences.Key<Double>
```

### floatPreferencesKey

> Added in 1.0.0

```
fun floatPreferencesKey(name: String): Preferences.Key<Float>
```

### intPreferencesKey

> Added in 1.0.0

```
fun intPreferencesKey(name: String): Preferences.Key<Int>
```

### longPreferencesKey

> Added in 1.0.0

```
fun longPreferencesKey(name: String): Preferences.Key<Long>
```

### stringPreferencesKey

> Added in 1.0.0

```
fun stringPreferencesKey(name: String): Preferences.Key<String>
```

### stringSetPreferencesKey

> Added in 1.0.0

```
fun stringSetPreferencesKey(name: String): Preferences.Key<Set<String>>
```

Sets returned by DataStore are unmodifiable and throw if mutated.

## Preferences Factories

### emptyPreferences

> Added in 1.0.0

```
fun emptyPreferences(): Preferences
```

Get a new empty [`Preferences`](preferences.md).

### preferencesOf

> Added in 1.0.0

```
fun preferencesOf(vararg pairs: Preferences.Pair<*>): Preferences
```

Construct a [`Preferences`](preferences.md) from a list of [`Preferences.Pair`](preferences-pair.md)s. Comparable to `mapOf()`.

```kotlin
val counterKey = intPreferencesKey("counter")
val preferences = preferencesOf(counterKey to 100)
```

- `pairs` — the key-value pairs with which to construct the preferences.

### mutablePreferencesOf

> Added in 1.0.0

```
fun mutablePreferencesOf(vararg pairs: Preferences.Pair<*>): MutablePreferences
```

Construct a [`MutablePreferences`](mutable-preferences.md) from a list of [`Preferences.Pair`](preferences-pair.md)s. Comparable to `mapOf()`.

- `pairs` — the key-value pairs with which to construct the preferences.

## Extension Functions

### DataStore.edit

```
suspend fun DataStore<Preferences>.edit(
    transform: suspend (MutablePreferences) -> Unit
): Preferences
```

Edit the value in a [`DataStore`](../androidx.datastore.core/data-store.md) transactionally in an atomic read-modify-write operation. All operations are serialized.

The coroutine completes once the data has been persisted durably to disk (after which `DataStore.data` reflects the update). If the transform or write fails, the transaction is aborted and an exception is thrown.

Values changed in `edit` are **not** updated in DataStore until after the transform completes — do not assume persistence until `edit` returns successfully. Do **not** store a reference to the [`MutablePreferences`](mutable-preferences.md) passed to `transform`; mutating it after `edit` returns has no effect (and may throw in future versions). See [`DataStore.updateData`](../androidx.datastore.core/data-store.md#updatedata).

```kotlin
val COUNTER_KEY = intPreferencesKey("my_counter")

dataStore.edit { prefs -> prefs[COUNTER_KEY] = (prefs[COUNTER_KEY] ?: 0) + 1 }
```

- `transform` — block which accepts a `MutablePreferences` containing all preferences currently in DataStore. Changes are persisted once `transform` completes.

Throws [`IOException`](../androidx.datastore.core/io-exception.md) when writing to disk fails, or any `Exception` thrown by the transform block.
