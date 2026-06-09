# API Reference

> Last updated 2026-06-08

# FtsOptions.MatchInfo

> Added in 2.1.0

```
enum FtsOptions.MatchInfo : Enum
```

The FTS version used to store text matching information. See [`Fts4.matchInfo`](fts4.md#matchinfo).

## Enum Values

### FTS3

```
val FtsOptions.MatchInfo.FTS3: FtsOptions.MatchInfo
```

Text matching info as version 3 of the extension module.

### FTS4

```
val FtsOptions.MatchInfo.FTS4: FtsOptions.MatchInfo
```

Text matching info as version 4 of the extension module.

## Public Functions

### valueOf

> Added in 2.1.0
```
fun valueOf(value: String): FtsOptions.MatchInfo
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.1.0
```
fun values(): Array<FtsOptions.MatchInfo>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<FtsOptions.MatchInfo>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
