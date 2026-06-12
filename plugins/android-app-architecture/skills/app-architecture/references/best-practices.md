# General best practices

Cross-cutting guidance that keeps a codebase robust, testable, and maintainable. None of these are mandatory, but follow them unless you have a specific reason not to.

**Don't store data in app components.** Activities, services, and broadcast receivers are short-lived; don't treat them as sources of data. Have each entry point coordinate with other components to retrieve only the subset of data relevant to it.

**Reduce dependencies on Android framework classes.** Let app components be the only classes that rely on SDK APIs like `Context` or `Toast`. Keeping other classes free of framework dependencies improves testability and reduces coupling.

**Define clear boundaries of responsibility between modules.** Don't spread one concern — loading data from the network — across many classes or packages, and don't pile unrelated concerns — data caching and data binding — into one class.

**Expose as little as possible from each module.** Don't create shortcuts that leak internal implementation details for a short-term gain; it becomes technical debt many times over as the codebase evolves.

**Types are responsible for their own concurrency policy.** A type doing long-running blocking work moves that work to the appropriate thread itself. Types should be *main-safe* — safe to call from the main thread without blocking it.

**Persist as much relevant, fresh data as possible.** Users should be able to keep using the app offline or on poor connections. See offline-first in the **`data-layer`** skill.

**Make each part of the app testable in isolation.** A well-defined API at each boundary — for example, between the code that fetches from the network and the code that persists it — is what makes the pieces independently testable. Mixing those concerns, or scattering them across the codebase, makes testing hard or impossible.

**Focus on what makes the app unique.** Don't reinvent boilerplate; let Jetpack and other recommended libraries handle the repetitive work.

> [!NOTE]
> UI-specific practices — adaptive and canonical layouts, preserving UI state across configuration changes, reusable and composable UI components — belong with the UI layer and its skill, not this foundation.
