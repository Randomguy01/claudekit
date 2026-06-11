# API Reference

> Last updated 2026-06-10

# MutablePreferences

> Added in 1.0.0

```
class MutablePreferences : Preferences
```

Mutable version of [`Preferences`](preferences.md). Allows creating `Preferences` with different key-value pairs. You usually obtain one inside a [`DataStore.edit`](package-functions.md#datastoreedit) block.

## Public Functions

### set

> Added in 1.0.0

```
operator fun <T : Any?> set(key: Preferences.Key<T>, value: T): Unit
```

Set a key-value pair.

```kotlin
val COUNTER_KEY = intPreferencesKey("counter")
preferenceStore.edit { prefs -> prefs[COUNTER_KEY] = (prefs[COUNTER_KEY] ?: 0) + 1 }
```

- `key` — the preference to set.
- `value` — the value to set the preference to.

### remove

> Added in 1.0.0

```
fun <T : Any?> remove(key: Preferences.Key<T>): T
```

Remove a preference, returning its original value.

### clear

> Added in 1.0.0

```
fun clear(): Unit
```

Removes all preferences.

### putAll

> Added in 1.0.0

```
fun putAll(vararg pairs: Preferences.Pair<*>): Unit
```

Appends or replaces all `pairs` in this `MutablePreferences`.

### plusAssign

> Added in 1.0.0

```
operator fun plusAssign(pair: Preferences.Pair<*>): Unit
```

Appends or replaces a single [`Preferences.Pair`](preferences-pair.md).

```kotlin
mutablePrefs += COUNTER_KEY to 100
```

### plusAssign

> Added in 1.0.0

```
operator fun plusAssign(prefs: Preferences): Unit
```

Appends or replaces all pairs from `prefs`; keys in `prefs` overwrite keys in this `MutablePreferences`.

```kotlin
mutablePrefs += preferencesOf(COUNTER_KEY to 100, NAME to "abcdef")
```

### minusAssign

> Added in 1.0.0

```
operator fun minusAssign(key: Preferences.Key<*>): Unit
```

Removes the preference with the given key; a no-op if absent.

```kotlin
mutablePrefs -= COUNTER_KEY
```

### asMap

```
open fun asMap(): Map<Preferences.Key<*>, Any>
```

Retrieve an unmodifiable map of all key-preference pairs.

### contains

```
open operator fun <T : Any?> contains(key: Preferences.Key<T>): Boolean
```

Returns true if this contains the specified key.

### get

```
open operator fun <T : Any?> get(key: Preferences.Key<T>): T?
```

Get a preference by key, or `null` if not set. If `T` is a `Set`, the returned set is unmodifiable. Throws `ClassCastException` if a value stored under the same name cannot be cast to `T`.

### equals

```
open operator fun equals(other: Any?): Boolean
```

### hashCode

```
open fun hashCode(): Int
```

### toString

```
open fun toString(): String
```

For better debugging.

## Inherited Functions

From [`Preferences`](preferences.md): [`copy`](preferences.md#copy), [`toMutablePreferences`](preferences.md#tomutablepreferences), [`toPreferences`](preferences.md#topreferences).
