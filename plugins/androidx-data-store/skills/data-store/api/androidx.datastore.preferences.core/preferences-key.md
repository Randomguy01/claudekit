# API Reference

> Last updated 2026-06-10

# Preferences.Key

> Added in 1.0.0

```
class Preferences.Key<T : Any?>
```

Key for values stored in [`Preferences`](preferences.md). `T` is the type of the associated value, and must be one of: `Boolean`, `Int`, `Long`, `Float`, `String`, `Set<String>`, `Double`, `ByteArray`.

Construct keys for your data type using the typed builders in [package functions](package-functions.md) — [`booleanPreferencesKey`](package-functions.md#booleanpreferenceskey), [`intPreferencesKey`](package-functions.md#intpreferenceskey), [`longPreferencesKey`](package-functions.md#longpreferenceskey), [`floatPreferencesKey`](package-functions.md#floatpreferenceskey), [`stringPreferencesKey`](package-functions.md#stringpreferenceskey), [`stringSetPreferencesKey`](package-functions.md#stringsetpreferenceskey), [`doublePreferencesKey`](package-functions.md#doublepreferenceskey), [`byteArrayPreferencesKey`](package-functions.md#bytearraypreferenceskey).

## Public Functions

### to

> Added in 1.0.0

```
infix fun to(value: T): Preferences.Pair<T>
```

Infix function to create a [`Preferences.Pair`](preferences-pair.md), used to support [`preferencesOf`](package-functions.md#preferencesof) and [`MutablePreferences.putAll`](mutable-preferences.md#putall).

- `value` — the value this preferences key should point to.

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

## Public Properties

### name

> Added in 1.0.0

```
val name: String
```

## Extension Functions

### Preferences.Key.toParametersKey

**Android**

```
fun <T : Any> Preferences.Key<T>.toParametersKey(): ActionParameters.Key<T>
```

Creates an `androidx.glance.action.ActionParameters.Key` from a preferences key. Provided by the `androidx.glance:glance` artifact.
