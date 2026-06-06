# API Reference

> Last updated 2026-06-05

# DeleteColumn.Entries

> Added in 2.4.0

**Android**
```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation DeleteColumn.Entries
```

Container annotation for the repeatable annotation [`DeleteColumn`](delete-column.md).

## Public Constructors

### Entries

> Added in 2.8.0-rc02

```
Entries(vararg value: DeleteColumn)
```

## Public Properties

### value

```
val value: Array<DeleteColumn>
```
