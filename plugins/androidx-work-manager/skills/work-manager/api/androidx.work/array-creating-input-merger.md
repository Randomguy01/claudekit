# API Reference

> Last updated 2026-06-10

# ArrayCreatingInputMerger

> Added in 1.0.0

```
class ArrayCreatingInputMerger : InputMerger
```

An [`InputMerger`](input-merger.md) that attempts to merge the inputs, creating arrays when necessary. For each input, it looks at each key:

- If this is the first time the key is encountered: put the value in the output, turning a primitive into a size-1 array.
- If the key has been encountered before and the value type matches: concatenate arrays, or turn two primitives into a size-2 array.
- If one is an array and the other is a primitive of that type: concatenate into a longer array.
- Otherwise: throws `IllegalArgumentException` because the types don't match.

A `null` value is considered to have type `String`, the only nullable type allowed in [`Data`](data.md).

## Public Constructors

### ArrayCreatingInputMerger

> Added in 1.0.0
```
ArrayCreatingInputMerger()
```

## Public Functions

### merge

```
open fun merge(inputs: List<Data>): Data
```

Merges a list of [`Data`](data.md) and outputs a single merged `Data` object.
