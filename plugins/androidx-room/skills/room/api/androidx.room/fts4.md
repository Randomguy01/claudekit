# API Reference

> Last updated 2026-06-08

# Fts4

> Added in 2.1.0

```
@Target(allowedTargets = [AnnotationTarget.CLASS])
@Retention(value = AnnotationRetention.BINARY)
annotation Fts4
```

Marks an [`@Entity`](entity.md) annotated class as an FTS4 entity. This class will have a mapping SQLite FTS4 table in the database.

FTS3 and FTS4 are SQLite virtual table modules that allow full-text searches to be performed on a set of documents.

An FTS entity table always has a column named `rowid` that is the equivalent of an `INTEGER PRIMARY KEY` index. Therefore, an FTS entity can only have a single field annotated with [`@PrimaryKey`](primary-key.md); it must be named `rowid` and must be of `INTEGER` affinity. The field can optionally be omitted from the class but can still be used in queries.

All fields in an FTS entity are of `TEXT` affinity, except for the `rowid` and `languageid` fields.

```kotlin
@Entity
@Fts4
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

### Fts4

> Added in 2.8.4

```
Fts4(
    tokenizer: String = TOKENIZER_SIMPLE,
    tokenizerArgs: Array<String> = [],
    contentEntity: KClass<*> = Any::class,
    languageId: String = "",
    matchInfo: FtsOptions.MatchInfo = FtsOptions.MatchInfo.FTS4,
    notIndexed: Array<String> = [],
    prefix: IntArray = [],
    order: FtsOptions.Order = FtsOptions.Order.ASC
)
```

## Public Properties

### contentEntity

```
val contentEntity: KClass<*>
```

The external content entity whose mapping table will be used as content for the FTS table.

Declaring this value makes the mapping FTS table of this entity operate in "external content" mode. In such mode the FTS table does not store its own content but instead uses the data in the entity mapped table defined in this value. This option allows FTS4 to forego storing the text being indexed, which can be used to achieve significant space savings.

In external mode, the content table and the FTS table need to be synced. Room creates the necessary triggers to keep the tables in sync. Therefore, all write operations should be performed against the content entity table and not the FTS table.

The content sync triggers created by Room are removed before migrations are executed and re-created once migrations are complete. This prevents the triggers from interfering with migrations, but means that if data needs to be migrated then write operations might need to be done in both the FTS and content tables.

See the External Content FTS4 Tables documentation for details.

### languageId

```
val languageId: String
```

The column name to be used as `languageid`.

Allows the FTS4 extension to use the defined column name to specify the language stored in each row. When this is defined, a field of type `INTEGER` with the same name must exist in the class.

FTS queries are affected by defining this option.

### matchInfo

```
val matchInfo: FtsOptions.MatchInfo
```

The FTS version used to store text matching information.

The default value is [`MatchInfo.FTS4`](fts-options-match-info.md#fts4). Disk space consumption can be reduced by setting this option to [`FTS3`](fts-options-match-info.md#fts3).

### notIndexed

```
val notIndexed: Array<String>
```

The list of column names on the FTS table that won't be indexed.

### order

```
val order: FtsOptions.Order
```

The preferred `rowid` order of the FTS table.

The default value is [`Order.ASC`](fts-options-order.md#asc). If many queries are run against the FTS table using `ORDER BY rowid DESC`, it may improve performance to set this option to [`Order.DESC`](fts-options-order.md#desc), enabling the FTS module to store its data in a way that optimizes returning results in descending order by `rowid`.

### prefix

```
val prefix: IntArray
```

The list of prefix sizes to index.

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
