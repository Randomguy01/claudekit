# API Reference

> Last updated 2026-06-08

# PooledConnection

> Added in 2.7.0

```
interface PooledConnection
```

A wrapper of `SQLiteConnection` that belongs to a connection pool and is safe to use in a coroutine.

## Known Direct Subtypes

| Type |
|------|
| [`TransactionScope`](transaction-scope.md) — A `PooledConnection` with an active transaction capable of performing nested transactions. |
| [`Transactor`](transactor.md) — A `PooledConnection` that can perform transactions. |

## Public Functions

### usePrepared

```
suspend fun <R : Any?> usePrepared(sql: String, block: (SQLiteStatement) -> R): R
```

Prepares a new SQL statement and uses it within `block`.

Using the given `SQLiteStatement` after `usePrepared()` completes is prohibited. The statement is also thread-confined; attempting to use it from another thread is an error. Using a statement locks the connection it belongs to, so avoid long-running computations within `block`.

- `sql` — The SQL statement to prepare.
- `block` — The code to use the statement.

## Extension Functions

### execSQL

```
suspend fun PooledConnection.execSQL(sql: String): Unit
```

Executes a single SQL statement that returns no values.

- `sql` — The SQL statement to execute.
