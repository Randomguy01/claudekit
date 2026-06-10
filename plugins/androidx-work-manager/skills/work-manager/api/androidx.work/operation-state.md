# API Reference

> Last updated 2026-06-10

# Operation.State

> Added in 1.0.0

```
abstract class Operation.State
```

The lifecycle state of an [`Operation`](operation.md).

## Known Direct Subtypes

| Type | Description |
|------|-------------|
| [`Operation.State.FAILURE`](operation-state-failure.md) | An `Operation` which has failed. |
| [`Operation.State.IN_PROGRESS`](operation-state-in-progress.md) | An `Operation` which is in progress. |
| [`Operation.State.SUCCESS`](operation-state-success.md) | An `Operation` which is successful. |
