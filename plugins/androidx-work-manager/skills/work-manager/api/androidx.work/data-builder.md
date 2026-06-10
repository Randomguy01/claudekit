# API Reference

> Last updated 2026-06-10

# Data.Builder

> Added in 1.0.0

```
class Data.Builder
```

A builder for [`Data`](data.md) objects. Each `put` returns the builder for chaining.

> [!TIP]
> For a concise Kotlin literal, prefer the top-level [`workDataOf(vararg pairs)`](package-functions.md) function over the builder.

## Public Constructors

### Builder

> Added in 1.0.0
```
Builder()
```

## Public Functions

### build

> Added in 1.0.0
```
fun build(): Data
```

Builds a [`Data`](data.md) object containing all key-value pairs specified by this builder.

### putAll

> Added in 1.0.0
```
fun putAll(data: Data): Data.Builder
```

Puts all key-value pairs from a [`Data`](data.md) into the builder.

### putAll

> Added in 1.0.0
```
fun putAll(values: Map<String, Any?>): Data.Builder
```

Puts all key-value pairs from a `Map` into the builder. Valid value types are `Boolean`, `Integer`, `Long`, `Float`, `Double`, `String`, and their array versions; invalid types throw `IllegalArgumentException`.

### putBoolean

> Added in 1.0.0
```
fun putBoolean(key: String, value: Boolean): Data.Builder
```

### putBooleanArray

> Added in 1.0.0
```
fun putBooleanArray(key: String, value: BooleanArray): Data.Builder
```

### putByte

> Added in 2.1.0
```
fun putByte(key: String, value: Byte): Data.Builder
```

### putByteArray

> Added in 2.1.0
```
fun putByteArray(key: String, value: ByteArray): Data.Builder
```

### putDouble

> Added in 1.0.0
```
fun putDouble(key: String, value: Double): Data.Builder
```

### putDoubleArray

> Added in 1.0.0
```
fun putDoubleArray(key: String, value: DoubleArray): Data.Builder
```

### putFloat

> Added in 1.0.0
```
fun putFloat(key: String, value: Float): Data.Builder
```

### putFloatArray

> Added in 1.0.0
```
fun putFloatArray(key: String, value: FloatArray): Data.Builder
```

### putInt

> Added in 1.0.0
```
fun putInt(key: String, value: Int): Data.Builder
```

### putIntArray

> Added in 1.0.0
```
fun putIntArray(key: String, value: IntArray): Data.Builder
```

### putLong

> Added in 1.0.0
```
fun putLong(key: String, value: Long): Data.Builder
```

### putLongArray

> Added in 1.0.0
```
fun putLongArray(key: String, value: LongArray): Data.Builder
```

### putString

> Added in 1.0.0
```
fun putString(key: String, value: String?): Data.Builder
```

### putStringArray

> Added in 1.0.0
```
fun putStringArray(key: String, value: Array<String?>): Data.Builder
```
