# API Reference

> Last updated 2026-06-10

# WorkQuery.Builder

> Added in 2.4.0

```
class WorkQuery.Builder
```

A builder for [`WorkQuery`](work-query.md). Start with one of the `from*` companion factories, then refine with the `add*` methods.

## Public Companion Functions

### fromIds

> Added in 2.10.0
```
fun fromIds(ids: List<UUID>): WorkQuery.Builder
```

### fromStates

```
fun fromStates(states: List<WorkInfo.State>): WorkQuery.Builder
```

### fromTags

> Added in 2.10.0
```
fun fromTags(tags: List<String>): WorkQuery.Builder
```

### fromUniqueWorkNames

> Added in 2.10.0
```
fun fromUniqueWorkNames(uniqueWorkNames: List<String>): WorkQuery.Builder
```

## Public Functions

### addIds

> Added in 2.5.0
```
fun addIds(ids: List<UUID>): WorkQuery.Builder
```

Adds [`WorkRequest`](work-request.md) ids to the query.

### addStates

> Added in 2.4.0
```
fun addStates(states: List<WorkInfo.State>): WorkQuery.Builder
```

Adds [`WorkInfo.State`](work-info-state.md)s to the query.

### addTags

> Added in 2.4.0
```
fun addTags(tags: List<String>): WorkQuery.Builder
```

Adds [`WorkRequest`](work-request.md) tags to the query.

### addUniqueWorkNames

> Added in 2.4.0
```
fun addUniqueWorkNames(uniqueWorkNames: List<String>): WorkQuery.Builder
```

Adds unique work names to the query.

### build

> Added in 2.4.0
```
fun build(): WorkQuery
```

Creates the [`WorkQuery`](work-query.md). Throws `IllegalArgumentException` if none of ids, unique work names, tags, or states is set.
