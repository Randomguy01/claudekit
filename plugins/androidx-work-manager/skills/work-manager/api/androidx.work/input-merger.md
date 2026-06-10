# API Reference

> Last updated 2026-06-10

# InputMerger

> Added in 1.0.0

```
abstract class InputMerger
```

An abstract class that defines how to merge a list of inputs to a [`ListenableWorker`](listenable-worker.md).

Before workers run, they receive input [`Data`](data.md) from their parent workers, as well as anything specified directly via [`WorkRequest.Builder.setInputData`](work-request-builder.md#setinputdata). An `InputMerger` takes all of these objects and converts them to a single merged [`Data`](data.md) to be used as the worker input. WorkManager offers two concrete implementations: [`OverwritingInputMerger`](overwriting-input-merger.md) and [`ArrayCreatingInputMerger`](array-creating-input-merger.md).

> [!NOTE]
> The list of inputs to merge is in an unspecified order. Do not make assumptions about the order of inputs.

## Known Direct Subtypes

| Type | Description |
|------|-------------|
| [`ArrayCreatingInputMerger`](array-creating-input-merger.md) | Merges inputs, creating arrays when necessary. |
| [`OverwritingInputMerger`](overwriting-input-merger.md) | Adds all keys from all inputs to the output, overwriting on conflict. |

## Public Constructors

### InputMerger

> Added in 1.0.0
```
InputMerger()
```

## Public Functions

### merge

> Added in 1.0.0
```
abstract fun merge(inputs: List<Data>): Data
```

Merges a list of [`Data`](data.md) and outputs a single merged `Data` object.
