# The layered architecture

Design every app with at least a UI layer and a data layer, plus an optional domain layer between them.

```
UI layer  →  Domain layer (optional)  →  Data layer
```

Each arrow is a dependency: a layer may know about the layer it points to, never the reverse. This is what lets each layer scale and be tested independently.

## UI layer

The UI layer (or *presentation layer*) displays application data on screen and reflects every change — whether from user interaction (pressing a button) or external input (a network response).

It comprises two kinds of construct:

- **UI elements** that render the data, built with Jetpack Compose.
- **State holders** such as `ViewModel` that hold data, expose it to the UI, and handle logic. A state holder should live as long as the UI element it serves — a screen's `ViewModel` survives until the screen leaves the navigation back stack.

State holders consume data from the domain or data layer; they never depend on a data source directly.

> [!NOTE]
> The UI layer gets its own dedicated skill (to follow). This foundation only covers how it fits the whole.

## Data layer

The data layer holds the app's *business logic* — the real-world rules that determine how application data is created, stored, and changed — and exposes that data to the rest of the app.

It is made of **repositories**, each owning one type of data (`MoviesRepository`, `PaymentsRepository`), and each repository draws on zero or more **data sources** — a network endpoint, a local database, or a file. Repositories are the only entry point to the data layer: nothing above them touches a data source directly, which lets the layers scale independently.

Build the data layer with the **`data-layer`** skill.

## Domain layer (optional)

The domain layer sits between the UI and data layers and encapsulates complex business logic, or simpler logic that is reused by multiple state holders. It is optional — add it to manage complexity or to share logic, not by default.

Its classes are *use cases* (or *interactors*), each responsible for a single piece of functionality — for example a `GetTimeZoneUseCase` that several view models rely on. A use case depends on data-layer repositories and is consumed by the UI layer.

## Modern techniques

A modern Android architecture also uses:

- Unidirectional data flow (UDF) in every layer — see `references/principles.md`.
- State holders in the UI layer to manage UI complexity.
- Kotlin coroutines and flows for asynchronous work.
- Dependency-injection best practices to provide and scope dependencies — see `references/dependency-injection.md`.
