# Migrate from SQLite to Room

Migrate an app that uses the SQLite APIs directly to Room. If Room is your first SQLite implementation, see [Installing Room](install.md) instead.

## Migration Steps

Migrate a SQLite implementation to Room with the following steps. For a large database or complex queries, consider migrating gradually — see [Incremental Migration](#incremental-migration).

### Update Dependencies

Add the Room dependencies to the app's `build.gradle` file. See [Installing Room](install.md).

### Update Model Classes to Data Entities

Room uses [data entities](entity.md) to represent tables: each entity class is a table, and its fields are columns. Update existing model classes to Room entities:

1. Annotate the class with [`@Entity`](../api/androidx.room/entity.md). Optionally set the `tableName` property to give the table a name different from the class name.
2. Annotate the primary key field with [`@PrimaryKey`](../api/androidx.room/primary-key.md).
3. To give a column a name different from its field, annotate the field with [`@ColumnInfo`](../api/androidx.room/column-info.md) and set the `name` property.
4. To exclude a field from the table, annotate it with [`@Ignore`](../api/androidx.room/ignore.md).
5. If the class has more than one constructor, annotate all but the one Room should use with `@Ignore`.

```kotlin
@Entity(tableName = "users")
data class User(
  @PrimaryKey
  @ColumnInfo(name = "userid") val mId: String,
  @ColumnInfo(name = "username") val mUserName: String?,
  @ColumnInfo(name = "last_update") val mDate: Date?,
)
```

### Create DAOs

Room uses data access objects (DAOs) to define the methods that access the database. Replace your existing query methods with DAOs. See [DAO](dao.md).

### Create a Database Class

A Room database class manages the database instance. Extend `RoomDatabase` and reference all the entities and DAOs you defined.

> [!NOTE]
> Migrating to Room is a SQLite database version change, so increment the version number by one.

```kotlin
@Database(entities = [User::class], version = 2)
@TypeConverters(DateConverter::class)
abstract class UsersDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
}
```

The `User` entity stores a `Date`, which SQLite can't persist directly, so this database references a type converter. See [Complex Data](complex-data.md).

### Define a Migration Path

Because the database version number is changing, define a [`Migration`](../api/androidx.room.migration/migration.md) object so Room keeps the existing data. As long as the schema doesn't change, this can be an empty implementation:

```kotlin
val MIGRATION_1_2 = object : Migration(1, 2) {
  override fun migrate(database: SupportSQLiteDatabase) {
    // Empty implementation, because the schema isn't changing.
  }
}
```

For more on migration paths, see [Migrate](migrate.md).

### Update the Database Instantiation

After defining the database class and migration path, use `Room.databaseBuilder` to create the database instance with the migration applied:

```kotlin
val db = Room.databaseBuilder(
          applicationContext,
          UsersDatabase::class.java, "database-name"
        )
          .addMigrations(MIGRATION_1_2).build()
```

### Test Your Implementation

Test the new Room implementation:
- Test the database migration — see [Test Migrations](migrate.md#test-migrations).
- Test the DAO methods — see [Test](test.md).

## Incremental Migration

For a large, complex database, migrating all at once might not be feasible. Instead, implement the data entities and Room database first, then migrate the query methods into DAOs later. To do this, replace your custom [database helper class](sqlite.md#create-a-database-using-an-sql-helper) with the `SupportSQLiteOpenHelper` object from `RoomDatabase.getOpenHelper()`.
