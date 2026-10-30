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
| Carbohydrates | configured range 270 to 305 g, but **derived** from calories left after protein and fat |
| Fiber | 30 to 35 g/day |
| Water | 3.0 to 3.5 L/day on rest days, 3.5 to 4.25 L on training days (+0.5 to +0.75 L) |
| Fruit | 1 to 3 portions/day |
| Vegetables | 2 to 3 portions/day |
| Meals | 3 main meals/day, 50 to 55 g of protein each |
| Default week | Monday, Tuesday, Thursday, Friday training; Wednesday, Saturday, Sunday rest |

### Known inconsistency in the original specification

With 160 g of protein (640 kcal) and 70 g of fat (630 kcal), a rest day of 2,230 to 2,320 kcal leaves only about 240 to 262 g of carbohydrates. The specification also asks for 270 to 305 g. The two cannot both hold on a rest day.

**How the app handles it today:** calories are the source of truth. Carbohydrates are derived as `(kcal - protein x 4 - fat x 9) / 4`. If the derived value falls outside the configured carb range, the app shows an informational warning instead of blocking anything. With the defaults, every rest day shows that warning (251.25 g at the 2,275 kcal midpoint).

**Open decision (owner: the user):** either raise the rest-day calories, lower the carb floor for rest days, or accept the warning as normal. Until decided, the defaults stay as specified and the warning is expected.

## Visual identity

The design system comes from the project mascot: a smiling meal-prep container hugging two grocery bags. The logo is original artwork inspired by a scene the author liked, not a reproduction of any existing character, because the original is protected and this repository is public.

| Token | Hex | Use |
|-------|-----|-----|
| Graphite | `#1F2933` | Text and outlines |
| Sage | `#7E9F82` | Primary color; "within target" status |
| Terracotta | `#D9734E` | Accent, floating action buttons; "above target" status (also used for out-of-band warnings) |
| Off-white | `#F4F0E8` | Scaffold background |
| Kraft | `#C9A27A` | Warm accent; "below target" status on the Today dashboard |
| White | `#FFFFFF` | Card surfaces |

Cards use rounded corners with a thin outline that echoes the logo's thick contours. UI copy is in English.
