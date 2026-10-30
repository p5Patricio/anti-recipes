<p align="center">
  <img src="assets/branding/logo.webp" alt="anti-recipes logo" width="160">
</p>

# anti-recipes

Local-first Android app for modular batch cooking, driven by calorie and carb cycling. Cook once or twice a week, then compose every meal from cooked components without manual math.

## Features

- Nutrition targets per day type (training / rest), with carbs derived from the calorie residual.
- Recipes with raw and cooked yields.
- Batch inventory and fast meal composition.
- Reverse batch planner: from weekly targets to quantities to cook.
- Consolidated shopping list.
- Daily dashboard: meals, hydration, fruit and vegetable portions, fiber.
- Backup and restore: export all data to a JSON file and import it back.

## Nutrition model

Example defaults (configured in-app, fully editable):

| Item | Default |
|------|---------|
| Protein | 160 g/day, 3 meals of 50-55 g |
| Fat | ~70 g/day |
| Training days | 2400-2500 kcal |
| Rest days | 2230-2320 kcal |
| Carbs | Derived from the kcal residual |
| Fiber | 30-35 g/day |
| Water | 3.0-3.5 L (+0.5-0.75 L on training days) |
| Fruit / vegetables | 1-3 / 2-3 portions per day |

These are example defaults only. Personal data is configured inside the app and is never committed to this repository.

## Backup & restore

Settings > Backup exports the whole database as a single JSON file
(`anti-recipes-backup-YYYYMMDD-HHmm.json`) and restores it from one. The file
is a versioned document: `format`, `version` (envelope), `schemaVersion`
(database), `exportedAt` and one array of rows per table. Importing replaces
all current data in a single transaction after a confirmation that shows what
will be loaded; any error rolls back and leaves your data untouched. Backups
from older database versions are accepted, backups from newer app versions are
refused.

Exports contain personal data (body weight, targets, meals, hydration) and are
not encrypted. Do not commit or share them casually. See
[docs/backup-format.md](docs/backup-format.md) for the full format.

Files are chosen through the system file picker (`file_picker`, Storage Access
Framework on Android), so the app needs no storage permission.

## Stack

- Flutter (Android only)
- Riverpod for state management
- drift on SQLite for storage
- No backend, no authentication

## Architecture

Feature-first layout. Each feature has `domain`, `data` and `presentation` layers; the domain layer is pure Dart (no Flutter imports).

## Getting started

```bash
flutter pub get
dart run build_runner build -d
flutter test
flutter run
```

## Project structure

```
lib/
  main.dart, app.dart, app_shell.dart
  core/
    database/        # drift tables, database, migrations
    nutrition/       # shared value objects (pure Dart)
    formatting/      # date and gram formatting
    theme/           # colors and ThemeData
    widgets/         # shared form widgets
  features/
    nutrition_targets/   # plan, day types, engine, targets screen
    recipes/             # recipes and ingredient library
    inventory/           # batches and pantry stock
    meal_log/            # Today dashboard and meal composer
    batch_planner/       # reverse planner and shopping list
    backup/              # JSON export/import
    settings/
      domain/ data/ presentation/
assets/branding/     # logo
docs/                # product, architecture, status, plan, guides
```

## Documentation

Start at [docs/README.md](docs/README.md). Contributors and AI agents should also read [AGENTS.md](AGENTS.md).
