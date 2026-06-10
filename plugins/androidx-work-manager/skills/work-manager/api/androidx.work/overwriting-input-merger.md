# API Reference

> Last updated 2026-06-10

# OverwritingInputMerger

> Added in 1.0.0

```
class OverwritingInputMerger : InputMerger
```

An [`InputMerger`](input-merger.md) that attempts to add all keys from all inputs to the output. On a conflict, this class overwrites the previously-set key. Because there is no defined order for inputs, this implementation is best suited for cases where conflicts will not happen, or where overwriting is a valid strategy.

## Public Constructors

### OverwritingInputMerger

> Added in 1.0.0
```
OverwritingInputMerger()
```

## Public Functions

### merge

```
open fun merge(inputs: List<Data>): Data
```

Merges a list of [`Data`](data.md) and outputs a single merged `Data` object.
