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
- JSON export/import.

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
  main.dart, app.dart
  core/
    database/        # drift database and migrations
    theme/           # colors and ThemeData
  features/
    nutrition_targets/
    recipes/
    inventory/
    batch_planner/
    meal_log/
    shopping/
      domain/ data/ presentation/
assets/branding/     # logo
docs/
```
