# API Reference

> Last updated 2026-06-08

# ForeignKey.Action

> Added in 2.0.0

```
@IntDef(value = [1, 2, 3, 4, 5])
@Retention(value = AnnotationRetention.BINARY)
annotation ForeignKey.Action
```

Constants definition for values that can be used in [`ForeignKey.onDelete`](foreign-key.md#ondelete) and [`ForeignKey.onUpdate`](foreign-key.md#onupdate).

The allowed values are [`NO_ACTION`](foreign-key.md#no_action), [`RESTRICT`](foreign-key.md#restrict), [`SET_NULL`](foreign-key.md#set_null), [`SET_DEFAULT`](foreign-key.md#set_default), and [`CASCADE`](foreign-key.md#cascade).

## Public Constructors

### Action

```
Action()
```
