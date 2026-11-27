# Product vision

## What it is

anti-recipes is a **local-first Android app for modular batch cooking** driven by a strict body-recomposition plan with calorie and carbohydrate cycling.

The user cooks once or twice a week. Instead of cooking finished meals, they cook **components** (a protein base, a carbohydrate base, vegetables, sauces) in quantities computed from the nutrition targets. Every later meal is composed in seconds from that cooked stock plus a few fresh ingredients, and the app keeps the numbers honest.

## The problem

A plan with 160 g of protein spread over three meals of 50 to 55 g, different calorie and carb targets on training and rest days, fiber, hydration and fruit and vegetable portions is easy to describe and tedious to follow. Doing the arithmetic by hand every day, and again when deciding how much to cook on Sunday, creates friction, and friction ends plans.

The app removes the arithmetic:

- It knows the targets for each day type and for each meal.
- It knows how much raw food becomes how much cooked food (yield and shrinkage).
- It knows what is left in the fridge.
- It tells the user how much to cook and buy for the next block of days, and whether a meal they are composing hits the protein band.

## Who it is for

A single user on a single Android phone: the author. This is a personal tool, published as a public repository. There is no multi-user, sharing or social scenario.

## Product principles

1. **Local-first.** Logging a meal or an inventory change must be instant and work offline. All data lives in a SQLite database on the device. There is no backend and no account.
2. **No friction while logging.** Prefer quick actions (quantity chips, "all remaining", one-tap hydration) over forms.
3. **Derive, do not store.** Remaining stock, derived carbohydrate targets, shopping lists and per-100 g values are computed from source data so they cannot drift out of sync.
4. **The domain is plain Dart.** Nutrition rules live in code without Flutter or database imports, so they are unit-tested and reusable.
5. **Privacy by construction.** The repository is public. Personal data (body weight, real targets, backups) is entered in the app, stored on the device and never committed. The repository only contains generic example defaults.

## Goals

- Compute daily targets per day type and show progress against them.
- Manage recipes with raw weight versus cooked weight, shrinkage, techniques, tools and steps, with automatic macros per portion and per batch.
- Track batch-cooked stock and let the user compose a meal from stock in a few taps.
- Plan a cooking session in reverse: from the block of days to cover, to the quantities to cook, to a consolidated shopping list.
- Back up and restore everything as one JSON file.

## Non-goals (for now)

- Cloud sync, accounts, multi-device use, sharing or social features.
- iOS (the author works on Windows and has no macOS build machine). The project is generated with the Android platform only.
- A food database lookup or barcode scanning. Ingredients are entered by hand with per-100 g raw values.
- Medical or personalized dietary advice. The app enforces numbers the user configures; it does not choose them.

## Nutrition model

These are the **example defaults** loaded on first run. Every value is editable in Settings, and none of them is personal data.

| Item | Default |
|------|---------|
| Average weekly energy | about 2,350 kcal/day |
| Training days (4 per week) | 2,400 to 2,500 kcal |
| Rest days (3 per week) | 2,230 to 2,320 kcal |
| Protein | 160 g/day, fixed every day (about 2.0 g/kg) |
| Fat | about 70 g/day (about 27% of calories) |
| Carbohydrates | configured range 270 to 305 g (training) / 245 to 305 g (rest), **derived** from calories left after protein and fat |
| Fiber | 30 to 35 g/day |
| Water | 3.0 to 3.5 L/day on rest days, 3.5 to 4.25 L on training days (+0.5 to +0.75 L) |
| Fruit | 1 to 3 portions/day |
| Vegetables | 2 to 3 portions/day |
| Meals | 3 main meals/day, 50 to 55 g of protein each |
| Default week | Monday, Tuesday, Thursday, Friday training; Wednesday, Saturday, Sunday rest |

### Specification inconsistency and how the code treats it

With 160 g of protein (640 kcal) and 70 g of fat (630 kcal), a rest day of 2,230 to 2,320 kcal leaves only about 240 to 262 g of carbohydrates. The original specification also asked for a carbohydrate range of 270 to 305 g. The two cannot both hold on a rest day.

**Rule in the code:** calories are the source of truth. Carbohydrates are derived as `(kcal - protein x 4 - fat x 9) / 4`, and the configured carb range only produces an informational warning when the derived value falls outside it.

**Current defaults (Milestone 1):** the rest-day carb range was lowered to 245 to 305 g, so the derived value at the 2,275 kcal midpoint (251.25 g) is within range and no warning appears. Training days keep 270 to 305 g (295 g derived at 2,450 kcal).

**Status:** the owner confirmed on 2026-11-26 that the 245 g floor stays as the current default ("for now"), so it is a product decision that may still be revisited. Alternatives the owner could choose later: raise the rest-day calories, or restore the 270 g floor and accept the warning on rest days.

**Resolution:** calories remain the source of truth. Carbohydrates are derived as `(kcal - protein x 4 - fat x 9) / 4`. The rest-day carbohydrate range floor was adjusted to 245 g (`Range(245, 305)`), allowing the derived 251.25 g at the 2,275 kcal midpoint to evaluate cleanly within target with 0 warnings.

## Visual identity

The design system comes from the project logo: a duck wearing a chef hat, sitting in a bowl with chopsticks, drawn in Japanese ink-brush style over a red enso circle with cherry blossoms. The app is dark-first. Sources are in `assets/branding/` (`logo_original.png` is the reference the duck version was built from).

| Token | Hex | Use |
|-------|-----|-----|
| Ink | `#0B0B0C` | Scaffold; dark text on filled chips |
| Surface / raised | `#161517` / `#211F21` | Cards, navigation bar / chips |
| Cream | `#F2E6CF` | Body text |
| Ink red | `#BF2D28` | Primary: buttons, FAB, selected navigation; light variant `#E8645B` is "above target" |
| Blossom | `#F2A0B0` | Secondary highlight; "within target" status |
| Kraft | `#C9A27A` | Tertiary; "below target" status |

Full token list lives in `lib/core/theme/app_colors.dart`. Status chips always carry a text label because blossom and kraft are close in lightness. Cards use rounded corners with a thin outline that echoes the logo's thick contours. UI copy is in English.
