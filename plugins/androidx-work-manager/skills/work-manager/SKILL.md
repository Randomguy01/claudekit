---
name: work-manager
description: >
  Schedule persistent, deferrable background work on Android with Jetpack
  WorkManager. Use this skill when the user needs tasks that keep running
  across app restarts and device reboots — immediate, long-running, or
  deferrable/periodic work; WorkRequests and Workers; constraints, retry and
  backoff, expedited work, and work chaining; or migrating off
  FirebaseJobDispatcher or GcmNetworkManager. Applies even when the user
  doesn't say "WorkManager" by name — e.g. "sync data in the background,"
  "run a task even if the app is closed," "schedule a periodic upload." Skip
  for in-process async work that can safely die with the process (use
  coroutines) and for exact alarms (use AlarmManager).
---

# WorkManager

To execute tasks that continue to run even if the app leaves the visible state, use the Jetpack library [WorkManager](api/androidx.work/work-manager.md). WorkManager features a robust scheduling mechanism that lets tasks persist across app restarts and device reboots.

## Types of Work

WorkManager handles three types of work:

- **Immediate**: Tasks that must begin immediately and complete soon. May be expedited.
- **Long Running**: Tasks which might run for longer, potentially longer than 10 minutes.
- **Deferrable**: Scheduled tasks that start at a later time and can run periodically.

| Type         | Periodicity          | How to access                                                                                           |
|--------------|----------------------|--------------------------------------------------------------------------------------------------------|
| Immediate    | One time             | `OneTimeWorkRequest` and `Worker`. For expedited work, call `setExpedited()` on your OneTimeWorkRequest. |
| Long Running | One time or periodic | Any `WorkRequest` or `Worker`. Call `setForeground()` in the Worker to handle the notification.         |
| Deferrable   | One time or periodic | `PeriodicWorkRequest` and `Worker`.                                                                     |

## Use WorkManager for Reliable Work

WorkManager is intended for work that is required to **run reliably** even if the user navigates off a screen, the app exits, or the device restarts. For example:

- Sending logs or analytics to backend services.
- Periodically syncing application data with a server.

WorkManager is not intended for in-process background work that can safely be terminated if the app process goes away. It is also not a general solution for all work that requires immediate execution. Review the [background processing guide](https://developer.android.com/guide/background) to see which solution meets your needs.

## Relationship to Other APIs

Use this table to choose between WorkManager and similar APIs:

| API              | Recommended for                                                                         | Relationship to WorkManager |
|------------------|-----------------------------------------------------------------------------------------|---|
| **Coroutines**   | All asynchronous work that doesn't need to persist if the app leaves the visible state. | Coroutines are the standard means of leaving the main thread in Kotlin. However, they stop as soon as the app closes. For work that should persist even after the app closes, use WorkManager. |
| **AlarmManager** | Alarms only.                                                                            | Unlike WorkManager's regular workers, AlarmManager's exact alarms wake a device from Doze mode. It is therefore not efficient in terms of power and resource management. Only use it for precise alarms or notifications such as calendar events, not for recurring background work. |

## Using This Skill

This skill is a router. Decide what the task needs, then read the matching file before writing or reviewing code:

- **`references/*.md`** — task guides. How to define, schedule, and manage work. **Read these first.**
- **`api/androidx.work/*.md`** — per-type API references. Exact constructor arguments, builder methods, and parameters. Drill in when you need the precise contract of a specific type.

## Reference guides (`references/`)

### Setup

- New to WorkManager or adding it to a project → `references/install.md`

### Defining and running work

- Build a WorkRequest — one-time vs periodic, constraints, input/output data, retry and backoff, expedited work, delays, and tags → `references/define-work-requests.md`
- Enqueue, observe, query, and cancel work → `references/managing-work.md`
- Understand the work lifecycle and what each state means → `references/work-states.md`
- Chain dependent tasks so output flows from one to the next → `references/chaining-work.md`
- Update work that's already enqueued without canceling it → `references/update-work.md`

### Specialized work

- Run long or foreground work that may exceed ten minutes → `references/long-running.md`
- Report progress from a worker and observe it from the UI → `references/observe-progress.md`

### Threading

- Choose a worker threading model — start here → `references/threading-overview.md`
- Synchronous/blocking work on a background thread → `references/threading-worker.md`
- Kotlin coroutines → `references/threading-coroutine-worker.md`
- RxJava → `references/threading-rxworker.md`
- Your own callback-based async APIs → `references/threading-listenableworker.md`

### Configuration and debugging

- Customize configuration and switch to on-demand initialization → `references/custom-configuration.md`
- Diagnose workers that run too often, or never → `references/debug.md`

### Testing

- Test worker logic in isolation (`TestWorkerBuilder` / `TestListenableWorkerBuilder`) → `references/test.md`
- Integration-test with `WorkManagerTestInitHelper` and `TestDriver` → `references/integration-test.md`

### Migration

- From FirebaseJobDispatcher → `references/migrate-firebase.md`
- From GcmNetworkManager → `references/migrate-gcm.md`

## API references (`api/`)

Each class, interface, and enum has its own file. Filenames are the kebab-case form of the type name (`OneTimeWorkRequest` → `one-time-work-request.md`, `Constraints.Builder` → `constraints-builder.md`). Each package lives in its own sibling directory under `api/` — run `ls api/` to discover the subpackages and `ls api/<package>/` for the full set within one.

Some primary types to start from:

- `api/androidx.work/work-manager.md` — the entry point for enqueuing and querying work
- `api/androidx.work/one-time-work-request.md`, `api/androidx.work/periodic-work-request.md` — the two request kinds
- `api/androidx.work/worker.md` — where your background logic lives
- `api/androidx.work/constraints.md` — conditions that must hold for work to run
- `api/androidx.work/data.md` — input and output payloads
- `api/androidx.work/work-info.md` — observed state of a work request

The `api/` tree covers three packages, each in its own directory:

- `api/androidx.work/` — the core package (`WorkManager`, `Worker`, `WorkRequest`, `Constraints`, `Data`, and the rest).
- `api/androidx.work.testing/` — test helpers such as `TestWorkerBuilder`, `TestListenableWorkerBuilder`, `WorkManagerTestInitHelper`, and `TestDriver`.
- `api/androidx.work.multiprocess/` — multi-process types such as `RemoteCoroutineWorker` and `RemoteListenableWorker`.

## Replace Deprecated APIs

The WorkManager API is the recommended replacement for previous Android background scheduling APIs, including [`FirebaseJobDispatcher`](references/migrate-firebase.md) and [`GcmNetworkManager`](references/migrate-gcm.md).

> [!NOTE]
> Your `FirebaseJobDispatcher` and `GcmNetworkManager` API calls no longer work on devices running Android Marshmallow (6.0) and above. Follow the migration guides for [`FirebaseJobDispatcher`](references/migrate-firebase.md) and [`GcmNetworkManager`](references/migrate-gcm.md) for guidance on migrating.
