# API Reference

> Last updated 2026-06-10

# DataStore.Builder

> Added in 1.3.0-alpha09

```
class DataStore.Builder<T : Any?>
```

Builder for [`DataStore`](data-store.md).

## Public Constructors

### Builder

```
<T : Any?> Builder(storage: Storage<T>, context: CoroutineContext)
```

Constructs a builder backed by the given [`Storage`](storage.md) and coroutine `context`.

## Public Functions

### addMigrations

```
fun addMigrations(migrations: List<DataMigration<T>>): DataStore.Builder<T>
```

Adds [`DataMigration`](data-migration.md)s to the DataStore. Migrations run in the order they are added, before any data is returned to the user.

- `migrations` — the list of migrations.

Returns this builder.

### setCorruptionHandler

> Added in 1.3.0-alpha09

```
fun setCorruptionHandler(handler: CorruptionHandler<T>): DataStore.Builder<T>
```

Sets the [`CorruptionHandler`](corruption-handler.md), invoked if the [`Storage`](storage.md) layer throws a [`CorruptionException`](corruption-exception.md). Defaults to [`ReThrowCorruptionHandler`](../androidx.datastore.core.handlers/re-throw-corruption-handler.md).

- `handler` — the corruption handler.

Returns this builder.

### setTracer

> Added in 1.3.0-alpha09

**Android**

```
fun setTracer(tracer: Tracer): DataStore.Builder<T>
```

Sets the `androidx.tracing.Tracer` for Android.

- `tracer` — the `Tracer` to use.

Returns this builder.

### build

> Added in 1.3.0-alpha09

```
fun build(): DataStore<T>
```

Validates the configuration and builds a new [`DataStore`](data-store.md) instance.
