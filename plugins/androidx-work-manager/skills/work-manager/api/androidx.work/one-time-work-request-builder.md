# API Reference

> Last updated 2026-06-10

# OneTimeWorkRequest.Builder

> Added in 1.0.0

```
class OneTimeWorkRequest.Builder : WorkRequest.Builder
```

Builder for [`OneTimeWorkRequest`](one-time-work-request.md)s.

## Public Constructors

### Builder

> Added in 1.0.0
```
Builder(workerClass: Class<ListenableWorker>)
```

Creates a builder for the given [`ListenableWorker`](listenable-worker.md) class.

### Builder

> Added in 2.10.0
```
Builder(workerClass: KClass<ListenableWorker>)
```

`KClass` overload of the above.

## Public Functions

### setInputMerger

> Added in 1.0.0
```
fun setInputMerger(inputMerger: Class<InputMerger>): OneTimeWorkRequest.Builder
```

Specifies the [`InputMerger`](input-merger.md) class for this [`OneTimeWorkRequest`](one-time-work-request.md). Before workers run they receive input [`Data`](data.md) from their parent workers plus anything set via [`WorkRequest.Builder.setInputData`](work-request-builder.md#setinputdata); the `InputMerger` combines all of these into a single merged `Data`. The default is [`OverwritingInputMerger`](overwriting-input-merger.md); [`ArrayCreatingInputMerger`](array-creating-input-merger.md) is also provided, and you can supply your own.

## Extension Functions

A `KClass`-based `setInputMerger` extension is also available — see [`package-functions.md`](package-functions.md).

## Inherited Members

Inherits the chainable setters from [`WorkRequest.Builder`](work-request-builder.md) (`addTag`, `setConstraints`, `setInputData`, `setBackoffCriteria`, `setInitialDelay`, `setExpedited`, `setId`, `keepResultsForAtLeast`, `setTraceTag`, `build`).
