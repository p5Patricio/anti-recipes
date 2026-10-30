# Current status

Snapshot: **2026-10-29**, repository HEAD `0ca084c` on branch `feat/export-import`.

## Summary

The MVP defined in [product-vision.md](product-vision.md) is **fully implemented** (tasks T0 to T9) and passes its automated checks. It has **not been exercised end to end by a human on a device**: it was installed on an Android emulator and the Today dashboard rendered correctly, but the other flows were verified only through automated tests.

| Check | Result | Verified |
|-------|--------|----------|
| `flutter analyze` | No issues | Yes, after T9 |
| `flutter test` | 232 tests passing | Yes, after T9 |
| Debug APK build | Succeeds (first build about 6 minutes, includes Gradle and NDK downloads) | Yes |
| Boot on Android 16 emulator | App starts and shows the Today dashboard | Yes (screenshot) |
| Manual walk-through of recipes, pantry, planner, backup | Not done | No |
| File picker on a real or emulated device | Not done | No |

## What exists, by area

**Today (dashboard).** Date navigation with a Training/Rest badge; calories and macros progress; three meal slots that open the composer; protein-per-meal bars against the 50 to 55 g band; hydration quick add (+250, +500, +750 ml), custom amount and undo; fruit and vegetable steppers.

**Recipes.** List with kind filters and macros per 100 g cooked; editor with ingredient lines, tools, ordered steps, yield factor, notes and a live summary; detail view; ingredient library with validation; deletes that fail gracefully when an item is still referenced.

**Pantry.** Log a cooked batch (recipe, raw total, measured cooked total, covered dates) with a yield-deviation note; stock list with low and empty indicators; batch detail with consumption history; delete only when never consumed. The **meal composer** builds a meal from stock and fresh ingredients with live totals, a protein status chip, a "reach protein target" suggestion and an over-stock confirmation.

**Plan.** Pick days and the recipe for each role (protein base, carb base, optional vegetable and sauce), add fresh items and pantry leftovers, and read how much to cook per recipe, per-day needs versus coverage and residuals. A grouped shopping checklist with copy-as-text, and a "Start cooking" action that opens the batch log prefilled.

**Settings.** Nutrition targets (profile, per day type ranges, weekly schedule, reset to defaults) and Backup (export, import with confirmation, privacy note).

## Branches (stacked)

The work is a chain of branches, each created from the previous one. All are pushed to `origin`. No pull request has been opened. `main` only contains the bootstrap commit.

| Order | Branch | Task | Adds |
|-------|--------|------|------|
| 0 | `main` | T1 | Project scaffold, theme tokens, README, issue templates |
| 1 | `feat/nutrition-engine` | T2 | Pure-Dart engine and yield math |
| 2 | `feat/database` | T3 | drift schema, DAOs, seeds |
| 3 | `feat/profile-targets` | T4 | App shell, validated plan, targets screen |
| 4 | `feat/recipes` | T5 | Recipes and ingredient library |
| 5 | `feat/inventory` | T6 | Batches, pantry, meal composer |
| 6 | `feat/daily-dashboard` | T7 | Today dashboard, `day_logs`, schema v2, watcher fix |
| 7 | `feat/batch-planner` | T8 | Planner and shopping list |
| 8 | `feat/export-import` | T9 | JSON backup and restore |

Every branch from T3 on adds well over 400 authored lines (between about 1,000 and 2,700 including tests), so each pull request needs a `size:exception` note or a decision to accept the size. The task logbook in `odd/tasks/anti-recipes-mvp.md` records the numbers.

## Review status

Native review (receipt-driven development) is enabled in this repository. T2 was reviewed and approved. For T3 to T9 the owner **declined review for each candidate**, so those slices were verified by tests, `flutter analyze` and a parent re-run only. Highest-value areas to review before publishing: the backup import (replaces all data), the batch planner math, and the schema migration.

## Known limitations and technical debt

Each item is verified unless marked otherwise.

1. **Open product decision:** rest-day carbs derived from calories (about 251 g) are always below the configured 270 g floor, so every rest day shows an info warning. See [product-vision.md](product-vision.md).
2. **No first-run onboarding.** The app starts with example defaults; the user edits them in Settings.
3. **Default Flutter launcher icon and native splash.** The mascot logo is only used inside the app (Today header). The Android resources were never customized.
4. **Light theme only.** `AppTheme` has a `light()` constructor and no dark variant.
5. **Planner selection and shopping ticks are in memory.** They reset when the app restarts.
6. **Empty `lib/features/shopping/` folder.** Only `.gitkeep` files remain; the shopping list lives in `batch_planner`. The folder can be deleted.
7. **No CI.** There is no GitHub Actions workflow; analysis and tests run locally only.
8. **Backups are unencrypted** and contain personal data. Restoring on a device in another time zone keeps the same instants for day-level dates, which can fall on a neighboring calendar day (documented in [backup-format.md](backup-format.md)).
9. **Single-value target tolerance is a guess.** Protein, fat and derived carbs count as "within" at plus or minus 5%; that number was chosen by the implementation, not specified by the owner (**assumption**).
10. **Windows desktop tooling is not set up** (Visual Studio is missing). Irrelevant for Android development.

## Environment of record

Flutter 3.47.6 at `C:\src\flutter`, Microsoft OpenJDK 17, Android SDK at `C:\Android\Sdk` (API 36), emulator `anti_recipes_pixel` (Pixel 7). Setup details are in [development-guide.md](development-guide.md).
