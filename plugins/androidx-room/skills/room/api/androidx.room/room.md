# API Reference

> Last updated 2026-06-08

# Room

> Added in 2.0.0

```
object Room
```

Entry point for building and initializing a [`RoomDatabase`](room-database.md).

## Public Functions

### databaseBuilder

**Android**
```
inline fun <T : RoomDatabase> databaseBuilder(
    name: String,
    noinline factory: () -> T = { findAndInstantiateDatabaseImpl(T::class.java) }
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for a persistent database. Once a database is built, you should keep a reference to it and re-use it.

- `name` — The name of the database file.
- `factory` — An optional lambda calling `RoomDatabaseConstructor.initialize` corresponding to the database class of this builder. If not provided, reflection is used to find and instantiate the database implementation class.

**Native**
```
inline fun <T : RoomDatabase> databaseBuilder(
    name: String,
    noinline factory: () -> T = { findDatabaseConstructorAndInitDatabaseImpl(T::class) }
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for a persistent database.

- `name` — The name of the database file.
- `factory` — An optional lambda calling `RoomDatabaseConstructor.initialize` corresponding to the database class of this builder. If not provided, the associated `RoomDatabaseConstructor` is searched via the [`@ConstructedBy`](constructed-by.md) annotation and used to instantiate the database implementation class.

**Android**
> Added in 2.0.0
```
fun <T : RoomDatabase> databaseBuilder(
    context: Context,
    klass: Class<T>,
    name: String?
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for a persistent database.

- `context` — The context for the database. This is usually the `Application` context.
- `klass` — The abstract class which is annotated with [`@Database`](database.md) and extends [`RoomDatabase`](room-database.md).
- `name` — The name of the database file.

**Android**
```
inline fun <T : RoomDatabase> databaseBuilder(
    context: Context,
    name: String,
    noinline factory: () -> T = { findAndInstantiateDatabaseImpl(T::class.java) }
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for a persistent database.

- `context` — The context for the database. This is usually the `Application` context.
- `name` — The name of the database file.
- `factory` — An optional lambda calling `RoomDatabaseConstructor.initialize` corresponding to the database class of this builder. If not provided, reflection is used to find and instantiate the database implementation class.

### inMemoryDatabaseBuilder

**Android**
```
inline fun <T : RoomDatabase> inMemoryDatabaseBuilder(
    noinline factory: () -> T = { findAndInstantiateDatabaseImpl(T::class.java) }
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for an in-memory database. Information stored in an in-memory database disappears when the process is killed. Once a database is built, you should keep a reference to it and re-use it.

- `factory` — An optional lambda calling `RoomDatabaseConstructor.initialize` corresponding to the database class of this builder. If not provided, reflection is used to find and instantiate the database implementation class.

**Native**
```
inline fun <T : RoomDatabase> inMemoryDatabaseBuilder(
    noinline factory: () -> T = { findDatabaseConstructorAndInitDatabaseImpl(T::class) }
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for an in-memory database.

- `factory` — An optional lambda calling `RoomDatabaseConstructor.initialize` corresponding to the database class of this builder. If not provided, the associated `RoomDatabaseConstructor` is searched via the [`@ConstructedBy`](constructed-by.md) annotation and used to instantiate the database implementation class.

**Android**
```
inline fun <T : RoomDatabase> inMemoryDatabaseBuilder(
    context: Context,
    noinline factory: () -> T = { findAndInstantiateDatabaseImpl(T::class.java) }
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for an in-memory database.

- `context` — The context for the database. This is usually the `Application` context.
- `factory` — An optional lambda calling `RoomDatabaseConstructor.initialize` corresponding to the database class of this builder. If not provided, reflection is used to find and instantiate the database implementation class.

**Android**
> Added in 2.0.0
```
fun <T : RoomDatabase> inMemoryDatabaseBuilder(
    context: Context,
    klass: Class<T>
): RoomDatabase.Builder<T>
```

Creates a `RoomDatabase.Builder` for an in-memory database.

- `context` — The context for the database. This is usually the `Application` context.
- `klass` — The abstract class which is annotated with [`@Database`](database.md) and extends [`RoomDatabase`](room-database.md).

## Public Properties

### MASTER_TABLE_NAME

> Added in 2.0.0

```
val MASTER_TABLE_NAME: String
```

The master table name where Room keeps its metadata information.
