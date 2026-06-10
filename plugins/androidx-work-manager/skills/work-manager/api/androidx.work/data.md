# API Reference

> Last updated 2026-06-10

# Data

> Added in 1.0.0

```
class Data
```

A persistable set of key/value pairs used as inputs and outputs for [`ListenableWorker`](listenable-worker.md)s. Keys are `String`s; values can be `String`s, primitive types, or their array variants.

> [!CAUTION]
> This is a lightweight container, not a data store. The serialized payload is limited to [`MAX_DATA_BYTES`](#max_data_bytes); serializing or deserializing past this limit throws `IllegalStateException`.

## Nested Types

| Type | Description |
|------|-------------|
| [`Data.Builder`](data-builder.md) | A builder for `Data` objects. |

## Constants

### MAX_DATA_BYTES

```
const val MAX_DATA_BYTES: Int
```

The maximum number of bytes for `Data` when serialized to a byte array.

## Public Companion Functions

### fromByteArray

> Added in 2.10.0
```
@TypeConverter
fun fromByteArray(bytes: ByteArray): Data
```

Converts a byte array to `Data`. Throws `IllegalStateException` if `bytes` is bigger than [`MAX_DATA_BYTES`](#max_data_bytes).

## Public Companion Properties

### EMPTY

```
val EMPTY: Data
```

An empty `Data` object with no elements.

## Public Constructors

### Data

> Added in 1.0.0
```
Data(other: Data)
```

Copy constructor.

## Public Functions

Each getter takes a key and (for primitives) a default value returned when the key is absent; array getters return `null` when the key is absent.

### getBoolean

> Added in 1.0.0
```
fun getBoolean(key: String, defaultValue: Boolean): Boolean
```

### getBooleanArray

> Added in 1.0.0
```
fun getBooleanArray(key: String): BooleanArray?
```

### getByte

> Added in 2.1.0
```
fun getByte(key: String, defaultValue: Byte): Byte
```

### getByteArray

> Added in 2.1.0
```
fun getByteArray(key: String): ByteArray?
```

### getDouble

> Added in 1.0.0
```
fun getDouble(key: String, defaultValue: Double): Double
```

### getDoubleArray

> Added in 1.0.0
```
fun getDoubleArray(key: String): DoubleArray?
```

### getFloat

> Added in 1.0.0
```
fun getFloat(key: String, defaultValue: Float): Float
```

### getFloatArray

> Added in 1.0.0
```
fun getFloatArray(key: String): FloatArray?
```

### getInt

> Added in 1.0.0
```
fun getInt(key: String, defaultValue: Int): Int
```

### getIntArray

> Added in 1.0.0
```
fun getIntArray(key: String): IntArray?
```

### getLong

> Added in 1.0.0
```
fun getLong(key: String, defaultValue: Long): Long
```

### getLongArray

> Added in 1.0.0
```
fun getLongArray(key: String): LongArray?
```

### getString

> Added in 1.0.0
```
fun getString(key: String): String?
```

### getStringArray

> Added in 1.0.0
```
fun getStringArray(key: String): Array<String>?
```

### hasKeyWithValueOfType

> Added in 2.3.0
```
fun <T : Any?> hasKeyWithValueOfType(key: String, klass: Class<T>): Boolean
```

Returns `true` if this `Data` has a non-null value for the given key with the expected type `T`. A reified Kotlin extension form is also available — see [`package-functions.md`](package-functions.md).

### toByteArray

> Added in 2.3.0
```
fun toByteArray(): ByteArray
```

Converts this `Data` to a byte array suitable for sending to other processes in your application. There are no versioning guarantees, so do not use it for inter-app IPC or persistence. Throws `IllegalStateException` if the serialized payload exceeds [`MAX_DATA_BYTES`](#max_data_bytes).

## Public Properties

### keyValueMap

> Added in 1.0.0
```
val keyValueMap: Map<String, Any?>
```
