# API Reference

> Last updated 2026-06-05

# RenameColumn.Entries

> Added in 2.4.0

**Android**
```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation RenameColumn.Entries
```

Container annotation for the repeatable annotation [`RenameColumn`](rename-column.md).

## Public Constructors

### Entries

> Added in 2.8.4

```
Entries(vararg value: RenameColumn)
```

## Public Properties

### value

```
val value: Array<RenameColumn>
```
