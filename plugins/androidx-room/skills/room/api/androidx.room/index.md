# API Reference

> Last updated 2026-06-05

# Index

> Added in 2.0.0

```
@Target(allowedTargets = [])
@Retention(value = AnnotationRetention.BINARY)
annotation Index
```

Declares an index on an [`Entity`](entity.md).

Adding an index usually speeds up your SELECT queries but will slow down other queries like INSERT or UPDATE. You should be careful when adding indices to ensure that this additional cost is worth the gain.

There are 2 ways to define an index in an [`Entity`](entity.md). You can either set [`ColumnInfo.index`](column-info.md#index) property to index individual fields or define composite indices via [`Entity.indices`](entity.md#indices).

If an indexed field is embedded into another Entity via [`Embedded`](embedded.md), it is **NOT** added as an index to the containing [`Entity`](entity.md). If you want to keep it indexed, you must re-declare it in the containing [`Entity`](entity.md).

Similarly, if an [`Entity`](entity.md) extends another class, indices from the super classes are **NOT** inherited. You must re-declare them in the child [`Entity`](entity.md) or set [`Entity.inheritSuperIndices`](entity.md#inheritsuperindices) to `true`.

## Nested Types

| Type |
|------|
| `enum` [`Index.Order`](index-order.md) |

## Public Constructors

### Index

> Added in 2.8.4

```
Index(
    vararg value: String,
    orders: Array<Index.Order> = [],
    name: String = "",
    unique: Boolean = false
)
```

## Public Properties

### name

```
val name: String
```

Name of the index. If not set, Room will set it to the list of columns joined by '_' and prefixed by "index_${tableName}". So if you have a table with name "Foo" and with an index of {"bar", "baz"}, generated index name will be "index_Foo_bar_baz". If you need to specify the index in a query, you should never rely on this name, instead, specify a name for your index.

### orders

```
val orders: Array<Index.Order>
```

List of column sort orders in the Index.

The number of entries in the array should be equal to size of columns in [`value`](#value).

The default order of all columns in the index is [`Index.Order.ASC`](index-order.md#asc).

Note that there is no value in providing a sort order on a single-column index. Column sort order of an index are relevant on multi-column indices and specifically in those that are considered 'covering indices', for such indices specifying an order can have performance improvements on queries containing ORDER BY clauses.

As an example, consider a table called 'Song' with two columns, 'name' and 'length'. If a covering index is created for it: `CREATE INDEX song_name_length on Song(name ASC, length DESC)`, then a query containing an ORDER BY clause with matching order of the index will be able to avoid a table scan by using the index, but a mismatch in order won't. Therefore the columns order of the index should be the same as the most frequently executed query with sort order.

### unique

```
val unique: Boolean
```

If set to true, this will be a unique index and any duplicates will be rejected.

### value

```
val value: Array<String>
```

List of column names in the Index.

The order of columns is important as it defines when SQLite can use a particular index.
