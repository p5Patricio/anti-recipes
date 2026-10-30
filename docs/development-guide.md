# Development guide

Practical instructions for working on anti-recipes. Commands are for Git Bash on Windows unless noted.

## Machine setup (as installed on the owner's PC)

| Component | Location |
|-----------|----------|
| Flutter SDK 3.47.6 (stable) | `C:\src\flutter` (on the user `PATH`) |
| Microsoft OpenJDK 17 | `C:\Program Files\Microsoft\jdk-17.0.20.101-hotspot` (`JAVA_HOME`) |
| Android SDK (API 36, build-tools 36.0.0, platform-tools, emulator) | `C:\Android\Sdk` (`ANDROID_HOME`) |
| Emulator | AVD `anti_recipes_pixel` (Pixel 7, Android 16, x86_64, Windows Hypervisor Platform acceleration) |

Windows desktop builds need Visual Studio and are not set up; they are not needed.

On a new machine: install Flutter stable, a JDK 17, the Android command-line tools, then run `flutter doctor` and `flutter doctor --android-licenses`. Make sure the shell sees the tools:

```bash
export PATH="/c/src/flutter/bin:$PATH"
```

**Path gotcha.** In Git Bash an unquoted `C:\\Android\\Sdk` loses its backslashes. A previous install wrote 5.6 GB into a stray `AndroidSdk` folder inside the project because of this. Use forward slashes (`/c/Android/Sdk`) or quote the Windows path.

## Everyday commands

```bash
flutter pub get
dart run build_runner build -d      # regenerate drift code after changing tables or DAOs
dart format lib test
flutter analyze
flutter test                        # all 232 tests
flutter test test/features/backup   # a subset
```

Generated `*.g.dart` files are committed. Regenerate and commit them with the change that required it.

### Run on the emulator

```bash
emulator -avd anti_recipes_pixel                       # start it (first boot about 1 minute)
adb devices                                            # wait for "device"
flutter run -d emulator-5554                           # debug run with hot reload
# or build and install by hand:
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am start -n dev.antirecipes.anti_recipes/.MainActivity
adb exec-out screencap -p > shot.png                   # screenshot
```

The first debug launch shows the Flutter splash for about 15 seconds. The first Gradle build downloads a lot and takes several minutes; later builds are much faster.

## Git workflow

- Branch names: `feat/<topic>`, `fix/<topic>`, `docs/<topic>`.
- Commit messages: **Conventional Commits** (`feat(recipes): ...`, `fix(data): ...`, `docs: ...`). **Never add `Co-Authored-By` or any AI attribution.**
- Keep a commit to one reviewable unit with its tests and docs. About 400 authored changed lines (additions plus deletions, generated files excluded) is a planning guide, not a hard cap; never delete comments, blank lines or tests to fit it.
- Do not push or open pull requests unless the owner asks. The owner has asked for pushes of the task branches in the past, but not for pull requests.

### Landing the stacked branches

The MVP branches form a chain (see [current-status.md](current-status.md)). Land them in order:

1. Open a pull request for the first unmerged branch with base `main`. Mention the size and recommend `size:exception` when it exceeds 400 lines.
2. After it merges, retarget the next branch onto `main`. If the merge was a squash, the history differs, so rebase explicitly:

```bash
git fetch origin
git rebase --onto origin/main <old-parent-branch> <next-branch>
git push --force-with-lease origin <next-branch>
```

3. Repeat for each branch until `feat/export-import` lands.

Use the `chained-pr` and `work-unit-commits` skills if your agent has them.

## Writing tests

- Put pure rules in `features/*/domain` and test them with exact numbers. Use fixed dates (2026-10-05 is a Monday).
- Test DAOs with `AppDatabase(NativeDatabase.memory())`. Close the database in `tearDown`.
- Widget tests use helpers in `test/helpers/` (`uiTest`, `pumpWithDb`, `enterKey`, `tapKey`, backup and plan fixtures).

Gotchas that cost hours before:

| Gotcha | What to do |
|--------|------------|
| "A Timer is still pending" after a widget test with a drift stream | Unmount **inside the test body**: `await tester.pumpWidget(const SizedBox()); await tester.pump(const Duration(milliseconds: 10));`. `addTearDown` runs too late. |
| A test hangs forever | You awaited a drift stream (`.first`) inside `testWidgets`. Use `db.select(...).get()` or a DAO `load*` method instead. |
| `flutter test` fails on `sqlite3.dll` | A stuck `flutter_tester.exe` holds the file. Run `taskkill //F //IM flutter_tester.exe`. |
| "Missing definition of main" | A helper file under `test/` ends with `_test.dart`. Rename it (for example `ui_helpers.dart`). |
| Warning about multiple databases | Tests opening two in-memory databases set `driftRuntimeOptions.dontWarnAboutMultipleDatabases = true`. |
| Streams stop refreshing | Two `customSelect(...).watch()` use the same SQL. Give each a distinct SQL string. |
| `StateProvider` does not exist | Riverpod 3 removed it from the main API. Use `NotifierProvider`. `Override` comes from `package:flutter_riverpod/misc.dart`. |
| Analyzer errors inside a `.g.dart` | Part files inherit the parent library's imports. Import enums such as `DayType` and `RecipeKind` in `app_database.dart`. |
| Generic row insert throws a cast error | Use `RawValuesInsertable<Never>`, not `<dynamic>`. |
| `DropdownButtonFormField.value` deprecated | Use `initialValue`. |
| `file_picker` API | In version 13 it is static (`FilePicker.pickFile()`, `FilePicker.saveFile(bytes:)`), not `FilePicker.platform`. |

## Common changes, step by step

### Add a table or column

1. Edit `lib/core/database/tables.dart` and register the table in `AppDatabase`.
2. Bump `schemaVersion` and add the step to `onUpgrade`.
3. Run `dart run build_runner build -d`.
4. Add the table to `lib/features/backup/data/backup_schema.dart` in dependency order. The codec throws if this list and `AppDatabase.allTables` disagree.
5. Extend the rich fixture in `test/helpers/backup_fixtures.dart` so the round-trip test covers the new table.
6. Add or extend `test/core/database/migration_test.dart` for the upgrade path.
7. Update [architecture.md](architecture.md) and [backup-format.md](backup-format.md).

### Add a feature

Create `lib/features/<name>/{domain,data,presentation}`. Put rules in `domain` (no Flutter, drift or Riverpod imports), DAOs in `data`, providers and widgets in `presentation`. Mirror the layout under `test/`.

### Add a stream-based screen

Expose a DAO `watch*` method with its own distinct SQL, wrap it in a provider, and in widget tests use the unmount pattern above.

## Quality bar before saying "done"

1. `dart format lib test` produces no changes.
2. `flutter analyze` reports no issues.
3. `flutter test` passes.
4. Docs updated when behavior, schema or workflow changed.
5. No personal data in the diff (weight, real targets, backups, `*.db`).

## Troubleshooting

- **Emulator does not start:** run `emulator -accel-check`; it must report that WHPX is installed and usable. Virtualization must be enabled in firmware.
- **Gradle fails after an SDK change:** check `flutter doctor -v` for the Android SDK path and accepted licenses.
- **Google Play Services errors in `adb logcat`:** noise from the emulator image, unrelated to the app. Filter with `adb logcat -s flutter`.
