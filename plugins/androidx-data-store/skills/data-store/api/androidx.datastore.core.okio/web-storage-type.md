# API Reference

> Last updated 2026-06-10

# WebStorageType

**JavaScript**

```
enum WebStorageType : Enum
```

The web storage backend used by [`WebStorage`](web-storage.md).

## Enum Values

### LOCAL

```
val WebStorageType.LOCAL: WebStorageType
```

Backed by the browser's `localStorage` (persists across sessions).

### SESSION

```
val WebStorageType.SESSION: WebStorageType
```

Backed by the browser's `sessionStorage` (cleared when the session ends).

## Enum Members

Provides the standard Kotlin enum members `valueOf(value: String)`, `values()`, and `entries`.
