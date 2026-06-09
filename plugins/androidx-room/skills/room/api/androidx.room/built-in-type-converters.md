# API Reference

> Last updated 2026-06-08

# BuiltInTypeConverters

> Added in 2.4.0

```
@Target(allowedTargets = [])
@Retention(value = AnnotationRetention.BINARY)
annotation BuiltInTypeConverters
```

Flags to turn on/off extra type converters provided by Room.

For certain commonly used types (enums, UUID), Room provides automatic type converters. By default, these type converters are enabled but have lower priority than user-provided type converters.

You can set these flags in the [`@TypeConverters`](type-converters.md) annotation to turn them off / on. This is useful if you want stricter control over how these types are saved into the database.

## Nested Types

| Type |
|------|
| `enum` [`BuiltInTypeConverters.State`](built-in-type-converters-state.md) — Control flags for built in converters. |

## Public Constructors

### BuiltInTypeConverters

> Added in 2.8.4

```
BuiltInTypeConverters(
    enums: BuiltInTypeConverters.State = State.INHERITED,
    uuid: BuiltInTypeConverters.State = State.INHERITED,
    byteBuffer: BuiltInTypeConverters.State = State.INHERITED
)
```

## Public Properties

### byteBuffer

```
val byteBuffer: BuiltInTypeConverters.State
```

Controls whether Room can generate a `TypeConverter` for `java.nio.ByteBuffer` and use its `ByteBuffer` representation while saving it into the database.

By default, it is set to [`State.INHERITED`](built-in-type-converters-state.md#inherited) (on by default unless set to another value in a higher scope).

### enums

```
val enums: BuiltInTypeConverters.State
```

Controls whether Room can generate a `TypeConverter` for enum types and use their `name()` in the database.

By default, it is set to [`State.INHERITED`](built-in-type-converters-state.md#inherited) (on by default unless set to another value in a higher scope).

### uuid

```
val uuid: BuiltInTypeConverters.State
```

Controls whether Room can generate a `TypeConverter` for `java.util.UUID` and use its `byte[]` representation while saving it into the database.

By default, it is set to [`State.INHERITED`](built-in-type-converters-state.md#inherited) (on by default unless set to another value in a higher scope).
