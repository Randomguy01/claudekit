# API Reference

> Last updated 2026-06-10

# InputMergerFactory

> Added in 2.3.0

```
abstract class InputMergerFactory
```

A factory object that creates [`InputMerger`](input-merger.md) instances. The factory is invoked every time a work runs. Override the default implementation by manually initializing [`WorkManager`](work-manager.md) (see [`WorkManager.initialize`](work-manager.md#initialize)) and specifying a new factory in [`Configuration.Builder.setInputMergerFactory`](configuration-builder.md#setinputmergerfactory).

## Public Constructors

### InputMergerFactory

> Added in 2.3.0
```
InputMergerFactory()
```

## Public Functions

### createInputMerger

> Added in 2.3.0
```
abstract fun createInputMerger(className: String): InputMerger?
```

Override this method to create an instance of an [`InputMerger`](input-merger.md) given its fully qualified class name. If the factory is unable to create an instance, return `null` so WorkManager can delegate to the default factory. Throwing an exception here will crash the application.
