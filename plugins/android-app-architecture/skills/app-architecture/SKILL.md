---
name: app-architecture
description: >
  Understand and apply Android's recommended app architecture. Use this skill
  when the user designs or organizes the structure of an Android app — choosing
  the UI, domain, and data layers; applying separation of concerns, single
  source of truth (SSOT), or unidirectional data flow (UDF); deciding where
  state and business logic should live; or setting up dependency-injection
  boundaries between components. Applies even when the user doesn't say
  "architecture" by name — e.g. "how should I structure this app," "where
  should this logic go," "should this live in the ViewModel or the repository,"
  or "set up a clean, layered Android project." Skip for library-specific
  how-tos (use the room, retrofit, data-store, work-manager, or hilt skills)
  and for implementing one layer end-to-end (use the data-layer skill).
---

# App architecture

A well-defined architecture lets an Android app scale and stay maintainable, testable, and robust across the wide range of devices — and the resource-constrained, lifecycle-driven environment — that apps run in. This skill covers the principles and the layered structure Android recommends; the individual layers and libraries are built with the skills it links to.

Android app components (activities, services, broadcast receivers) are short-lived and can be created, destroyed, and launched out of order by the system. **Never store application data or state in app components** — it is lost when the component is recreated. Architecture exists to give that data and logic a stable home instead.

This skill is a router. Decide what you need, then read the matching reference before designing or reviewing structure:

- The layers and how they fit, the dependency rule, and modern techniques → `references/layers.md`
- The core principles in depth (separation of concerns, SSOT, UDF, …) → `references/principles.md`
- Managing dependencies — DI vs. service locator, Hilt, scoping → `references/dependency-injection.md`
- General cross-cutting best practices → `references/best-practices.md`

## The recommended architecture

Design every app with at least two layers, plus an optional third:

- **UI layer** — displays application data on screen and forwards user events. Built from UI elements (Jetpack Compose) and state holders (`ViewModel`).
- **Domain layer** *(optional)* — encapsulates complex or reused business logic as *use cases*. Add it only when it earns its place.
- **Data layer** — holds application data and business logic; exposes data through *repositories* backed by *data sources*.

Dependencies point in one direction only:

```
UI layer  →  Domain layer (optional)  →  Data layer
```

The UI layer depends on the domain or data layer; the domain layer depends on the data layer; the data layer depends on neither. Following this rule, **state flows down** (from data sources toward the UI) and **events flow up** (user actions travel back to the source of truth that owns the data).

> [!NOTE]
> Each arrow is a dependency: a layer may know about the layer it points to, never the reverse. This is what keeps each layer replaceable and independently testable.

## Core principles

Apply these in every layer, not just at the boundaries. Full treatment in `references/principles.md`.

- **Separation of concerns** — give methods, classes, modules, and layers clearly defined responsibilities; don't pile logic into an `Activity`.
- **Drive the UI from data models** — base the UI on data models (preferably persistent) that are independent of UI elements and app-component lifecycles.
- **Single source of truth (SSOT)** — assign each data type one owner that exposes it immutably and mediates every change to it.
- **Unidirectional data flow (UDF)** — state flows one direction (down toward the UI); the events that modify it flow the opposite direction (up to the SSOT).

## Building a layer

This foundation is the shared vocabulary. To implement a specific layer end-to-end, use its dedicated skill:

- **Data layer** — repositories, data sources, models and mappers, source of truth, caching, and offline-first → the **`data-layer`** skill, whose decision matrix routes to the `room`, `retrofit`, `data-store`, `work-manager`, and `hilt` skills for implementation.
- **Domain and UI layers** — dedicated skills to follow.
