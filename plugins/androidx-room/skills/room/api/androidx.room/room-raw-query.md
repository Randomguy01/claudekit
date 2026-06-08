# API Reference

> Last updated 2026-06-08

# RoomRawQuery

> Added in 2.7.0

```
class RoomRawQuery
```

A query with an argument binding function.

|       See also       |
| -------------------- |
| [`@RawQuery`](raw-query.md) |

## Public Constructors

### RoomRawQuery

> Added in 2.7.0
```
RoomRawQuery(sql: String, onBindStatement: (SQLiteStatement) -> Unit = {})
```

## Public Functions

### getBindingFunction

> Added in 2.7.0
```
fun getBindingFunction(): (SQLiteStatement) -> Unit
```

## Public Properties

### sql

> Added in 2.7.0
```
val sql: String
```

The SQL query. The query can have placeholders (`?`) to bind arguments.
