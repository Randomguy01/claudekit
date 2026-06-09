# SQLite

Saving data to a database is ideal for repeating or structured data, such as contact information. The APIs for using a database on Android are in the `android.database.sqlite` package.

> [!CAUTION]
> These APIs are powerful but low-level and require significant time and effort to use:
> - There is no compile-time verification of raw SQL queries. As your data graph changes, you must update the affected SQL queries manually — a time-consuming, error-prone process.
> - You need lots of boilerplate code to convert between SQL queries and data objects.

> [!TIP]
> Prefer the Room persistence library over these raw APIs — it adds compile-time query verification and removes boilerplate. See [Installing Room](install.md).

## Define a Schema and Contract

One of the main principles of SQL databases is the schema: a formal declaration of how the database is organized. The schema is reflected in the SQL statements that create the database. Create a *contract* class to specify the layout of your schema in a systematic, self-documenting way.

A contract class is a container for constants that define names for URIs, tables, and columns. It lets you use the same constants across every class in the package, so you can change a column name in one place and have it propagate throughout your code.

Put definitions that are global to the whole database at the root level of the class, then create an inner class for each table that enumerates its columns.

> [!NOTE]
> By implementing the `BaseColumns` interface, your inner class can inherit a primary key field called `_ID` that some Android classes such as `CursorAdapter` expect. It's not required, but it helps your database work harmoniously with the Android framework.

For example, the following contract defines the table name and column names for a single table representing an RSS feed:

```kotlin
object FeedReaderContract {
    // Table contents are grouped together in an anonymous object.
    object FeedEntry : BaseColumns {
        const val TABLE_NAME = "entry"
        const val COLUMN_NAME_TITLE = "title"
        const val COLUMN_NAME_SUBTITLE = "subtitle"
    }
}
```

## Create a Database Using an SQL Helper

Implement methods that create and maintain the database and tables. Here are typical statements that create and delete a table:

```kotlin
private const val SQL_CREATE_ENTRIES =
        "CREATE TABLE ${FeedEntry.TABLE_NAME} (" +
                "${BaseColumns._ID} INTEGER PRIMARY KEY," +
                "${FeedEntry.COLUMN_NAME_TITLE} TEXT," +
                "${FeedEntry.COLUMN_NAME_SUBTITLE} TEXT)"

private const val SQL_DELETE_ENTRIES = "DROP TABLE IF EXISTS ${FeedEntry.TABLE_NAME}"
```

Like files saved on the device's internal storage, Android stores the database in the app's private folder. The data is secure because, by default, this area is not accessible to other apps or the user.

The `SQLiteOpenHelper` class manages your database. When you use it to obtain references to the database, the system performs the potentially long-running operations of creating and updating the database only when needed and *not during app startup*. To trigger this, call `getWritableDatabase()` or `getReadableDatabase()`.

> [!NOTE]
> Call `getWritableDatabase()` or `getReadableDatabase()` in a background thread, because they can be long-running.

To use `SQLiteOpenHelper`, create a subclass that overrides the `onCreate()` and `onUpgrade()` callback methods. Optionally implement `onDowngrade()` or `onOpen()`.

For example, here's an implementation of `SQLiteOpenHelper` that uses the commands shown above:

```kotlin
class FeedReaderDbHelper(context: Context) : SQLiteOpenHelper(context, DATABASE_NAME, null, DATABASE_VERSION) {
    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(SQL_CREATE_ENTRIES)
    }
    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        // This database is only a cache for online data, so its upgrade policy is
        // to simply discard the data and start over.
        db.execSQL(SQL_DELETE_ENTRIES)
        onCreate(db)
    }
    override fun onDowngrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        onUpgrade(db, oldVersion, newVersion)
    }
    companion object {
        // If you change the database schema, you must increment the database version.
        const val DATABASE_VERSION = 1
        const val DATABASE_NAME = "FeedReader.db"
    }
}
```

To access the database, instantiate your subclass of `SQLiteOpenHelper`:

```kotlin
val dbHelper = FeedReaderDbHelper(context)
```

## Put Information into a Database

Insert data by passing a `ContentValues` object to the `insert()` method:

```kotlin
// Gets the data repository in write mode
val db = dbHelper.writableDatabase

// Create a new map of values, where column names are the keys
val values = ContentValues().apply {
    put(FeedEntry.COLUMN_NAME_TITLE, title)
    put(FeedEntry.COLUMN_NAME_SUBTITLE, subtitle)
}

// Insert the new row, returning the primary key value of the new row
val newRowId = db?.insert(FeedEntry.TABLE_NAME, null, values)
```

The first argument for `insert()` is the table name.

The second argument tells the framework what to do when the `ContentValues` is empty (you didn't `put` any values). If you specify a column name, the framework inserts a row and sets that column to null. If you specify `null`, as in this sample, the framework does not insert a row when there are no values.

The `insert()` method returns the ID for the newly created row, or `-1` if there was an error — which can happen if you have a conflict with pre-existing data.

## Read Information from a Database

To read from a database, use the `query()` method, passing your selection criteria and desired columns. The column list defines the data to fetch (the *projection*). The results are returned in a `Cursor` object:

```kotlin
val db = dbHelper.readableDatabase

// Define a projection that specifies which columns from the database
// you will actually use after this query.
val projection = arrayOf(BaseColumns._ID, FeedEntry.COLUMN_NAME_TITLE, FeedEntry.COLUMN_NAME_SUBTITLE)

// Filter results WHERE "title" = 'My Title'
val selection = "${FeedEntry.COLUMN_NAME_TITLE} = ?"
val selectionArgs = arrayOf("My Title")

// How you want the results sorted in the resulting Cursor
val sortOrder = "${FeedEntry.COLUMN_NAME_SUBTITLE} DESC"

val cursor = db.query(
        FeedEntry.TABLE_NAME,   // The table to query
        projection,             // The array of columns to return (pass null to get all)
        selection,              // The columns for the WHERE clause
        selectionArgs,          // The values for the WHERE clause
        null,                   // don't group the rows
        null,                   // don't filter by row groups
        sortOrder               // The sort order
)
```

The `selection` and `selectionArgs` arguments combine to form a WHERE clause. Because the arguments are provided separately from the query, they are escaped before being combined, making the selection immune to SQL injection.

To read a row, first call a `Cursor` move method — the cursor starts at position -1, so call `moveToNext()` to reach the first entry. Read each column with a get method such as `getString()` or `getLong()`, passing the column index from `getColumnIndexOrThrow()`. Call `close()` on the cursor when finished to release its resources.

For example, the following gets all the item IDs in a cursor and adds them to a list:

```kotlin
val itemIds = mutableListOf<Long>()
with(cursor) {
    while (moveToNext()) {
        val itemId = getLong(getColumnIndexOrThrow(BaseColumns._ID))
        itemIds.add(itemId)
    }
}
cursor.close()
```

## Delete Information from a Database

To delete rows, provide selection criteria that identify the rows to the `delete()` method. The mechanism works like the selection arguments to `query()`: a selection clause defines the columns to test, and the arguments are values bound into the clause. This makes deletion immune to SQL injection.

```kotlin
// Define 'where' part of query.
val selection = "${FeedEntry.COLUMN_NAME_TITLE} LIKE ?"
// Specify arguments in placeholder order.
val selectionArgs = arrayOf("MyTitle")
// Issue SQL statement.
val deletedRows = db.delete(FeedEntry.TABLE_NAME, selection, selectionArgs)
```

The return value of `delete()` is the number of rows deleted.

## Update a Database

To modify a subset of your database values, use the `update()` method, which combines the `ContentValues` syntax of `insert()` with the `WHERE` syntax of `delete()`:

```kotlin
val db = dbHelper.writableDatabase

// New value for one column
val title = "MyNewTitle"
val values = ContentValues().apply {
    put(FeedEntry.COLUMN_NAME_TITLE, title)
}

// Which row to update, based on the title
val selection = "${FeedEntry.COLUMN_NAME_TITLE} LIKE ?"
val selectionArgs = arrayOf("MyOldTitle")
val count = db.update(
        FeedEntry.TABLE_NAME,
        values,
        selection,
        selectionArgs)
```

The return value of `update()` is the number of rows affected.

## Persist the Database Connection

Because `getWritableDatabase()` and `getReadableDatabase()` are expensive to call when the database is closed, leave the connection open for as long as you need to access it. Typically, close the database in the calling activity's `onDestroy()`:

```kotlin
override fun onDestroy() {
    dbHelper.close()
    super.onDestroy()
}
```

## Debug Your Database

The Android SDK includes a `sqlite3` shell tool for browsing table contents and running SQL commands on SQLite databases. See [Debugging](debug.md).
