# API Reference

> Last updated 2026-06-10

# Operation

> Added in 1.0.0

```
interface Operation
```

An object that provides information about the execution of an asynchronous command performed by [`WorkManager`](work-manager.md). Operations are generally tied to enqueue or cancel commands, which occur asynchronously; observe or await them using the returned `Operation`.

## Nested Types

| Type | Description |
|------|-------------|
| [`Operation.State`](operation-state.md) | The lifecycle state of an `Operation`. |
| [`Operation.State.FAILURE`](operation-state-failure.md) | An `Operation` which has failed. |
| [`Operation.State.IN_PROGRESS`](operation-state-in-progress.md) | An `Operation` which is in progress. |
| [`Operation.State.SUCCESS`](operation-state-success.md) | An `Operation` which is successful. |

## Public Functions

### getResult

> Added in 1.0.0
```
fun getResult(): ListenableFuture<Operation.State.SUCCESS!>
```

Gets a `ListenableFuture` for the terminal state of the `Operation`. Resolves only with [`SUCCESS`](operation-state-success.md); the [`FAILURE`](operation-state-failure.md) state surfaces as a `Throwable` on the future, and [`IN_PROGRESS`](operation-state-in-progress.md) is never reported. Call `Future.get()` to block until a terminal state is reached.

### getState

> Added in 1.0.0
```
fun getState(): LiveData<Operation.State!>
```

Gets a `LiveData` of the operation's [`State`](operation-state.md); observe it to receive updates.

## Extension Functions

`Operation` has a suspending `await()` extension for coroutines. See [`package-functions.md`](package-functions.md).
