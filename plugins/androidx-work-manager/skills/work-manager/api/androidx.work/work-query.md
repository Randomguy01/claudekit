# API Reference

> Last updated 2026-06-10

# WorkQuery

> Added in 2.4.0

```
class WorkQuery
```

A specification for querying [`WorkRequest`](work-request.md)s, comprising four components: ids, unique work names, tags, and [`WorkInfo.State`](work-info-state.md)s. Components are `AND`-ed together; values within a component are `OR`-ed:

```
(id1 OR id2 OR …) AND (name1 OR …) AND (tag1 OR …) AND (state1 OR …)
```

Pass a `WorkQuery` to [`WorkManager.getWorkInfos`](work-manager.md) and its variants.

## Nested Types

| Type | Description |
|------|-------------|
| [`WorkQuery.Builder`](work-query-builder.md) | A builder for `WorkQuery`. |

## Public Companion Functions

Each `from*` factory creates a query seeded with a single component (`List` and `vararg` overloads available):

### fromIds

> Added in 2.10.0
```
fun fromIds(ids: List<UUID>): WorkQuery
fun fromIds(vararg ids: UUID): WorkQuery
```

### fromStates

```
fun fromStates(states: List<WorkInfo.State>): WorkQuery
fun fromStates(vararg states: WorkInfo.State): WorkQuery
```

### fromTags

> Added in 2.10.0
```
fun fromTags(tags: List<String>): WorkQuery
fun fromTags(vararg tags: String): WorkQuery
```

### fromUniqueWorkNames

> Added in 2.10.0
```
fun fromUniqueWorkNames(uniqueWorkNames: List<String>): WorkQuery
fun fromUniqueWorkNames(vararg uniqueWorkNames: String): WorkQuery
```

## Public Properties

### ids

> Added in 2.5.0
```
val ids: List<UUID>
```

The [`WorkRequest`](work-request.md) ids being queried.

### states

> Added in 2.4.0
```
val states: List<WorkInfo.State>
```

The [`WorkInfo.State`](work-info-state.md)s being queried.

### tags

> Added in 2.4.0
```
val tags: List<String>
```

The tags being queried.

### uniqueWorkNames

> Added in 2.4.0
```
val uniqueWorkNames: List<String>
```

The unique work names being queried.
