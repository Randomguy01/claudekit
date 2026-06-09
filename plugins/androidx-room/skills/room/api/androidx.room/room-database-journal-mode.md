# API Reference

> Last updated 2026-06-08

# RoomDatabase.JournalMode

> Added in 2.0.0

```
enum RoomDatabase.JournalMode : Enum
```

Journal modes for SQLite database.

|              See also              |
| ---------------------------------- |
| [`RoomDatabase.Builder.setJournalMode`](room-database-builder.md#setjournalmode) |

## Enum Values

### AUTOMATIC

```
val RoomDatabase.JournalMode.AUTOMATIC: RoomDatabase.JournalMode
```

Let Room choose the journal mode. This is the default value when no explicit value is specified.

The actual value is [`TRUNCATE`](#truncate) when the device runs an API level lower than 16 or is a low-RAM device. Otherwise, [`WRITE_AHEAD_LOGGING`](#write_ahead_logging) is used.

### TRUNCATE

```
val RoomDatabase.JournalMode.TRUNCATE: RoomDatabase.JournalMode
```

Truncate journal mode.

### WRITE_AHEAD_LOGGING

```
val RoomDatabase.JournalMode.WRITE_AHEAD_LOGGING: RoomDatabase.JournalMode
```

Write-Ahead Logging mode.

## Public Functions

### valueOf

> Added in 2.0.0
```
fun valueOf(value: String): RoomDatabase.JournalMode
```

Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type (extraneous whitespace characters are not permitted). Throws `IllegalArgumentException` if this enum type has no constant with the specified name.

### values

> Added in 2.0.0
```
fun values(): Array<RoomDatabase.JournalMode>
```

Returns an array containing the constants of this enum type, in the order they're declared. This method may be used to iterate over the constants.

## Public Properties

### entries

```
val entries: EnumEntries<RoomDatabase.JournalMode>
```

Returns a representation of an immutable list of all enum entries, in the order they're declared. This may be used to iterate over the enum entries.
