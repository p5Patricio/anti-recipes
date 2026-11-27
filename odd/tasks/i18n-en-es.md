# i18n: English and Spanish

Objective: ship the app in English and Spanish. Branch: `feat/i18n-en-es`. Delivery: pull requests into `main`. Test runner: `flutter test`.

## Specs

- S1: "la app este disponible tanto en ingles como el español". Every user-visible string comes from ARB files (`lib/l10n/app_en.arb`, `lib/l10n/app_es.arb`) through `context.l10n`.
- S2: The app follows the system language (English fallback) and the user can override it in Settings; the override persists in `app_settings` under `app_locale` (no schema change).
- S3: English strings stay identical to today's copy so existing tests keep their assertions. Spanish is neutral Latin American Spanish, no regional slang.
- S4: Domain code stays pure Dart (no Flutter imports); domain and data layers must not carry user-facing text, they expose codes or typed reasons that presentation localizes.

## Tasks

- T0 infrastructure (S1, S2): inline, commit on `feat/i18n-en-es`.
- T1 recipes + core widgets (S1, S3, S4): delegated, own worktree.
- T2 meal_log + nutrition_targets (S1, S3, S4): delegated, own worktree.
- T3 batch_planner + inventory + backup + app shell (S1, S3, S4): delegated, own worktree.
- T4 merge, regenerate ARB, verify on emulator in both languages (S1-S4): inline.

Status 2026-11-27: T0-T4 done; 277 tests pass.

## Log

- L1 (2026-11-27): "Muy bien ahora necesito que la app este disponible tanto en ingles como el español asi que hay que hacer la implementacion, usa subagentes para este cambio y sube todo a main cuando termines"
- Route declaration: T1-T3 delegated under the Writer trigger (three independent units with disjoint edit surfaces, each over 100 changed lines). Shared ARB files are handled by giving each writer its own worktree and merging the ARB files by key afterwards.
