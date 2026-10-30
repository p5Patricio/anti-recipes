# Architecture

## Stack

| Concern | Choice |
|---------|--------|
| Framework | Flutter 3.47 (Dart 3.13), Android only (`dev.antirecipes.anti_recipes`) |
| State management | Riverpod 3 (`flutter_riverpod`) |
| Storage | SQLite through drift (`drift`, `drift_flutter`), schema version 2 |
| File access | `file_picker` 13 (Storage Access Framework, no storage permission) |
| Backend / auth | None |
| Tests | `flutter_test`, in-memory drift databases (`sqlite3` as dev dependency) |

Dependencies are deliberately few. Add a package only when the standard library and the current stack cannot do the job.

## Layers and the dependency rule

Each feature is a vertical slice with three layers:

```
presentation  ->  domain  <-  data
(widgets,         (pure Dart,   (drift DAOs,
 providers)        no Flutter,   mapping rows
                   no drift)     to domain)
```

- **domain** imports nothing from Flutter, drift or Riverpod. This is where every nutrition rule lives.
- **data** adapts the database to the domain (DAOs and plain Dart view classes).
- **presentation** holds Riverpod providers and widgets. Screens follow a container/presentational split: a stateful container owns form state and validation, small stateless widgets render sections.

## Project structure

```
lib/
  main.dart, app.dart, app_shell.dart      # entry, MaterialApp, 5-tab shell
  core/
    database/       # drift tables, AppDatabase, migrations, providers, date helpers
    nutrition/      # Nutrients, Range (shared value objects, pure Dart)
    formatting/     # date and gram formatting
    theme/          # AppColors, AppTheme.light()
    widgets/        # NumberField and number parsing, ComingSoonView
  features/
    nutrition_targets/   # day types, plan, schedule, NutritionEngine, targets screen
    recipes/             # recipes, ingredient library, yield and macro math
    inventory/           # batch logging, pantry stock, batch item detail
    meal_log/            # Today dashboard, meal composer, day summary
    batch_planner/       # reverse planner, shopping list, plan screen
    backup/              # JSON export and import
    settings/            # settings screen (links to targets and backup)
    shopping/            # empty placeholder folders (see current-status.md)
test/                    # mirrors lib/; helpers/ holds shared fixtures
docs/                    # this documentation
odd/tasks/               # task logbook used during the build
```

## Navigation

`AppShell` is a `NavigationBar` over an `IndexedStack` with five destinations: **Today**, **Recipes**, **Pantry**, **Plan**, **Settings**. All tabs stay mounted, which is why floating action buttons carry distinct `heroTag`s.

## Data model

Fifteen drift tables in `lib/core/database/tables.dart`. Foreign keys are enabled in `beforeOpen`.

| Table | Purpose |
|-------|---------|
| `user_profiles` | Optional body weight, protein and fat per day, meals per day, protein per meal range |
| `day_type_target_rows` | Per day type (`training`, `rest`): kcal, carbs, fiber, water, fruit, vegetable ranges |
| `week_schedule_entries` | Weekday 1 to 7 mapped to a day type |
| `ingredients` | Name (unique), category, `is_fruit`, `is_vegetable`, serving size, raw kcal, protein, fat, carbs, fiber per 100 g |
| `tools` | Cooking tools (oven, air fryer, cast iron skillet...) |
| `recipes` | Name, kind (`proteinBase`, `carbBase`, `sauce`, `vegetable`, `complete`), expected yield factor, notes |
| `recipe_ingredients` | Raw grams per ingredient in a recipe |
| `recipe_steps` | Ordered steps: technique, optional temperature and minutes, optional tool |
| `recipe_tools` | Tools a recipe needs |
| `batch_sessions` | A cooking session and the days it covers |
| `batch_items` | A recipe cooked in a session: raw total and **measured** cooked total |
| `meal_logs` | One row per date and slot (1 to 3, unique), with a day type snapshot |
| `meal_components` | What a meal contains: grams of a batch item **or** of a fresh ingredient (database CHECK enforces exactly one) |
| `hydration_logs` | Water entries in ml |
| `day_logs` | Per date fruit and vegetable portion counters (added in schema version 2) |

On first creation the database is seeded from `NutritionPlan.exampleDefaults()` and `WeekSchedule.exampleDefaults()` (single source of truth for the numbers), plus 6 tools and 10 common ingredients.

**Migrations.** Version 1 to 2 creates `day_logs`. The migration test builds the current schema, drops the table, sets `user_version` to 1 and reopens.

**Derived, never stored:** remaining stock of a batch item, derived carbohydrate targets, per-100 g cooked values, shopping lists, plan results.

## Calculation rules

All of these are pure Dart under `features/*/domain` or `core/nutrition`, with unit tests.

1. **Carbs from the calorie residual.** `carbs = (kcal target - protein x 4 - fat x 9) / 4`, using the midpoint of the day type's kcal range. A warning flag appears when the result is outside the configured carb range.
2. **Protein per meal.** Target `protein per day / meals per day` (about 53.3 g). A meal's protein is compared with the configured band (50 to 55 g) and reported as below, within or above.
3. **Cooked-yield math.** Nutrients come from **raw** ingredient weights and are spread over the **measured cooked** weight: `nutrients per cooked gram = sum(raw g x nutrient per 100 g / 100) / cooked total g`. The yield factor is `cooked / raw`.
4. **Stock.** `remaining = cooked total - sum(meal component grams)`, computed by query. A batch item is "low" below 15% remaining and "empty" at zero.
5. **Meal composition.** A component is either stock (clamped to what remains unless the user confirms an override) or a fresh ingredient. A helper sets the grams of a protein base so the meal protein reaches the midpoint of the per-meal band.
6. **Daily progress.** Consumed versus target for kcal, protein, fat, carbs and fiber, plus water, fruit and vegetables. Ranges report below, within or above. Metrics with a single target (protein, fat, derived carbs) count as within at plus or minus 5%.
7. **Reverse batch planner.** For a block of days: sum protein needs and the derived carb needs per day (training days weigh more), subtract fresh additions, pantry leftovers and fixed vegetable and sauce roles (defaults 150 g and 30 g cooked per meal), then size the protein base and carb base. When a protein base also has carbs and a carb base also has protein, the 2x2 system is solved so contributions are not double counted; negative solutions are clamped to zero and the other base is sized for its own nutrient. Cooked grams become raw through the yield factor, each recipe line is scaled proportionally and rounded **up** to 5 g.
8. **Shopping list.** Scaled raw grams are aggregated per ingredient across recipes, grouped by category, with serving counts when a serving size is known, and exportable as a plain-text checklist.

Validation thresholds worth knowing: yield factor must be above 0 and at most 3; a measured yield more than 10% away from the recipe's yield triggers a note and an optional recipe update; an ingredient whose kcal differs more than 15% from 4P + 9F + 4C triggers a warning that does not block saving.

## State management

- Providers expose drift **streams** for data that changes while a screen is open (stock, a day's meals, hydration, servings, the plan).
- Forms (recipe editor, targets, composer) load once through a one-shot provider and keep local state, so a database write never rewrites the fields while the user types.
- The Today screen keeps a `selectedDateProvider`; the clock is injectable through `todayProvider` for tests.
- Shopping checklist ticks and the planner selection live in memory only.

**Critical drift gotcha.** drift shares watch streams by SQL text and variables. Each `customSelect(...).watch()` used as a change trigger must therefore have **distinct SQL** (for example `SELECT 1 AS watch_stock`, `watch_day`, `watch_plan`). Identical SQL makes unrelated watchers collapse into one stream and stop refreshing. This bug existed between schema work and the dashboard task and was fixed with a regression test.

## Backup subsystem

`features/backup` exports and imports the whole database as one versioned JSON document. See [backup-format.md](backup-format.md).

- `BackupCodec` is table-driven from drift column metadata; `backup_schema.dart` lists the tables in dependency order, and the codec throws if that list does not match `AppDatabase.allTables`.
- Import replaces all data in one transaction and rolls back fully on any error.
- `BackupFileGateway` abstracts the file picker, with a real implementation and a fake for tests.

## Testing strategy

- **Domain code:** plain unit tests with exact numbers (training day carbs 295 g at 2,450 kcal, rest day 251.25 g, planner Monday to Wednesday needs 480 g protein and 841.25 g carbs).
- **Data layer:** in-memory `NativeDatabase` tests for DAOs, constraints, rollback and migration.
- **Widgets:** screens mounted over an in-memory database through helpers in `test/helpers/`.
- Current total: 232 tests, all passing, `flutter analyze` clean (as of the commit in [current-status.md](current-status.md)).

Details and gotchas for writing tests are in [development-guide.md](development-guide.md).
