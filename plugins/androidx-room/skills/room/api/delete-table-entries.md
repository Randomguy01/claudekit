# API Reference

> Last updated 2026-06-05

# DeleteTable.Entries

> Added in 2.4.0

**Android**
```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation DeleteTable.Entries
```

Container annotation for the repeatable annotation [`DeleteTable`](delete-table.md).

## Public Constructors

### Entries

> Added in 2.8.4

```
Entries(vararg value: DeleteTable)
```

## Public Properties

### value

```
val value: Array<DeleteTable>
```
