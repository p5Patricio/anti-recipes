# Backup format

Settings > Backup exports the whole local database as one JSON file and can
replace it from such a file. This document describes the file.

> A backup is plain, unencrypted text. It contains personal data, including
> body weight when set, targets, recipes, meals and hydration. Never commit
> one to a public repository.

## Envelope

```json
{
  "format": "anti-recipes-backup",
  "version": 1,
  "schemaVersion": 2,
  "exportedAt": "2026-10-06T15:30:12.481Z",
  "data": {
    "user_profiles": [
      {
        "id": 1,
        "body_weight_kg": null,
        "protein_g_per_day": 160.0,
        "fat_g_per_day": 70.0,
        "meals_per_day": 3,
        "protein_per_meal_min": 50.0,
        "protein_per_meal_max": 55.0
      }
    ],
    "week_schedule_entries": [
      { "weekday": 1, "day_type": "training" },
      { "weekday": 7, "day_type": "rest" }
    ],
    "recipes": [
      {
        "id": 1,
        "name": "Roast chicken",
        "kind": "proteinBase",
        "expected_yield_factor": 0.72,
        "notes": null,
        "created_at": "2026-10-01T09:00:00.000Z"
      }
    ],
    "meal_logs": [
      {
        "id": 1,
        "date": "2026-10-05T03:00:00.000Z",
        "slot": 1,
        "day_type": "training"
      }
    ]
  }
}
```

(Abbreviated: a real file has every table listed below.)

| Field | Meaning |
|-------|---------|
| `format` | Always `anti-recipes-backup`. Anything else is rejected. |
| `version` | Version of this envelope layout. Currently `1`. |
| `schemaVersion` | Database schema version the data was exported from. |
| `exportedAt` | UTC timestamp of the export. |
| `data` | One array of rows per table. |

## Rows

- Keys are the SQL column names (`snake_case`), so renaming a Dart field does
  not change the format.
- Numbers are JSON numbers; booleans are `true` / `false`.
- Enums are stored by name: `day_type` is `training` or `rest`; `kind` is one
  of the `RecipeKind` names (`proteinBase`, `carbBase`, ...).
- Timestamps are UTC ISO 8601 strings with a trailing `Z`. Dates that mean a
  calendar day (`meal_logs.date`, `hydration_logs.date`, `day_logs.date`) are
  the local midnight of that day, stored as the matching UTC instant.
  Restoring on a device in a different time zone therefore keeps the same
  instants, which may fall on a neighboring calendar day there.
- `null` is allowed only where the column is nullable. Primary and foreign
  keys are exported as-is, so relations survive the round trip.
- Rows appear in table (`rowid`) order.

## Tables

Listed in dependency order, which is also the insert order of an import
(deletes run in reverse). The list is defined in
`lib/features/backup/data/backup_schema.dart` and a test fails if a table of
the database is missing from it.

`user_profiles`, `day_type_target_rows`, `week_schedule_entries`,
`ingredients`, `tools`, `recipes`, `recipe_ingredients`, `recipe_steps`,
`recipe_tools`, `batch_sessions`, `batch_items`, `meal_logs`,
`meal_components`, `hydration_logs`, `day_logs` (since schema 2).

## Import rules

Import replaces everything: all current rows are deleted and the backup's
rows are inserted, in one transaction with foreign keys enforced. If anything
fails, the transaction is rolled back and the database is left exactly as it
was. The app asks for confirmation, showing the row counts of the file, before
it erases anything.

A file is rejected with a readable message when:

- it is not valid JSON, or `format` is not `anti-recipes-backup`;
- `version` is newer than the app understands, or `schemaVersion` is newer
  than the app's database;
- a required table is missing, an unknown table or column appears, or a value
  has the wrong type, an unknown enum name or an unparsable date;
- a row breaks a database rule (foreign key, unique key, check constraint).

## Versioning policy

- `version` changes only when the envelope itself changes incompatibly. The
  app imports every version up to the one it knows.
- `schemaVersion` follows the database. Adding a table or a column with a
  default bumps it; the app still imports older backups:
  - a table introduced after the backup's `schemaVersion` may be absent and
    loads as empty (for example `day_logs` in a schema 1 backup);
  - a column added later with a default may be absent from rows and gets its
    default.
- A backup from a newer app than the one importing it is refused, with a
  message asking to update the app.
- Removing or retyping a column is a breaking change: it requires a
  `version` bump and an upgrade step in the importer.
