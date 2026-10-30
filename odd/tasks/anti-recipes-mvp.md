# Feature: anti-recipes MVP

## Objective
Local-first Flutter (Android) app that governs a calorie/carb-cycling recomposition plan
through modular batch cooking: recipes with raw/cooked yields, batch inventory, fast meal
composition, reverse batch planning and a consolidated shopping list.

## Problem / Why
The user cooks 1–2 times per week and needs every meal to hit 50–55 g protein, daily
kcal/carb targets that change by day type, fiber, hydration and fruit/veg portions,
without manual math or logging friction.

## Scope
- Nutrition engine (pure Dart): day-type targets, carb derivation from kcal residual,
  per-meal protein validation, cooked-yield nutrient math, reverse batch calc.
- drift (SQLite) schema: UserProfile, DayTypeTarget, WeekSchedule, Ingredient, Tool,
  Recipe, RecipeIngredient, RecipeStep, RecipeTool, BatchSession, BatchItem,
  MealLog, MealComponent, HydrationLog.
- Features: recipes CRUD, inventory + meal composer, batch planner + shopping list,
  daily dashboard (meals, hydration, fruit/veg, fiber), profile/targets onboarding,
  JSON export/import.
- Design system derived from the mascot logo palette.

## Constraints
- Stack: Flutter, Android only, Riverpod, drift. No backend, no auth.
- Minimal dependencies; feature-first folders with domain/data/presentation layers.
- Public repo: no personal nutrition data committed; example defaults only.
- Artifacts in English.

## Design tokens (from logo)
- graphite `#1F2933` (outlines / text), sage `#7E9F82` (primary),
  terracotta `#D9734E` (accent), off-white `#F4F0E8` (background),
  kraft `#C9A27A` (surface accent), white `#FFFFFF`.

## Known spec inconsistency
Rest days 2230–2320 kcal with 160 g protein + 70 g fat leave ~240–262 g carbs, below
the 270 g floor. Engine derives carbs from kcal residual and flags out-of-range values.

## TDD
Mode: off (no project/session configuration; user did not request it). Source: default.
Runner: `flutter test`. Domain logic still ships with unit tests.

## Delivery
Strategy: ask-on-risk (default). Forecast: well above 400 authored lines in total.
Chain strategy: stacked-to-main (user choice). One PR per task T2..T9, each branch
stacked on the previous task branch, merged to main in order.
Slices: T2 feat/nutrition-engine, T3 feat/database, T4 feat/profile-targets,
T5 feat/recipes, T6 feat/inventory, T7 feat/daily-dashboard, T8 feat/batch-planner,
T9 feat/export-import.
RDD: on (default).

## Tasks
- [x] T0 Install Flutter SDK (C:\src\flutter) and add to user PATH — route: inline
- [x] T1 Bootstrap: flutter create (android), deps, folder structure, README, .gitignore,
      issue templates, logo asset, theme tokens; create public GitHub repo and push — route: delegated
- [x] T2 Nutrition engine domain + unit tests — route: delegated
- [x] T3 drift database schema, DAOs, default seeds + tests — route: delegated
- [x] T4 Profile & targets onboarding/settings — route: delegated
- [x] T5 Recipes CRUD (ingredients, tools, steps, yields) — route: delegated
- [x] T6 Batch sessions, inventory and meal composer — route: delegated
- [x] T7 Daily dashboard (meals, hydration, fiber, fruit/veg) — route: delegated
- [x] T8 Batch planner + consolidated shopping list — route: delegated
- [ ] T9 JSON export/import — route: delegated

## Acceptance criteria
- `flutter analyze` clean, `flutter test` green.
- Engine reproduces spec targets (160 g protein, 70 g fat, ~53 g/meal, day-type kcal).
- A meal can be composed from batch stock in a few taps and updates inventory.

## Progress / Evidence
- T0: Flutter 3.47.6 / Dart 3.13.5 installed at C:\src\flutter, user PATH updated.
- T1: commit 4a87774 on main, pushed to https://github.com/p5Patricio/anti-recipes (public).
  `flutter analyze`: no issues; `flutter test`: 1 passed. RDD: bootstrap is mostly
  generated scaffold, pushed as initial commit (no reviewed boundary yet; branch point = 4a87774).

- T2: commits daea9c4 (engine) + .gitignore `.atl/` on feat/nutrition-engine.
  `flutter analyze`: no issues; `flutter test`: 25 passed (parent spot check re-run).
  RDD: medium, consent granted, lens review-reliability → approved and acknowledged
  (lineage review-06f6055bb3735746). Reviewed boundary advances to T2 head.
  Follow-ups (non-blocking WARNINGs, fold into T4 when plans load from user data):
  runtime validation for NutritionPlan (mealsPerDay > 0, all DayTypes present),
  WeekSchedule (all 7 weekdays) and Range (min <= max) instead of asserts; normalize
  dates to local calendar day in dayTypeFor; surface rest-day carb warning sensibly in UI.

- Delivery: user pushes-only policy — orchestrator pushes branches; PRs not opened.
  feat/nutrition-engine pushed.
- T3: commits e2e800d (dart format of T2 files, formatting only) + c7fddc3 (drift schema,
  DAOs, seeds) on feat/database. `build_runner build`: ok; `flutter analyze`: no issues;
  `flutter test`: 37 passed (parent spot check re-run). sqlite3 ^3.7.0 dev dep for
  in-memory tests (bundled hooks work on Windows). ~1050 authored lines (~300 seed data,
  ~305 tests) → exceeds the 400 budget; no cohesive split (schema + DAOs + tests are one
  unit) → size:exception recommended for this slice.
  RDD: medium, consent declined by user → RDD-off path, writer self-verification + parent
  spot check.

- feat/database pushed.
- T4: commit a3adb54 on feat/profile-targets. App shell (NavigationBar: Today, Recipes,
  Pantry, Plan, Settings), runtime validation for Range/WeekSchedule/NutritionPlan,
  local-weekday dayTypeFor, targets settings screen. `flutter analyze`: no issues;
  `flutter test`: 47 passed (parent spot check). ~1150 authored lines → over budget,
  cohesive UI unit → size:exception recommended. RDD: medium, consent declined.
  T2 follow-ups resolved.

- feat/profile-targets pushed.
- T5: commit 7a0a699 on feat/recipes. Recipes list with kind filters and per-100 g
  cooked macros, recipe editor (ingredients, tools, ordered steps, yield factor, live
  summary), detail view, ingredient library with kcal-vs-macros warning, safe deletes.
  `flutter analyze`: no issues; `flutter test`: 79 passed (parent spot check).
  ~2350 authored lines → size:exception recommended. RDD: medium, consent declined.
  Follow-ups: move NumberField helpers from nutrition_targets/presentation to
  core/widgets; drift stream widget tests must unmount the tree inside the test body.

- feat/recipes pushed.
- T6: commit 3f6c786 on feat/inventory. Batch logging with yield deviation note, pantry stock
  (low/empty chips), batch item detail with consumption history, meal composer (stock +
  fresh ingredients, protein range status, suggestion, override confirm). NumberField moved
  to core/widgets. `flutter analyze`: no issues; `flutter test`: 132 passed (parent spot
  check). ~2700 authored lines -> size:exception recommended. RDD: medium, consent declined.
  Composer not yet linked from Today (use openComposeMeal in T7).

- feat/inventory pushed.
- T7: commits 388884d (fix: drift shares streams by SQL text, so watchStock/watchDay/watchPlan
  collapsed into one stream; each now has distinct SQL, regression test added; bug dated
  from T3) + 7892d71 (Today dashboard: day header with day-type badge, macro bars, 3 meal slots
  with composer entry, hydration quick add/undo, fruit/veg steppers, protein distribution;
  DayLogs table, schemaVersion 2 with onUpgrade + migration test). `flutter analyze`: no
  issues; `flutter test`: 157 passed (parent spot check). ~1780 authored lines ->
  size:exception recommended. RDD: medium, consent declined.
  Note: single-value targets (protein/fat/carbs) count as within at +-5%.

- feat/daily-dashboard pushed.
- T8: commit 88b278d on feat/batch-planner. Pure-domain BatchPlanner (per-day targets summed,
  2x2 protein/carb cross-contribution solve with clamping, yield-aware raw weights rounded up
  to 5 g, fresh and leftover deductions), ShoppingList (aggregate by category, serving counts,
  text export), Plan tab UI, shopping checklist, "Start cooking" opens prefilled LogBatchScreen.
  `flutter analyze`: no issues; `flutter test`: 195 passed (parent spot check). ~2300 authored
  lines -> size:exception recommended. RDD: medium, consent declined.

## Next step
Push feat/batch-planner, then T9 JSON export/import on feat/export-import.
