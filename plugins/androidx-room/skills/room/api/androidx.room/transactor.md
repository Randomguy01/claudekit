# API Reference

> Last updated 2026-06-08

# Transactor

> Added in 2.7.0

```
interface Transactor : PooledConnection
```

A [`PooledConnection`](pooled-connection.md) that can perform transactions.

## Nested Types

| Type |
|------|
| `enum` [`Transactor.SQLiteTransactionType`](transactor-sqlite-transaction-type.md) — Transaction types. |

## Public Functions

### inTransaction

```
suspend fun inTransaction(): Boolean
```

Returns `true` if this connection has an active transaction, otherwise `false`.

### withTransaction

```
suspend fun <R : Any?> withTransaction(
    type: Transactor.SQLiteTransactionType,
    block: suspend TransactionScope<R>.() -> R
): R
```

Begins a transaction and runs `block` within the transaction. If `block` fails to complete normally — an exception is thrown, or [`TransactionScope.rollback()`](transaction-scope.md#rollback) is invoked — the transaction is rolled back; otherwise it is committed.

If [`inTransaction()`](#intransaction) returns `true` when this function is invoked, it is the equivalent of starting a nested transaction as if [`TransactionScope.withNestedTransaction()`](transaction-scope.md#withnestedtransaction) was invoked, and the `type` is ignored since it is inherited from the parent transaction.

See also the [SQLite transaction documentation](https://www.sqlite.org/lang_transaction.html).

- `type` — The type of transaction to begin.
- `block` — The code that will execute within the transaction.

## Extension Functions

### deferredTransaction

```
suspend fun <R : Any?> Transactor.deferredTransaction(block: suspend TransactionScope<R>.() -> R): R
```

Performs a [`SQLiteTransactionType.DEFERRED`](transactor-sqlite-transaction-type.md#deferred) transaction within `block`.

### exclusiveTransaction

```
suspend fun <R : Any?> Transactor.exclusiveTransaction(block: suspend TransactionScope<R>.() -> R): R
```

Performs a [`SQLiteTransactionType.EXCLUSIVE`](transactor-sqlite-transaction-type.md#exclusive) transaction within `block`.

### immediateTransaction

```
suspend fun <R : Any?> Transactor.immediateTransaction(block: suspend TransactionScope<R>.() -> R): R
```

Performs a [`SQLiteTransactionType.IMMEDIATE`](transactor-sqlite-transaction-type.md#immediate) transaction within `block`.

## Inherited Functions

From [`PooledConnection`](pooled-connection.md): [`usePrepared`](pooled-connection.md#useprepared).
