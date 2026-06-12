# Managing dependencies between components

Classes depend on other classes to function. Use a consistent pattern to supply those dependencies rather than constructing them inline:

- **Dependency injection (DI)** — a class declares its dependencies without constructing them; something else provides them at runtime.
- **Service locator** — a registry that classes pull their dependencies from instead of constructing them.

Both patterns let the code scale: they give clear rules for managing dependencies without duplicating code, and they make it easy to swap test and production implementations.

> [!IMPORTANT]
> Use the dependency-injection pattern, with the [Hilt](https://developer.android.com/training/dependency-injection/hilt-android) library, in Android apps. Hilt constructs objects by walking the dependency graph, verifies dependencies at compile time, and creates dependency containers scoped to Android framework classes. Wire it up with the **`hilt`** skill.

## Constructor injection

Following DI best practices, a class takes its dependencies in its constructor. A repository, for example, takes its data sources:

```kotlin
class ExampleRepository(
    private val exampleRemoteDataSource: ExampleRemoteDataSource, // network
    private val exampleLocalDataSource: ExampleLocalDataSource,    // database
)
```

This keeps dependencies explicit and lets tests inject fake implementations.

## Scoping and lifecycle

A dependency's lifecycle decides how to provide it. Scope an instance to the component that owns the relevant lifespan:

- Crucial to the whole app (and holding in-memory state worth reusing) → scope it to the `Application`, so it follows the application's lifecycle.
- Relevant only within one flow — registration, login → scope it to that flow's owner, such as its navigation graph.

Scoping instances to dependency containers is a DI responsibility. Hilt manages it through its components; see the **`hilt`** skill for the available scopes, and the **`data-layer`** skill for choosing a data class's lifecycle.
