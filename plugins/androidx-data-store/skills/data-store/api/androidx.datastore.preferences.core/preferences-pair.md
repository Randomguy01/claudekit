# API Reference

> Last updated 2026-06-10

# Preferences.Pair

> Added in 1.0.0

```
class Preferences.Pair<T : Any?>
```

Key-value pairs for [`Preferences`](preferences.md). `T` is the type of the value. Construct these using the infix [`Preferences.Key.to`](preferences-key.md#to) function, then pass them to [`preferencesOf`](package-functions.md#preferencesof) / [`mutablePreferencesOf`](package-functions.md#mutablepreferencesof) or [`MutablePreferences.putAll`](mutable-preferences.md#putall).
