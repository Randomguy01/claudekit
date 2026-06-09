# API Reference

> Last updated 2026-06-08

# RoomWarnings

> Added in 2.0.0

```
open class RoomWarnings
```

The list of warnings that are produced by Room.

You can use these values inside a `@SuppressWarnings` annotation to disable the warnings.

## Constants

### AMBIGUOUS_COLUMN_IN_RESULT

```
const val AMBIGUOUS_COLUMN_IN_RESULT: String
```

Reported when there is an ambiguous column on the result of a multimap query.

### CANNOT_CREATE_VERIFICATION_DATABASE

```
const val CANNOT_CREATE_VERIFICATION_DATABASE: String
```

Reported when Room cannot verify database queries during compilation. This usually happens when it cannot find the SQLite JDBC driver on the host machine. Room can function without query verification but its functionality will be limited.

### CURSOR_MISMATCH

> Added in 2.7.0 · Deprecated in 2.7.0
```
const val CURSOR_MISMATCH: String
```

**Deprecated — replaced by [`QUERY_MISMATCH`](#query_mismatch).**

The warning dispatched by Room when the return value of a [`@Query`](query.md) method does not exactly match the fields in the query result.

### DEFAULT_CONSTRUCTOR

```
const val DEFAULT_CONSTRUCTOR: String
```

Reported when a POJO has multiple constructors, one of which is a no-arg constructor. Room picks that one by default but prints this warning in case the constructor choice is important. You can always guide Room to use the right constructor using the [`@Ignore`](ignore.md) annotation.

### DOES_NOT_IMPLEMENT_EQUALS_HASHCODE

```
const val DOES_NOT_IMPLEMENT_EQUALS_HASHCODE: String
```

The warning dispatched by Room when the object in the provided method's multimap return type does not implement `equals()` and `hashCode()`.

### INDEX_FROM_EMBEDDED_ENTITY_IS_DROPPED

```
const val INDEX_FROM_EMBEDDED_ENTITY_IS_DROPPED: String
```

Reported when an [`@Entity`](entity.md) has an [`@Embedded`](embedded.md) field whose type is another `Entity` and that `Entity` has some indices defined. These indices will NOT be created in the containing `Entity`. If you want to preserve them, re-define them in the containing `Entity`.

### INDEX_FROM_EMBEDDED_FIELD_IS_DROPPED

```
const val INDEX_FROM_EMBEDDED_FIELD_IS_DROPPED: String
```

Reported when an [`@Entity`](entity.md) field that is annotated with [`@Embedded`](embedded.md) has a sub field which has a [`@ColumnInfo`](column-info.md) annotation with `index = true`. You can re-define the index in the containing `Entity`.

### INDEX_FROM_PARENT_FIELD_IS_DROPPED

```
const val INDEX_FROM_PARENT_FIELD_IS_DROPPED: String
```

Reported when an [`@Entity`](entity.md) inherits a field from its super class and the field has a [`@ColumnInfo`](column-info.md) annotation with `index = true`. These indices are dropped for the `Entity`; you would need to re-declare them, or set [`Entity.inheritSuperIndices`](entity.md#inheritsuperindices) to `true`.

### INDEX_FROM_PARENT_IS_DROPPED

```
const val INDEX_FROM_PARENT_IS_DROPPED: String
```

Reported when an [`@Entity`](entity.md)'s parent declares an [`@Index`](index.md). Room does not automatically inherit these indices to avoid hidden costs or unexpected constraints. If you want your child class to have the indices of the parent, re-declare them in the child class, or set [`Entity.inheritSuperIndices`](entity.md#inheritsuperindices) to `true`.

### MISMATCHED_GETTER

```
const val MISMATCHED_GETTER: String
```

Reported when an `@Entity` field's type does not exactly match the getter type. For instance, in the following class:

```kotlin
@Entity
class Foo {
  ...
  private val value: Boolean?
  fun getValue(): Boolean {
    return value ?: false
  }
}
```

Trying to insert this entity into the database will always set the `value` column to `false` when `Foo.value` is `null`, since Room uses the `getValue` method to read the value. So even though the database column is nullable, it will never be inserted as `null` if inserted as a `Foo` instance.

### MISMATCHED_SETTER

```
const val MISMATCHED_SETTER: String
```

Reported when an `@Entity` field's type does not exactly match the setter type. For instance, in the following class:

```kotlin
@Entity
class Foo {
  ...
  private var value: Boolean = false
  fun setValue(value: Boolean) {
    this.value = value
  }
}
```

If Room reads this entity from the database, it will always set `Foo.value` to `false` when the column value is `null`, since Room uses the `setValue` method to write the value.

### MISSING_INDEX_ON_FOREIGN_KEY_CHILD

```
const val MISSING_INDEX_ON_FOREIGN_KEY_CHILD: String
```

When there is a foreign key from Entity A to Entity B, it is a good idea to index the reference columns in B; otherwise, each modification on Entity A will trigger a full table scan on Entity B. If Room cannot find a proper index in the child entity (Entity B), it prints this warning.

### MISSING_INDEX_ON_JUNCTION

```
const val MISSING_INDEX_ON_JUNCTION: String
```

Reported when a junction entity whose column is used in a [`@Relation`](relation.md) field with a [`@Junction`](junction.md) does not contain an index. If the column is not covered by any index, a full table scan might be performed when resolving the relationship. It is recommended that columns on entities used as junctions contain indices.

### MISSING_JAVA_TMP_DIR

```
const val MISSING_JAVA_TMP_DIR: String
```

Reported when Room cannot verify database queries during compilation due to lack of tmp dir access in the JVM.

### MISSING_SCHEMA_LOCATION

```
const val MISSING_SCHEMA_LOCATION: String
```

Reported when a `room.schemaLocation` argument is not provided to the annotation processor. You can either set [`Database.exportSchema`](database.md#exportschema) to `false` or provide `room.schemaLocation` to the annotation processor. You are strongly advised to provide it and commit the schema files into your version control system.

### PRIMARY_KEY_FROM_EMBEDDED_IS_DROPPED

```
const val PRIMARY_KEY_FROM_EMBEDDED_IS_DROPPED: String
```

Reported when an [`@Entity`](entity.md) field that is annotated with [`@Embedded`](embedded.md) has a sub field which is annotated with [`@PrimaryKey`](primary-key.md), but the `PrimaryKey` is dropped while composing it into the parent object.

### QUERY_MISMATCH

```
const val QUERY_MISMATCH: String
```

The warning dispatched by Room when the return value of a [`@Query`](query.md) method does not exactly match the columns in the query result.

### RELATION_QUERY_WITHOUT_TRANSACTION

```
const val RELATION_QUERY_WITHOUT_TRANSACTION: String
```

Reported when a `@Query` method returns a POJO that has relations but the method is not annotated with [`@Transaction`](transaction.md). Relations are run as separate queries, and if the query is not run inside a transaction, it might return inconsistent results from the database.

### RELATION_TYPE_MISMATCH

```
const val RELATION_TYPE_MISMATCH: String
```

Reported when a [`@Relation`](relation.md)'s SQLite column type does not match the type in the parent. Room will still do the matching using `String` representations.

### UNNECESSARY_NULLABILITY_IN_DAO_RETURN_TYPE

```
const val UNNECESSARY_NULLABILITY_IN_DAO_RETURN_TYPE: String
```

Reported when a nullable `Collection`, `Array`, or `Optional` is returned from a DAO method. Room returns an empty `Collection`, `Array`, or `Optional` respectively if no results are returned by such a query, hence using a nullable return type is unnecessary in this case.

## Public Constructors

### RoomWarnings

> Added in 2.0.0 · Deprecated in 2.0.0
```
RoomWarnings()
```

**Deprecated — this type should not be instantiated as it contains only static constants.**
