# Testing the data layer

Dependency injection and interface-based data sources are what make the data layer testable: inject fake versions of dependencies that reach external resources to keep tests deterministic and reliable.

## Prefer fakes over mocks

For a data source or repository that talks to an external resource, write a **fake** — a real, working implementation of the interface backed by in-memory data — rather than mocking. Fakes behave like the real thing, so tests exercise real interactions instead of asserting on calls. This is why the layer exposes interfaces (see `library-selection.md` and `repositories-and-data-sources.md`).

## Unit tests

Use real objects where practical, and fake any dependency that reaches an external source — a file, the network. Test repository logic — conflict resolution, caching, mapping — against fake data sources.

Prefer **JVM unit tests** (`./gradlew testDebugUnitTest`), using Robolectric where an Android dependency is unavoidable, so the suite runs headless without a device.

## Integration tests

Tests that hit real external sources are less deterministic and need a device or emulator. Run them in a controlled environment:

- **Room** — create an **in-memory database** you fully control in tests → the `room` skill's testing guide.
- **Networking** — fake HTTP with **MockWebServer** (or WireMock) and assert the requests made → the `retrofit` skill's testing guide.
- **DataStore**, **WorkManager**, **Hilt** — each has its own testing guide in its skill (`data-store`, `WorkManagerTestInitHelper` in `work-manager`, `@HiltAndroidTest` with test bindings in `hilt`).

> [!IMPORTANT]
> Instrumented tests — a real Room database, `@HiltAndroidTest`, anything under `connectedAndroidTest` — need a device or emulator and may not run in a headless environment. Generate them where they're genuinely warranted, but if they can't be run here, report that rather than assuming they passed.

## Regression on modifications

When changing an existing data layer, run the **existing** test suite to prove you didn't break behavior — the compile step alone won't catch a behavioral regression. See `extending-existing-code.md`.
