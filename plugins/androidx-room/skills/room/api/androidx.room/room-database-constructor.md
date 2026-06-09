# API Reference

> Last updated 2026-06-08

# RoomDatabaseConstructor

> Added in 2.7.0

```
interface RoomDatabaseConstructor<T : RoomDatabase>
```

Defines a class that can instantiate the Room-generated implementation of an `abstract` [`@Database`](database.md) annotated [`RoomDatabase`](room-database.md) definition. The type parameter `T` is the `@Database` and [`@ConstructedBy`](constructed-by.md) annotated class linked to this constructor.

This interface is used in conjunction with [`@ConstructedBy`](constructed-by.md) to define an `expect` declaration of an `object` that implements it. The defined `object` can then optionally be used in Room's [`databaseBuilder`](room.md#databasebuilder) or [`inMemoryDatabaseBuilder`](room.md#inmemorydatabasebuilder) as the `factory`.

```kotlin
expect object MusicDatabaseConstructor : RoomDatabaseConstructor<MusicDatabase>
```

One can reference the object's `initialize` during database creation:

```kotlin
fun createDatabase(): MusicDatabase {
  return Room.inMemoryDatabaseBuilder<MusicDatabase>(
    factory = MusicDatabaseConstructor::initialize
  ).build()
}
```

For Room to correctly and automatically use `actual` implementations of this interface, they must be linked to their respective `@Database` definition via [`@ConstructedBy`](constructed-by.md).

|       See also       |
| -------------------- |
| [`@ConstructedBy`](constructed-by.md) |

## Public Functions

### initialize

> Added in 2.7.0
```
fun initialize(): T
```

Instantiates an implementation of `T`, returning a new instance.
