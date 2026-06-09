# Debug

Several tools and processes can help you debug a Room database.

## Use the Database Inspector

**Requires Android Studio 4.1+**

Use the Database Inspector to inspect, query, and modify an app's databases while the app is running.

Features:
- Use gutter actions to quickly run queries from [DAO classes](../api/androidx.room/dao.md).
- Immediately see live updates in the Database Inspector when the running app makes changes to the data.

## Dump Data from the Command Line

The Android SDK includes a `sqlite3` database tool for examining an app's databases. Use the `.dump` command to print the contents of a table, and `.schema` to print the `SQL CREATE` statement for a table.

Execute SQLite commands from the command line:
```bash
adb -s emulator-5554 shell
sqlite3 /data/data/app-package/databases/rssitems.db
```
