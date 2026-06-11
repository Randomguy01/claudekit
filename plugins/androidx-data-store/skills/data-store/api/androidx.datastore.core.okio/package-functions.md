# API Reference

> Last updated 2026-06-10

# androidx.datastore.core.okio — Top-Level Functions

The package-level helper in `androidx.datastore.core.okio`.

## Top-Level Functions

### createSingleProcessCoordinator

> Added in 1.1.0

```
fun createSingleProcessCoordinator(path: Path): InterProcessCoordinator
```

Create an [`InterProcessCoordinator`](../androidx.datastore.core/inter-process-coordinator.md) for single-process use cases, keyed by an okio `Path`.

- `path` — the canonical path of the file managed by the coordinator.
