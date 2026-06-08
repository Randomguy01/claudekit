# API Reference

> Last updated 2026-06-08

# TransactionScope

> Added in 2.7.0

```
interface TransactionScope<T : Any?> : PooledConnection
```

A [`PooledConnection`](pooled-connection.md) with an active transaction capable of performing nested transactions.

|       See also       |
| -------------------- |
| [`Transactor`](transactor.md) |

## Public Functions

### rollback

```
suspend fun rollback(result: T): Nothing
```

Rolls back the transaction, completing it and returning the `result`.

|             See also              |
| --------------------------------- |
| [`Transactor.withTransaction`](transactor.md#withtransaction) |
| [`withNestedTransaction`](#withnestedtransaction) |

### withNestedTransaction

```
suspend fun <R : Any?> withNestedTransaction(block: suspend TransactionScope<R>.() -> R): R
```

Begins a nested transaction and runs `block` within the transaction. If `block` fails to complete normally — an exception is thrown, or [`rollback`](#rollback) is invoked — the transaction is rolled back; otherwise it is committed.

A nested transaction is still governed by its parent transaction, which must also complete successfully for all its children transactions to be committed.

- `block` — The code that will execute within the transaction.

## Inherited Functions

From [`PooledConnection`](pooled-connection.md): [`usePrepared`](pooled-connection.md#useprepared).
