# API Reference

> Last updated 2026-06-10

# SynchronousExecutor

> Added in 1.0.0

```
class SynchronousExecutor : Executor
```

An implementation of `Executor` which executes `Runnable`s synchronously. Used by [`WorkManagerTestInitHelper`](work-manager-test-init-helper.md) so background work runs inline on the calling thread during tests.

## Public Constructors

### SynchronousExecutor

> Added in 1.0.0
```
SynchronousExecutor()
```

## Public Functions

### execute

> Added in 1.0.0
```
fun execute(command: Runnable): Unit
```
