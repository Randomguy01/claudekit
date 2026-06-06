# API Reference

> Last updated 2026-06-05

# OnConflictStrategy

> Added in 2.0.0

```
@Retention(value = AnnotationRetention.BINARY)
@IntDef(value = [0, 1, 2, 3, 4, 5])
annotation OnConflictStrategy
```

Set of conflict handling strategies for various [`Dao`](dao.md) methods.

## Constants

### ABORT

> Added in 2.5.0

```
const val ABORT = 3: Int
```

OnConflict strategy constant to abort the transaction. *The transaction is rolled back.*

### FAIL

> Added in 2.5.0
> Deprecated in 2.5.0

```
const val FAIL = 4: Int
```

**This property is deprecated. Use [`ABORT`](#abort) instead.**

OnConflict strategy constant to fail the transaction.

Does not work as expected. The transaction is rolled back. Use [`ABORT`](#abort).

### IGNORE

> Added in 2.5.0

```
const val IGNORE = 5: Int
```

OnConflict strategy constant to ignore the conflict.

An [`Insert`](insert.md) DAO method that returns the inserted rows ids will return -1 for rows that are not inserted since this strategy will ignore the row if there is a conflict.

### NONE

> Added in 2.5.0

```
const val NONE = 0: Int
```

OnConflict strategy constant used by default when no other strategy is set. Using it prevents Room from generating ON CONFLICT clause. It may be useful when there is a need to use ON CONFLICT clause within a trigger. The runtime behavior is the same as when [`ABORT`](#abort) strategy is applied. *The transaction is rolled back.*

### REPLACE

> Added in 2.5.0

```
const val REPLACE = 1: Int
```

OnConflict strategy constant to replace the old data and continue the transaction.

An [`Insert`](insert.md) DAO method that returns the inserted rows ids will never return -1 since this strategy will always insert a row even if there is a conflict.

### ROLLBACK

> Added in 2.5.0
> Deprecated in 2.5.0

```
const val ROLLBACK = 2: Int
```

**This property is deprecated. Use [`ABORT`](#abort) instead.**

OnConflict strategy constant to rollback the transaction.

Does not work with Android's current SQLite bindings. Use [`ABORT`](#abort) to roll back the transaction.

## Public Constructors

### OnConflictStrategy

```
OnConflictStrategy()
```
