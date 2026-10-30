# AGENTS.md

Context and rules for AI coding agents working on **anti-recipes**. Read this first, then follow the pointers. Everything here was verified against the repository on 2026-10-29 (HEAD `0ca084c`).

## What this project is

A local-first **Flutter (Android only)** app for modular batch cooking with calorie and carb cycling. The user cooks components once or twice a week, then composes meals from cooked stock while the app tracks protein per meal, daily targets, hydration, fiber and fruit/vegetable portions. One user, one phone, no backend, no accounts. Full vision: [docs/product-vision.md](docs/product-vision.md).

## Status in one paragraph

The MVP (tasks T0 to T9) is implemented: targets, recipes, pantry and meal composer, Today dashboard, reverse batch planner with shopping list, and JSON backup. 232 tests pass and `flutter analyze` is clean. The app booted on an Android emulator, but a human has not walked through all flows. Work lives on **stacked branches** (`main` <- `feat/nutrition-engine` <- ... <- `feat/export-import`), all pushed, **no pull requests opened**. Details: [docs/current-status.md](docs/current-status.md). What to do next: [docs/development-plan.md](docs/development-plan.md).

## Document map

| Need | Read |
|------|------|
| Product goals, nutrition rules, palette | [docs/product-vision.md](docs/product-vision.md) |
| Layers, tables, calculation rules, state | [docs/architecture.md](docs/architecture.md) |
| What exists, branches, known gaps | [docs/current-status.md](docs/current-status.md) |
| Build order and roadmap, QA checklist | [docs/development-plan.md](docs/development-plan.md) |
| Setup, commands, git workflow, test gotchas | [docs/development-guide.md](docs/development-guide.md) |
| Backup JSON format | [docs/backup-format.md](docs/backup-format.md) |
| Original specs and evidence of the MVP build | [odd/tasks/anti-recipes-mvp.md](odd/tasks/anti-recipes-mvp.md) |

## Commands

Run in Git Bash from the repository root. Put Flutter on the path first: `export PATH="/c/src/flutter/bin:$PATH"` (already on the user `PATH` in new terminals).

```bash
flutter pub get
dart run build_runner build -d   # after changing drift tables or DAOs; commit the *.g.dart files
dart format lib test
flutter analyze
flutter test
flutter run -d emulator-5554     # emulator: emulator -avd anti_recipes_pixel
```

Environment: Flutter 3.47.6 (`C:\src\flutter`), JDK 17, Android SDK `C:\Android\Sdk`, AVD `anti_recipes_pixel`. In Git Bash never pass unquoted `C:\\...` paths (backslashes are lost); use forward slashes or quotes.

## Architecture rules (do not break)

1. **Feature-first slices** under `lib/features/<name>/{domain,data,presentation}`; shared code in `lib/core`.
2. **Domain is pure Dart.** No imports of Flutter, drift or Riverpod in `domain/` or `lib/core/nutrition`. Nutrition rules live there and are unit-tested with exact numbers.
3. **Derive, do not store.** Stock remaining, derived carbs, per-100 g values, shopping lists and plan results are computed. Never add a column that caches them.
4. **Carbs come from calories.** `carbs = (kcal - protein x 4 - fat x 9) / 4`. The configured carb range only produces a warning. Do not "fix" the rest-day warning without an owner decision (see vision doc).
5. **Nutrients use raw weights spread over measured cooked weight.** Do not compute macros from cooked weight times a per-100 g raw value.
6. **Every drift `watch` trigger needs distinct SQL text** (for example `SELECT 1 AS watch_stock`). drift shares streams by SQL, and identical SQL silently freezes unrelated streams.
7. **Forms load once and keep local state.** Do not make form fields depend on a live stream.
8. **Schema changes** require: bump `schemaVersion`, `onUpgrade` step, regenerate, register the table in `lib/features/backup/data/backup_schema.dart`, extend `test/helpers/backup_fixtures.dart`, add a migration test, update docs. Checklist in [docs/development-guide.md](docs/development-guide.md).
9. **Minimal dependencies.** Current runtime packages: `flutter_riverpod`, `drift`, `drift_flutter`, `file_picker`. Ask before adding another.
10. **Platform code behind abstractions** (for example `BackupFileGateway`) so tests never touch plugins.

## Conventions

- **Language of artifacts: English** (code, comments, UI copy, tests, docs, commit messages). The maintainer talks to you in Spanish; reply in the language of their message, but never put Spanish or slang into files unless explicitly asked.
- **Commits:** Conventional Commits. **Never add `Co-Authored-By` or any AI attribution** to commits or PR text (the maintainer's global rule overrides tool defaults).
- **Branches:** `feat/...`, `fix/...`, `docs/...`. Keep commits to one reviewable unit with its tests and docs; about 400 authored changed lines is a planning guide, never a reason to delete tests, comments or blank lines.
- **Do not push or open pull requests unless asked.** Pushing branches has been requested before; PRs have not.
- **Formatting and lint:** `dart format` and `flutter analyze` must be clean before you report done.
- **Theme:** use `AppColors` and `AppTheme` tokens (graphite `#1F2933`, sage `#7E9F82`, terracotta `#D9734E`, off-white `#F4F0E8`, kraft `#C9A27A`). No hardcoded colors in widgets. Status colors: sage within target, kraft below, terracotta above.

## Privacy: this repository is public

Never commit body weight, real nutrition targets, meal history, backups, `*.db`, `*.sqlite`, `local_seed.json` or an `exports/` folder (all gitignored). The repository carries only generic example defaults. Backups contain personal data and are unencrypted.

## Testing

232 tests; mirror `lib/` under `test/`. Use in-memory `AppDatabase(NativeDatabase.memory())` and the helpers in `test/helpers/`. Hard-won rules:

- Widget tests that mount drift streams must unmount the tree **inside the test body** (`await tester.pumpWidget(const SizedBox()); await tester.pump(const Duration(milliseconds: 10));`).
- Never `await` a drift stream (`.first`) inside `testWidgets`; use `select(...).get()` or DAO `load*` methods.
- Helper files under `test/` must not end in `_test.dart`.
- If `flutter test` fails on `sqlite3.dll`, run `taskkill //F //IM flutter_tester.exe`.
- Riverpod 3: use `NotifierProvider` (no `StateProvider`); `Override` is exported from `package:flutter_riverpod/misc.dart`.
- Fixed dates in tests: 2026-10-05 is a Monday.

More in [docs/development-guide.md](docs/development-guide.md).

## Where things live

| Topic | Files |
|-------|-------|
| Engine: targets, carbs, meal check, progress | `lib/features/nutrition_targets/domain/nutrition_engine.dart`, `nutrition_plan.dart` |
| Shared value objects | `lib/core/nutrition/nutrients.dart`, `range.dart` |
| Yield and recipe math | `lib/features/recipes/domain/yield_calculator.dart`, `recipe_nutrition.dart`, `energy_check.dart` |
| Database | `lib/core/database/tables.dart`, `app_database.dart`, `database_provider.dart` |
| DAOs | `lib/features/*/data/*_dao.dart` |
| Day summary and composer helpers | `lib/features/meal_log/domain/` |
| Planner and shopping list | `lib/features/batch_planner/domain/batch_planner.dart`, `shopping_list.dart` |
| Backup | `lib/features/backup/` |
| App shell and tabs | `lib/app_shell.dart` (Today, Recipes, Pantry, Plan, Settings) |
| Theme | `lib/core/theme/` |

## Known pitfalls and open items

- **Open product decision:** rest days derive about 251 g carbs versus a configured 270 g floor, so every rest day shows an info warning. Ask the owner before changing defaults or logic.
- Single-value targets count as "within" at plus or minus 5%: an implementation assumption, not an owner decision.
- Not done yet: onboarding, launcher icon and splash (still Flutter defaults), dark theme, persistence of planner selection and shopping ticks, CI, release signing. Empty `lib/features/shopping/` folder can be removed.
- The file picker backup flow has only been tested through a fake gateway, never on a device.

## Review workflow used in this repo

The maintainer uses `gentle-ai` receipt-driven review. After a work-unit commit, run `gentle-ai review assess --cwd <repo> --agent <agent> --base-ref <last reviewed boundary> --committed-only --json` and follow the returned transition. When the start step returns a consent envelope (`gentle-ai.review-integration.consent/v3`), **relay it to the human in full and never answer it yourself**; run only the invocation matching their choice. Reviewed boundary today: T2 was reviewed; T3 to T9 were declined by the owner. Do not toggle review mode.

## Working agreements

- Read before you write; verify claims against code or a command, not memory.
- Prefer the smallest change that satisfies the request; keep unrelated files untouched and preserve other people's uncommitted work.
- Ask one question at a time, only for real product decisions.
- Report faithfully: say what you ran and what it printed, and call out anything skipped or failing.
- When behavior, schema or workflow changes, update the matching document under `docs/` in the same change.
