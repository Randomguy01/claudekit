# API Reference

> Last updated 2026-06-10

# NetworkType

> Added in 1.0.0

```
enum NetworkType : Enum
```

An enumeration of various network types that can be used as [`Constraints`](constraints.md) for work.

## Enum Values

### CONNECTED

```
val NetworkType.CONNECTED: NetworkType
```

Any working network connection is required for this work.

### METERED

```
val NetworkType.METERED: NetworkType
```

A metered network connection is required for this work.

### NOT_REQUIRED

```
val NetworkType.NOT_REQUIRED: NetworkType
```

A network is not required for this work.

### NOT_ROAMING

```
val NetworkType.NOT_ROAMING: NetworkType
```

A non-roaming network connection is required for this work.

### TEMPORARILY_UNMETERED

```
val NetworkType.TEMPORARILY_UNMETERED: NetworkType
```

A temporarily unmetered network. This capability is set for networks that are generally metered but are currently unmetered.

> [!NOTE]
> This capability can change at any time. When it is removed, [`ListenableWorker`](listenable-worker.md)s are responsible for stopping any data transfer that should not occur on a metered network.

### UNMETERED

```
val NetworkType.UNMETERED: NetworkType
```

An unmetered network connection is required for this work.

## Public Functions

### valueOf

> Added in 1.0.0
```
fun valueOf(value: String): NetworkType
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 1.0.0
```
fun values(): Array<NetworkType>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<NetworkType>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
