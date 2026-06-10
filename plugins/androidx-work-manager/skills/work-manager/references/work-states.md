# Work States

Work goes through a series of [`State`](../api/androidx.work/work-info-state.md) changes over its lifetime.

## One-Time Work States

A [one-time](define-work-requests.md#scheduling-one-time-work) work request begins in the `ENQUEUED` state, where it's eligible to run as soon as its [`Constraints`](../api/androidx.work/constraints.md) and initial delay timing requirements are met. From there it moves to `RUNNING`, and then, depending on the outcome, to `SUCCEEDED`, `FAILED`, or back to `ENQUEUED` if the result is [`retry`](../api/androidx.work/listenable-worker-result.md). At any point work can be cancelled, moving it to the `CANCELLED` state.

`SUCCEEDED`, `FAILED`, and `CANCELLED` are all terminal states. For work in any of these states, [`WorkInfo.State.isFinished()`](../api/androidx.work/work-info-state.md) returns `true`.

## Periodic Work States

Success and failure states apply only to one-time and [chained work](chaining-work.md). [Periodic work](define-work-requests.md#scheduling-periodic-work) has only one terminal state, `CANCELLED`, because periodic work never ends — after each run, it's rescheduled regardless of the result.

## Blocked State

The final state is `BLOCKED`, which applies to work orchestrated in a chain. Work chains and their state diagram are covered in [Chaining work](chaining-work.md).

> [!NOTE]
> Next, see [Managing work](managing-work.md) to observe and manage the progress of your work.
