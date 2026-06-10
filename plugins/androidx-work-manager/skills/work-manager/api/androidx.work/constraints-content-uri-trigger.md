# API Reference

> Last updated 2026-06-10

# Constraints.ContentUriTrigger

> Added in 2.8.0

```
class Constraints.ContentUriTrigger
```

Describes a content uri trigger on the [`WorkRequest`](work-request.md): it should run when a local `content:` `Uri` is updated. Identical to the `JobScheduler` functionality described in `JobInfo.Builder.addTriggerContentUri`.

## Public Constructors

### ContentUriTrigger

> Added in 2.8.0
```
ContentUriTrigger(uri: Uri, isTriggeredForDescendants: Boolean)
```

## Public Properties

### isTriggeredForDescendants

> Added in 2.8.0
```
val isTriggeredForDescendants: Boolean
```

`true` if the trigger also applies to descendants of the `Uri`.

### uri

> Added in 2.8.0
```
val uri: Uri
```

The local `content:` `Uri` to observe.
