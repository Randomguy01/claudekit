# API Reference

> Last updated 2026-06-08

# Fts3

> Added in 2.1.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation Fts3
```

Marks an [`@Entity`](entity.md) annotated class as an FTS3 entity. This class will have a mapping SQLite FTS3 table in the database.

FTS3 and FTS4 are SQLite virtual table modules that allow full-text searches to be performed on a set of documents.

An FTS entity table always has a column named `rowid` that is the equivalent of an `INTEGER PRIMARY KEY` index. Therefore, an FTS entity can only have a single field annotated with [`@PrimaryKey`](primary-key.md); it must be named `rowid` and must be of `INTEGER` affinity. The field can optionally be omitted from the class but can still be used in queries.

All fields in an FTS entity are of `TEXT` affinity, except for the `rowid` field.

```kotlin
@Entity
@Fts3
data class Mail(
  @PrimaryKey
  @ColumnInfo(name = "rowid")
  val rowId: Int,
  val subject: String,
  val body: String
)
```

|        See also        |
| ---------------------- |
| [`Entity`](entity.md) |
| [`Dao`](dao.md) |
| [`Database`](database.md) |
| [`PrimaryKey`](primary-key.md) |
| [`ColumnInfo`](column-info.md) |

## Public Constructors

### Fts3

> Added in 2.8.4

```
Fts3(tokenizer: String = TOKENIZER_SIMPLE, tokenizerArgs: Array<String> = [])
```

## Public Properties

### tokenizer

```
val tokenizer: String
```

The tokenizer to be used in the FTS table.

The default value is [`FtsOptions.TOKENIZER_SIMPLE`](fts-options.md#tokenizer_simple). Tokenizer arguments can be defined with `tokenizerArgs`.

If a custom tokenizer is used, the tokenizer and its arguments are not verified at compile time.

Built-in available tokenizers are [`FtsOptions.TOKENIZER_SIMPLE`](fts-options.md#tokenizer_simple), [`FtsOptions.TOKENIZER_PORTER`](fts-options.md#tokenizer_porter), and [`FtsOptions.TOKENIZER_UNICODE61`](fts-options.md#tokenizer_unicode61).

### tokenizerArgs

```
val tokenizerArgs: Array<String>
```

Optional arguments to configure the defined tokenizer.

Tokenizer arguments consist of an argument name, followed by an `=` character, followed by the option value. For example, `separators=.` defines the dot character as an additional separator when using the `FtsOptions.TOKENIZER_UNICODE61` tokenizer.

The available arguments depend on the tokenizer defined.
