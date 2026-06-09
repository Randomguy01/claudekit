# API Reference

> Last updated 2026-06-08

# RoomDatabase.QueryCallback

> Added in 2.3.0

**Android**
```
fun interface RoomDatabase.QueryCallback
```

Callback interface for when SQLite queries are executed.

Can be set using [`RoomDatabase.Builder.setQueryCallback`](room-database-builder.md#setquerycallback).

## Public Functions

### onQuery

**Android**
> Added in 2.3.0
```
fun onQuery(sqlQuery: String, bindArgs: List<Any?>): Unit
```

Called when a SQL query is executed.

- `sqlQuery` — The SQLite query statement.
- `bindArgs` — Arguments of the query if available, empty list otherwise.
