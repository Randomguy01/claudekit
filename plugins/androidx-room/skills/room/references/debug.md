# Debug

It's important to verify the stability of the app's database and the users' data when creating databases using the Room persistence library. This page discusses how to perform debugging steps.

There are several tools and processes that you can use to debug a database.

## Use the Database Inspector

**Requires Android Studio 4.1+**

The Database Inspector allows you to inspect, query, and modify an app's databases while an app is running.

Features:
- Use gutter actions to quickly run queries from [DAO classes](../api/dao.md).
- Immediately see live updates in the Database Inspector when the running app makes changes to the data.

## Dump Data from the Command Line

The Android SDK includes a `sqlite3` database tool for examining an app's databases. Use the `.dump` command to print the contents of a table, and `.schema` to print the `SQL CREATE` statement for a table.

Execute SQLite commands from the command line:
```bash
adb -s emulator-5554 shell
sqlite3 /data/data/app-package/databases/rssitems.db
```
