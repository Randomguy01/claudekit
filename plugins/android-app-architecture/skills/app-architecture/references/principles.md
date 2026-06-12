# Architectural principles

These principles underpin every layer of a well-architected app. Apply them throughout, not only at the boundaries between layers.

## Separation of concerns

Split the app into methods, classes, files, packages, modules, and layers that each have clearly defined responsibilities and boundaries. The most common violation is writing all the code in an `Activity` or `Fragment`.

An `Activity`'s primary role is to host the UI. The system owns its lifecycle and frequently destroys and recreates it — in response to user actions like rotation, or system events like low memory. Anything stored in it is lost on recreation, so it is the wrong home for application data or state.

> [!IMPORTANT]
> Don't entrust application data or state to UI components. Give each piece of logic a home whose lifespan matches it.

## Drive the UI from data models

Drive the UI from data models — preferably *persistent* ones — that are independent of UI elements and other app components.

Persistent models are ideal because:

- Users don't lose data if the system destroys the app to reclaim resources.
- The app keeps working when the network is intermittent or unavailable.

Basing the app on data model classes makes it robust and testable.

## Single source of truth (SSOT)

When you define a new data type, assign it a single source of truth — the *owner* of that data. Only the SSOT may modify it. The SSOT exposes the data as an **immutable** type, and exposes functions (or receives events) that other types call to request a change.

This pattern:

- Centralizes all changes to a data type in one place.
- Protects the data so unrelated types can't put it in an inconsistent state.
- Makes changes traceable, so bugs are easier to spot.

In an offline-first app, the SSOT for application data is typically a local database. In other cases it can be a `ViewModel` — for UI state. Choosing a data type's source of truth is covered in the `data-layer` skill.

## Unidirectional data flow (UDF)

Pair the SSOT with unidirectional data flow. In UDF, **state flows in only one direction, and the events that modify the state flow in the opposite direction.**

- State flows from higher-scoped types down to lower-scoped ones — typically from data sources toward the UI.
- Events flow up from lower-scoped types until they reach the SSOT for that data type. A button press, for example, travels from the UI to the SSOT, which modifies the data and re-exposes it immutably.

This keeps data consistent, makes the app less error-prone and easier to debug, and preserves every benefit of the SSOT pattern.
