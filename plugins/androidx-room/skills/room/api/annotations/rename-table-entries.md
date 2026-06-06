# API Reference

> Last updated 2026-06-05

# RenameTable.Entries

> Added in 2.4.0

**Android**
```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation RenameTable.Entries
```

Container annotation for the repeatable annotation [`RenameTable`](rename-table.md).

## Public Constructors

### Entries

> Added in 2.8.4

```
Entries(vararg value: RenameTable)
```

## Public Properties

### value

```
val value: Array<RenameTable>
```
