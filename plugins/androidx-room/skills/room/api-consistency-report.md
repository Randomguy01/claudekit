# Room API Reference — Consistency Report

> Generated 2026-06-06
> Scope: `plugins/androidx-room/skills/room/api/*.md`

This report reviews the 25 API reference files for internal consistency,
derives a set of de-facto documentation standards from the patterns the
files already follow, and scores each file against those standards.

## Summary

- **25** files total: **14** have content, **11** are empty (0 bytes).
- The richest, most complete templates are `database-view.md`, `delete.md`,
  `insert.md`, `update.md`, and `upsert.md` — they conform to every derived
  standard.
- The most common deviations are: **missing "See also" table** (6 files),
  **missing per-constructor `> Added in` version** (5 files), and
  **non-backticked cross-reference links** (3 files).
- `dao.md` is the only file with a non-uniform "Last updated" value
  (`2026-06-04 UTC` vs. `2026-06-05` everywhere else).
- `entity.md` contains malformed markdown links.
- `on-conflict-strategy.md` legitimately differs because it documents an
  `@IntDef` constant set rather than a parameterized annotation.

## Empty files (no content)

These 11 files are 0 bytes. Several are linked as cross-reference targets
from the populated files (e.g. `column-info.md`, `embedded.md`, `index.md`,
`relation.md`, `room-warnings.md`), so those links currently resolve to
empty documents:

`auto-value.md`, `column-info.md`, `copy-annotations.md`, `embedded.md`,
`fts-options.md`, `fts3.md`, `fts4.md`, `index.md`, `relation.md`,
`room-warnings.md`, `transaction.md`

## Derived standards

Each standard below is inferred from the convention the majority of
populated files already follow.

| ID  | Standard |
|-----|----------|
| S1  | File opens with a `# API Reference` H1 |
| S2  | A `> Last updated` metadata blockquote follows the H1 |
| S3  | The "Last updated" value is uniform (`2026-06-05`, no timezone suffix) |
| S4  | The API name appears as an H1 followed by a `> Added in X.Y.Z` blockquote |
| S5  | The signature code block declares `@Target(allowedTargets = ...)` |
| S6  | The signature code block declares `@Retention(value = AnnotationRetention.BINARY)` |
| S7  | A `## Public Constructors` section is present |
| S8  | Each constructor carries its own `> Added in X.Y.Z` version line |
| S9  | Annotation parameters are documented under a `## Public Properties` section |
| S10 | A "See also" cross-reference table is present |
| S11 | Cross-reference link text is wrapped in backticks, e.g. `` [`Dao`](dao.md) `` |
| S12 | All markdown links are well-formed |

## Conformity matrix

Legend: ✓ conforms · ✗ deviates · — not applicable

| File | S1 | S2 | S3 | S4 | S5 | S6 | S7 | S8 | S9 | S10 | S11 | S12 |
|------|----|----|----|----|----|----|----|----|----|-----|-----|-----|
| database-view.md          | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| delete.md                 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| insert.md                 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| update.md                 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| upsert.md                 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| entity.md                 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ |
| database.md               | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✓ | ✓ | ✗ | ✓ |
| query.md                  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✓ | ✓ |
| primary-key.md            | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✓ | ✓ |
| map-column.md             | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✓ | ✓ |
| dao.md                    | ✓ | ✓ | ✗ | ✓ | ✓ | ✓ | ✓ | ✗ | — | ✓ | ✗ | ✓ |
| ignore.md                 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | — | ✗ | ✗ | ✓ |
| on-conflict-strategy.md   | ✓ | ✓ | ✓ | ✓ | ✗ | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ | ✓ |
| experimental-room-api.md  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | — | ✗ | — | ✓ |

## Deviation notes

- **dao.md — S3:** "Last updated" reads `2026-06-04 UTC`; every other file uses
  `2026-06-05` with no timezone suffix.
- **dao.md, database.md, ignore.md, on-conflict-strategy.md, experimental-room-api.md — S8:**
  the constructor block has no `> Added in` version line (the well-formed
  files all use `> Added in 2.8.4`).
- **dao.md, database.md, ignore.md — S11:** cross-reference links use plain text
  (`[Dao](dao.md)`) instead of backticked text (`` [`Dao`](dao.md) ``).
  `database.md` is internally inconsistent — backticked in the "See also"
  table but plain in the body.
- **query.md, primary-key.md, map-column.md, ignore.md, on-conflict-strategy.md,
  experimental-room-api.md — S10:** no "See also" table.
- **entity.md — S12:** two malformed links in the "See also" table —
  `` [`ColumnInfo`[]() `` and `` [`Index`[]() `` use `[` where `]` is expected.
- **on-conflict-strategy.md — S5/S9:** documents an `@IntDef` annotation, so it
  carries `@IntDef(...)` instead of `@Target`, and lists members under
  `## Constants` rather than `## Public Properties`. This is a justified
  structural difference rather than a defect, but it is a deviation from the
  single-template pattern.

## Other observations (not scored)

- **Typo:** `entity.md` — "naming convetion" (should be "convention").
- **Anchor mismatch:** `primary-key.md` links to `entity.md#primarykey`, but the
  corresponding `entity.md` property heading is `### primaryKey` while the field
  it documents is `primaryKeys` — heading/field/anchor are inconsistent.
- **Empty link targets:** many references point to `()` (e.g. `` [`RoomDatabase`]() ``)
  for types that are not documented in this directory. This is consistent across
  files but leaves dead links.

## Recommendations

1. Populate or remove the 11 empty files; at minimum stop linking to them until
   they have content.
2. Normalize `dao.md`'s "Last updated" value and add the missing constructor
   `> Added in` lines to the 5 files lacking them.
3. Standardize cross-reference links to backticked text and fix the malformed
   links in `entity.md`.
4. Add "See also" tables to the 6 files missing them.
5. Decide whether `@IntDef` types like `OnConflictStrategy` follow a documented
   variant template (Constants section) so the deviation is intentional rather
   than incidental.
