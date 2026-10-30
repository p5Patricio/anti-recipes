# Development plan

This document has two parts: **how the MVP was built** (the order matters and explains the architecture) and **what to build next**.

## Part 1: How the MVP was built

Work was cut into tasks that each deliver one verifiable behavior with its tests, and each task sits on the previous one. The order follows data dependencies: pure rules first, then storage, then the screens that read both.

| Task | Deliverable | Depends on | Why it comes here |
|------|-------------|------------|-------------------|
| T0 | Flutter SDK installed on the machine | None | Nothing can be built or tested without it |
| T1 | Project scaffold, public GitHub repo, theme tokens, docs skeleton | T0 | Gives every later task a home and a visual language |
| T2 | Pure-Dart nutrition engine and yield math | T1 | Rules are the heart of the product and need no UI or database to test |
| T3 | drift schema, DAOs, example seeds | T2 | Storage maps onto the domain objects defined in T2 |
| T4 | App shell, validated plan, targets screen | T3 | The first real screen; also hardened domain validation |
| T5 | Recipes and ingredient library | T3, T4 | Recipes are the source of all nutrient data |
| T6 | Batches, pantry stock, meal composer | T5 | Stock is made of cooked recipes; composing consumes stock |
| T7 | Today dashboard | T4, T6 | Aggregates meals, hydration and servings against targets |
| T8 | Batch planner and shopping list | T5, T6, T7 | Needs recipes, leftovers and per-day targets together |
| T9 | JSON backup and restore | All tables | Must cover every table, so it comes last |

### Delivery approach used

- One branch per task, stacked: each branch starts from the previous task's branch (`stacked-to-main` strategy chosen by the owner).
- Conventional Commits, tests and docs in the same unit of work, no AI attribution lines.
- Tasks were implemented by a bounded writer working from the task logbook, then checked by re-running `flutter test` in the parent session.
- Native review was offered for each candidate; the owner declined from T3 onward (see [current-status.md](current-status.md)).

### Lessons that shaped the next phases

- drift stream sharing by SQL text caused silent stale UI (fixed; see [architecture.md](architecture.md)).
- Widget tests that mount drift streams must unmount the tree inside the test body.
- Large vertical tasks produced very large branches. Smaller slices are easier to review.

## Part 2: What to build next

Everything below is a **proposal** until the owner confirms it. Phases are ordered by value and by risk: first make what exists trustworthy, then polish it, then extend it.

### Phase 1: Make the MVP trustworthy (recommended next)

Goal: the owner uses the app for real for a week and trusts the numbers.

1. **Publish the work.** Merge the stack in order, one pull request per branch, each retargeted to `main` after its parent merges (see the workflow in [development-guide.md](development-guide.md)). Record `size:exception` for oversized slices.
2. **Manual QA pass on the emulator or phone** using the checklist below. Fix what breaks, with a test per bug.
3. **Review the risky areas** that skipped native review: backup import, planner math, migration v1 to v2.
4. **Decide the rest-day carb inconsistency** (see [product-vision.md](product-vision.md)) and encode the decision in the defaults.
5. **Add CI**: a GitHub Actions workflow running `flutter analyze` and `flutter test` on pull requests.

Exit criteria: all branches merged into `main`; analyze and tests green in CI; the QA checklist passes on a physical device; the first real cooking week is logged without workarounds.

**Manual QA checklist**

- Create an ingredient, then a recipe with a yield factor, two tools and three steps; check macros per 100 g cooked.
- Log a batch with a measured cooked weight different from expected; confirm the yield note and the optional recipe update.
- Compose all three meals on Today from stock plus a fresh ingredient; confirm protein chips, remaining stock and day totals.
- Add hydration, undo it, change fruit and vegetable counts, move to another day and back.
- Plan Monday to Wednesday with a protein base and a carb base; compare the quantities with a hand calculation; open the shopping list and copy it as text.
- Use "Start cooking" and check the batch log is prefilled.
- Export a backup, change data, import the backup, confirm the data returns exactly; try importing a corrupted file and confirm nothing changes.
- Kill and restart the app; confirm data persists.

### Phase 2: Product polish

Goal: the app feels finished and is pleasant on day one.

- Launcher icon and native splash from the mascot logo.
- First-run onboarding that asks for weight and targets and explains the day-type cycle.
- Persist the planner selection and shopping ticks across restarts.
- Dark theme derived from the same tokens.
- Remove the empty `shopping/` folder.
- Optional: Spanish localization (UI copy is English today; the owner said English is fine).

Exit criteria: a fresh install reaches a configured, usable state without opening Settings first.

### Phase 3: Quality and release

- Release build configuration: application signing, version numbering, a release APK or app bundle.
- Optional backup hardening: encrypted export or a passphrase (the format is plaintext today).
- Performance check with a realistic amount of history (months of meals).
- Accessibility pass: text scaling, contrast of status colors, touch target sizes.

### Phase 4: Candidate features (ideas, not commitments)

These are not in scope and each needs a short product discussion before design.

- Weekly review: adherence to protein, calories, hydration and fiber over a week.
- Trend of body weight against the plan (only if the owner wants to log weight over time).
- Ingredient import from a public food database or a barcode scan.
- Cooking-day reminder notification.
- Recipe photos.
- iOS support (requires a macOS build machine or macOS CI).

## How to pick up work

1. Read [current-status.md](current-status.md) for the branch chain and open issues.
2. Read `odd/tasks/anti-recipes-mvp.md` for the original specs and evidence.
3. Follow [development-guide.md](development-guide.md) to set up and branch.
4. Keep tasks small: one behavior with its tests and docs per commit, about 400 authored lines as a planning guide.
