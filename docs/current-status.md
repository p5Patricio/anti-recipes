# Current status

Snapshot: **2026-11-27**. `main` holds the MVP, CI, the follow-up work described under "Follow-up work (Milestone 1)" (pull request #10), the visual rebrand described under "Branding and theme" (pull request #11) and the English/Spanish localization described under "Localization".

## Summary

The MVP defined in [product-vision.md](product-vision.md) is **fully implemented** (tasks T0 to T9), merged into `main`, and passes its automated checks. It has **not been exercised end to end by a human on a device**: it was installed on an Android emulator and the Today dashboard rendered correctly, but the other flows were verified only through automated tests.

| Check | Result | Verified |
|-------|--------|----------|
| `dart format lib test` | No changes needed (138 files) | Yes, on 2026-11-26 with Milestone 1 applied |
| `flutter analyze` | No issues | Yes, on 2026-11-26 with Milestone 1 applied |
| `flutter test` | 277 tests passing | Yes, on 2026-11-27 with localization applied |
| Debug APK build | Succeeds (first build about 6 minutes, includes Gradle and NDK downloads) | Yes |
| Boot on Android 16 emulator | App starts and shows the Today dashboard in the dark theme; splash, app bar logo and launcher icon render correctly | Yes (screenshots, 2026-11-27) |
| Manual walk-through of recipes, pantry, planner, backup | Not done | No |
| File picker on a real or emulated device | Not done | No |

## What exists, by area

**Today (dashboard).** Date navigation with a Training/Rest badge; calories and macros progress; three meal slots that open the composer; protein-per-meal bars against the 50 to 55 g band; hydration quick add (+250, +500, +750 ml), custom amount and undo; fruit and vegetable steppers.

**Recipes.** List with kind filters and macros per 100 g cooked; editor with ingredient lines, tools, ordered steps, yield factor, notes and a live summary; detail view; ingredient library with validation; deletes that fail gracefully when an item is still referenced.

**Pantry.** Log a cooked batch (recipe, raw total, measured cooked total, covered dates) with a yield-deviation note; stock list with low and empty indicators; batch detail with consumption history; delete only when never consumed. The **meal composer** builds a meal from stock and fresh ingredients with live totals, a protein status chip, a "reach protein target" suggestion and an over-stock confirmation.

**Plan.** Pick days and the recipe for each role (protein base, carb base, optional vegetable and sauce), add fresh items and pantry leftovers, and read how much to cook per recipe, per-day needs versus coverage and residuals. A grouped shopping checklist with copy-as-text, and a "Start cooking" action that opens the batch log prefilled.

**Settings.** Nutrition targets (profile, per day type ranges, weekly schedule, reset to defaults) and Backup (export, import with confirmation, privacy note).

## Delivery state

The MVP was built as a chain of stacked branches and landed in `main` through pull requests, one commit per pull request:

| PR | Task | Adds |
|----|------|------|
| #1 | T2 | Pure-Dart engine and yield math |
| #2 | T3 | drift schema, DAOs, seeds |
| #3 | T4 | App shell, validated plan, targets screen |
| #4 | T5 | Recipes and ingredient library |
| #5 | T6 | Batches, pantry, meal composer |
| #6 | T7 | Today dashboard, `day_logs`, schema v2, watcher fix |
| #7 | T8 | Planner and shopping list |
| #8 | T9 | JSON backup and restore |
| #9 | CI | GitHub Actions workflow running `flutter analyze` and `flutter test` |

The task branches of those pull requests (`feat/*` and `ci/add-github-actions`) no longer exist on `origin`; only `main` and the branch of the open Milestone 1 pull request remain. The task logbook in `odd/tasks/anti-recipes-mvp.md` records the original size numbers.

## Follow-up work (Milestone 1), merged

Pull request #10 (branch `feat/settings-persistence`) added, on top of the MVP:

- **`app_settings` table (schema v3)** with `SettingsDao`: a key-value store, registered in the backup so it round-trips. Migration v2 to v3 creates it.
- **Persistence of the planner selection and the shopping checklist** across app restarts, stored under the keys `active_plan_selection` and `shopping_checked_ids`. Importing a backup reloads both.
- **Rest-day carb floor lowered to 245 g** (default rest range 245 to 305 g), so derived rest-day carbs (about 251 g) no longer raise a warning. This resolves the open question in [product-vision.md](product-vision.md) in the code. **The owner confirmed it on 2026-11-26 as the current default** ("for now"), so it may be revisited; it is isolated in its own commit so it can be reverted.
- Removal of the empty `lib/features/shopping/` placeholder folders.
- New tests: persistence across a simulated restart, carb-boundary stress tests, and a migration test that upgrades a v1 database.

## Branding and theme, merged

Pull request #11 (branch `feat/duck-branding-dark-theme`) added:

- **Dark-first theme.** `AppTheme.light()` was replaced by `AppTheme.dark()` and the tokens in `lib/core/theme/app_colors.dart` now follow the logo palette (ink, cream, ink red, blossom, kraft). Status colors: blossom within target, kraft below, light ink red above. The primary red was darkened to `#BF2D28` so cream text reaches about 4.7:1 (hand calculation, not a tool result).
- **New logo**: a duck wearing a chef hat in a bowl, in ink-brush style, generated with an image model (the original reference stays in `assets/branding/logo_original.png`). The old container mascot (`logo.webp`) was removed.
- **Android resources:** adaptive launcher icon, black splash screen (including the Android 12+ splash screen API) and the new logo in the Today app bar.
- Tests only had token renames; the count is unchanged at 264.

Not covered: the pull request had no native review (the owner did not request one), and contrast was not measured with a tool.

## Localization

The UI is available in English and Spanish.

- **Mechanism:** Flutter `gen_l10n` with `lib/l10n/app_en.arb` (template) and `lib/l10n/app_es.arb`; widgets read strings through `context.l10n`. The generated Dart files are committed.
- **Language choice:** follows the system language (English fallback). Settings has a Language tile (system default, English, Español); the override is stored in `app_settings` under `app_locale`, so no schema change was needed.
- **Layering:** domain and data code carries no display text. Backup failures are a typed `BackupException` (`BackupFailure` enum plus parameters) and shopping-list export text moved to presentation; both are localized in presentation. `BackupException.message` no longer exists.
- **Dates** use `intl` `DateFormat` with the current locale. Plural forms use ICU, which also fixes "1 portions" style output.
- **Tests:** English assertions are unchanged; Spanish smoke tests exist for recipes, Today, targets, the planner and backup errors, plus ARB key parity and language switching/persistence tests.

Not covered: user data (ingredient, recipe and tool names, including the seeded defaults stored in the database) stays as entered, so a Spanish user sees the seeded English names until they rename them. Number formatting keeps a dot as decimal separator in both languages. Spanish copy was written by an AI and has not been reviewed by a native speaker.

## Review status

Native review (receipt-driven development) is enabled in this repository. T2 was reviewed and approved. For T3 to T9 the owner **declined review for each candidate**, so those slices were verified by tests, `flutter analyze` and a parent re-run only. Milestone 1, the branding pull request and the localization have not gone through native review. Highest-value areas to review: the backup import (replaces all data), the batch planner math, and the schema migrations (v1 to v2 to v3).

## Known limitations and technical debt

Each item is verified unless marked otherwise.

1. **Rest-day carb floor:** lowered to 245 g in Milestone 1 so derived carbs (about 251.25 g) evaluate within target. Confirmed by the owner on 2026-11-26 as the current default (see above).
2. **No first-run onboarding.** The app starts with example defaults; the user edits them in Settings.
3. **Dark theme only.** `AppTheme` has a `dark()` constructor and no light variant; the app ignores the system theme setting.
4. **Logo is a raster image** (1024 px PNG from an image model) with no vector source, and the icon was checked only on one emulator.
5. **CI exists but is minimal.** `.github/workflows/ci.yml` runs `flutter analyze` and `flutter test` on pull requests and pushes to `main` (Flutter 3.47.6, Ubuntu). There is no build, release or signing step.
6. **Backups are unencrypted** and contain personal data. Restoring on a device in another time zone keeps the same instants for day-level dates, which can fall on a neighboring calendar day (documented in [backup-format.md](backup-format.md)).
7. **Single-value target tolerance is a guess.** Protein, fat and derived carbs count as "within" at plus or minus 5%; that number was chosen by the implementation, not specified by the owner (**assumption**).
8. **Windows desktop tooling is not set up** (Visual Studio is missing). Irrelevant for Android development.

## Environment of record

Flutter 3.47.6 at `C:\src\flutter`, Microsoft OpenJDK 17, Android SDK at `C:\Android\Sdk` (API 36), emulator `anti_recipes_pixel` (Pixel 7). Setup details are in [development-guide.md](development-guide.md).
