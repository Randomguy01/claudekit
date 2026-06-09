# API Reference

> Last updated 2026-06-08

# InvalidationTracker.Observer

> Added in 2.0.0

**Android**
```
abstract class InvalidationTracker.Observer
```

An observer that can listen for changes in the database by subscribing to an [`InvalidationTracker`](invalidation-tracker.md).

## Public Constructors

### Observer

**Android**
> Added in 2.0.0
```
Observer(tables: Array<String>)
```

- `tables` — The names of the tables this observer is interested in getting notified about if they are modified.

## Protected Constructors

### Observer

**Android**
> Added in 2.0.0
```
protected Observer(firstTable: String, vararg rest: String)
```

Creates an observer for the given tables and views.

- `firstTable` — The name of the table or view.
- `rest` — More names of tables or views.

## Public Functions

### onInvalidated

**Android**
> Added in 2.0.0
```
abstract fun onInvalidated(tables: Set<String>): Unit
```

Invoked when one of the observed tables is invalidated (changed).

- `tables` — A set of invalidated tables. When the observer is interested in multiple tables, this set distinguishes which of the observed tables were invalidated. When observing a database view, the names of the underlying tables are in the set instead of the view name.
