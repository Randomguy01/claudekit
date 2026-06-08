# API Reference

> Last updated 2026-06-08

# FtsOptions

> Added in 2.1.0

```
object FtsOptions
```

Available option values that can be used with [`@Fts3`](fts3.md) and [`@Fts4`](fts4.md).

## Nested Types

| Type |
|------|
| `enum` [`FtsOptions.MatchInfo`](fts-options-match-info.md) — The match info version used to store text matching information. |
| `enum` [`FtsOptions.Order`](fts-options-order.md) — The preferred `rowid` order of an FTS table. |

## Constants

### TOKENIZER_ICU

> Added in 2.1.0

```
const val TOKENIZER_ICU: String
```

The name of a tokenizer implemented by the ICU library.

Not available in certain Android builds (e.g. vendor).

### TOKENIZER_PORTER

> Added in 2.1.0

```
const val TOKENIZER_PORTER: String
```

The name of the tokenizer based on the Porter Stemming Algorithm.

### TOKENIZER_SIMPLE

> Added in 2.1.0

```
const val TOKENIZER_SIMPLE: String
```

The name of the default tokenizer used on FTS tables.

### TOKENIZER_UNICODE61

> Added in 2.1.0

```
const val TOKENIZER_UNICODE61: String
```

The name of the tokenizer that extends the [`TOKENIZER_SIMPLE`](#tokenizer_simple) tokenizer according to rules in Unicode Version 6.1.
