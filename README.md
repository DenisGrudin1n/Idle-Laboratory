# Idle Laboratory

A cross-platform **idle / incremental** game built with Flutter. Progress is driven by energy cells, production, crafting, a research tree, prestige resets, story beats, and a statistics ledger — all persisted locally (no backend).

Primary docs for agents and reviewers:
- This `README.md` — architecture, structure, how to extend features
- [`.cursor/rules/`](.cursor/rules/) — enforceable coding standards (used by Cursor / Bugbot)
- [`ai_docs/Roadmap.md`](ai_docs/Roadmap.md) — shipped features vs TODOs

---

## Table of Contents

- [Tech Stack](#tech-stack)
- [Project Structure Overview](#project-structure-overview)
- [Architecture & Data Flow](#architecture--data-flow)
- [Flutter App (`lib/`)](#flutter-app-lib)
  - [Core Layer (`lib/core/`)](#core-layer-libcore)
  - [Feature Module (`lib/features/home/`)](#feature-module-libfeatureshome)
  - [Responsive Design (`AppLayoutBloc`)](#responsive-design-applayoutbloc)
  - [Localisation (`l10n`)](#localisation-l10n)
  - [Error Handling](#error-handling)
  - [Performance Patterns](#performance-patterns)
  - [Shared Widgets](#shared-widgets)
  - [Routing](#routing)
  - [Theme](#theme)
- [Forms & Paginated Lists (when needed)](#forms--paginated-lists-when-needed)
- [Adding New Features](#adding-new-features)
- [Testing](#testing)
- [Getting Started](#getting-started)

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (SDK `^3.9.2` in `pubspec.yaml`) |
| State management | `flutter_bloc` / BLoC (+ one Cubit for badges) |
| Game / reactive logic | Services + **RxDart** (`BehaviorSubject`, `distinct`, timers) |
| DI | `injectable` + `get_it` |
| Routing | `go_router` (single home route; in-app tabs via `NavigationBloc`) |
| Serialisation | `freezed` + `json_serializable` |
| Local storage | `shared_preferences` via `LocalStorageDataSource` |
| Localisation | Flutter `l10n` (ARB → `AppLocalizations`) |
| Responsive layout | `AppLayoutBloc` + `AppVersionEnum` (no `screen_util`) |
| Large numbers | Custom `BigNumber` + converters |
| Tutorial | `tutorial_coach_mark` |
| Tests | `flutter_test` + `mocktail` |
| Lints | `very_good_analysis` / `flutter_lints` |

**Local-first:** there is no Firebase / Supabase / remote API in this project. Persistence is SharedPreferences only.

**Platforms scaffolded:** Android, iOS, macOS (landscape-oriented).

---

## Project Structure Overview

```
idle_laboratory/
├── lib/
│   ├── main.dart                 # DI bootstrap, orientation, AppLifecycleService
│   ├── app/app_widget.dart       # MultiBlocProvider, theme, router, l10n
│   ├── core/                     # Shared infra (theme, widgets, enums, utils, DI)
│   ├── features/home/            # Game feature (data / domain / presentation)
│   ├── l10n/                     # ARB + generated localisations
│   └── gen/                      # flutter_gen assets
├── test/                         # Unit + widget tests (mirrors lib/)
├── assets/images/                # Cells, materials, story sprites
├── ai_docs/                      # Roadmap & AI notes
├── android/ ios/ macos/          # Native hosts
├── .cursor/rules/                # Cursor / Bugbot project rules
└── pubspec.yaml
```

---

## Architecture & Data Flow

```
UI (widgets)
    │
    ▼
BLoC / Cubit          # Thin: subscribe to streams, map UI state, forward intents
    │
    ▼
Service               # Business logic, timers, RxDart BehaviorSubjects (foo$)
    │
    ▼
Repository            # Persistence only (load / save / clear)
    │
    ▼
LocalStorageDataSource → SharedPreferences
```

### Layer responsibilities

| Layer | Must | Must not |
|---|---|---|
| **Widgets** | Render state, dispatch events, use `BlocSelector` for hot paths | Call repositories / SharedPreferences / own game timers for meta stats |
| **BLoC** | Mirror service streams; short handlers; use `SafeBloc` for stream-driven `add` | Heavy math, multi-stream orchestration, JSON encode/decode |
| **Service** | Game rules, timers, cross-service coordination, emit on streams | UI widgets; ad-hoc prefs keys |
| **Repository** | Persist Freezed models via `guardAsync` + `StorageKeys` | Game balance / progression rules |

**Reference implementations:** `EnergyService` / `EnergyBloc`, `CellsService` / `CellsBloc`, `StatisticsService` / `StatisticsBloc` (incl. `setWatching` + UI throttle).

---

## Flutter App (`lib/`)

### Core Layer (`lib/core/`)

App-wide infrastructure. Prefer extending these folders over inventing new top-level trees.

```
lib/core/
├── bloc/                 # SafeBloc
├── constants/            # GameBalance, GameConstants, StorageKeys, layout metrics
├── converters/           # BigNumber JSON converters
├── debug/                # Rebuild profiler overlay / trackers
├── enums/                # Domain IDs & tabs — enum-only files
├── exceptions/           # GameException + guardAsync
├── extensions/           # Formatters, cell painters, context.l10n, …
├── helper/               # get_it + injectable, SharedPreferencesModule
├── interfaces/           # e.g. IAppLayoutRepository
├── repositories/         # AppLayoutRepository (breakpoints)
├── router/               # AppRouter
├── theme/                # AppTheme, colors, text styles, cell visuals
├── utils/                # BigNumber, research tree/geometry, validators
└── widgets/              # Shared chrome (SectionCard, AppScrollbar, …)
```

**Placement rules**

| Path | Put here |
|---|---|
| `enums/` | Typed catalogs only (no helpers) |
| `extensions/` | Type-attached helpers & display formatters |
| `constants/` | Balance, keys, unit lengths |
| `utils/` | Pure algorithms |

---

### Feature Module (`lib/features/home/`)

Single feature module today (the whole game UI).

```
lib/features/home/
├── data/
│   ├── data_sources/local_storage_data_source.dart
│   └── repositories/          # interfaces + *_impl.dart
├── domain/
│   ├── models/                # Freezed (+ .g.dart when persisted)
│   └── services/              # Energy, Cells, Prestige, Statistics, Storage, Story, Lifecycle
└── presentation/
    ├── screens/cells_screen.dart
    ├── blocs/                 # Per-domain BLoCs (+ StorageBadgeCubit)
    ├── widgets/               # cells / crafting / production / research / storage / statistics / story
    └── controllers/           # Tutorial coach-mark flow
```

**Main services:** `EnergyService`, `CellsService`, `PrestigeService`, `StatisticsService`, `StorageService`, `StoryLoreService`, `AppLifecycleService`.

**Main BLoCs:** `AppLayoutBloc`, `NavigationBloc`, `EnergyBloc`, `CellsBloc`, `PrestigeBloc`, `CraftingBloc`, `StorageBloc`, `StatisticsBloc`, `StoryLoreBloc`, `SettingsBloc`, `StorageBadgeCubit`.

**In-app tabs** (`MainNavigationTab`): cells, crafting, settings, statistics, achievements (placeholder).

---

### Responsive Design (`AppLayoutBloc`)

Do **not** use `flutter_screenutil`. Layout is driven by `AppLayoutBloc` → `AppVersionEnum` (`mobile` | `tablet` | `desk`).

Breakpoints (`GameConstants`):

| Category | Rule |
|---|---|
| Desktop | width `> 1024` |
| Tablet | shortest side `>= 600` |
| Mobile | otherwise |

```dart
BlocSelector<AppLayoutBloc, AppLayoutState, AppVersionEnum>(
  selector: (state) => state.appVersion,
  builder: (context, appVersion) {
    final isMobile = appVersion == AppVersionEnum.mobile;
    // Branch Row vs Column, padding, typography…
  },
)
```

`AppWidget` also applies global text scale: mobile `1.0`, tablet `1.25`, desk `1.5`.

Target **phone + tablet + desktop/macOS** for every new screen.

---

### Localisation (`l10n`)

**No hardcoded user-facing strings.** Use `context.l10n` / `AppLocalizations`.

```dart
// Bad
Text('Submit')

// Good
Text(context.l10n.submit)
```

Source: `lib/l10n/app_en.arb`. After edits:

```bash
flutter gen-l10n
# or rebuild the app (generate: true in pubspec)
```

---

### Error Handling

- Wrap repository (and critical service) I/O in **`guardAsync`** → `GameException`.
- Do not swallow errors with empty `try/catch`.
- Prefer structured constants in `GameErrors` for validation messages where applicable.
- This app is local-first: do **not** introduce direct remote DB clients or assume Edge Functions / RPCs.

---

### Performance Patterns

Idle games tick often (energy ~100ms). Follow existing hot-path patterns:

1. **`BlocSelector`** over broad `BlocBuilder` — rebuild only the fields a widget needs.
2. **Subscribe only when visible** — e.g. `StatisticsBloc` + `StatisticsEvent.setWatching` while the Statistics tab is mounted.
3. **Throttle / coalesce hot streams** — e.g. `StatisticsService` keeps `.current` live but throttles `statistics$` UI emits (`GameBalance.statisticsUiEmitThrottleMs`); use `.distinct()` on streams.
4. **Timers in services**, not widgets — playtime, energy generation, autosave.
5. **Debounced autosave** on hot paths; **immediate flush** on prestige, lifecycle pause (`paused` / `hidden` / `detached`), dispose. Playtime keeps running for `inactive` / `paused` / `hidden` while the process is alive; only end the segment on `detached` / dispose. Wall-clock catch-up on resume covers suspended timers.
6. Prefer **shared** animation scopes (e.g. `CellLoopAnimationScope`) over per-cell controllers when many widgets animate together.
7. Use debug rebuild tools under `lib/core/debug/` when investigating jank.

---

### Shared Widgets

Reusable chrome lives in `lib/core/widgets/`. Prefer these over one-off duplicates:

| Widget | Use for |
|---|---|
| `SectionCard` / `SectionHeader` | Tab section containers |
| `AppBorderContainer` / `AppDivider` | Consistent borders |
| `AppScrollbar` | Scrollable tab bodies |
| `InfoRow` | Label / value rows (statistics, info panels) |
| `ActionButton` | Primary actions |
| `AmountTextField` | Quantity input (crafting) |
| `ProgressBarWidget` | Timed reactions |
| `AppDialog` | Modal dialogs |
| `MagicianSprite` | Story / tutorial character |
| `CachedAssetImage` | Asset images |
| `TopNavigationBar` | Top chrome |

Feature-only widgets stay under `lib/features/home/presentation/widgets/…`.

---

### Routing

`go_router` in `lib/core/router/app_router.dart` — currently a single `/` route to `CellsScreen`. Tab switching is **`NavigationBloc`**, not extra routes. Add routes only when introducing truly separate screens/flows.

---

### Theme

`lib/core/theme/` — `AppTheme`, `AppColor`, `AppTextStyles`, `CellVisualTheme`. Access via theme extensions (`context.color`, `context.styles`).

---

## Forms & Paginated Lists (when needed)

Most game catalogs are **fixed enums** and may render fully. When adding real forms or remote/large lists, adopt these standards (incrementally; no need for a big-bang rewrite):

### Forms

- Prefer `CustomScrollView` + `SliverPadding` + `SliverList.list`.
- Lock inputs with `readOnly: true` while submitting / processing.
- Show status / failure text above the primary button; button exposes loading (`isLoading`).
- Hide validation errors until submit (or explicit invalid state).
- All copy via `context.l10n`.

### Paginated lists

- State: `hasMore` + items list.
- `loadMore` with `offset: state.items.length`; pull-to-refresh resets to 0.
- Bottom scroll detection via `NotificationListener<ScrollNotification>`.
- Inline retry on page failure; skeleton / loader for next page.

---

## Adding New Features

### New persisted game field (e.g. statistic / inventory flag)

1. Extend the Freezed model (+ converters if `BigNumber` / maps).
2. Repository load/save already round-trips JSON — verify keys via `StorageKeys`.
3. Update / create **Service** hooks (record + emit; throttle if hot).
4. Wire BLoC only if UI needs it; prefer `BlocSelector`.
5. Add l10n strings.
6. Tests: JSON round-trip, prestige survival (if lifetime), restart load.

### New service

1. `lib/features/home/domain/services/my_service.dart` — `@lazySingleton`, own streams.
2. Register via injectable; run `build_runner`.
3. Keep BLoC thin; call the service from event handlers.

### New repository

1. Interface under `data/repositories/`.
2. `*_impl.dart` with `guardAsync` + `LocalStorageDataSource`.
3. No game rules inside the impl.

### New UI section / tab content

1. Widget under `presentation/widgets/…`.
2. Drive layout with `AppLayoutBloc`.
3. Use shared chrome; avoid phone-only fixed widths.
4. Hot data → `BlocSelector` / visibility-gated subscriptions.

### Code generation

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

Generates Freezed / json_serializable / injectable config / flutter_gen assets.

> **Generated code is not committed.** `*.g.dart`, `*.freezed.dart` and `*.config.dart` are gitignored, so a fresh clone does not compile until codegen runs.
>
> **Exception: l10n output is committed.** `lib/l10n/app_localizations*.dart` lives in the source tree (no synthetic package) and `generate: true` in `pubspec.yaml` rewrites it on every `pub get` / `run`, so it cannot drift silently. Commit it together with the `.arb` change that produced it.
>
> Any CI job must run the steps in this order:
>
> ```bash
> flutter pub get
> dart run build_runner build --delete-conflicting-outputs
> flutter gen-l10n
> flutter analyze
> flutter test
> ```

---

## Testing

```
test/
├── core/…                         # Formatters, debug helpers
├── helpers/                       # Shared fixtures / harnesses
└── features/home/
    ├── domain/services/…          # Service unit tests
    ├── domain/models/…
    └── presentation/…             # Bloc + widget tests
```

- Prefer **service** tests for game logic and persistence.
- Widget smoke tests for critical tabs (statistics, production, story).
- Use `mocktail` for repositories/services.

```bash
flutter test
# On the ExFAT maintainer machine: fflutter test
```

---

## Getting Started

### Prerequisites

| Tool | Notes |
|---|---|
| Flutter | SDK matching `pubspec.yaml` (`^3.9.2`) |
| Xcode | iOS / macOS |
| Android SDK | Android |
| CocoaPods | iOS / macOS pods when needed |

> Tip: if `flutter` is missing from PATH, use your local FVM default binary (e.g. `~/fvm/default/bin/flutter`) or fix PATH to the SDK.

#### Project on an ExFAT drive (maintainer setup)

The repo lives on an ExFAT external SSD. ExFAT makes macOS create `._*` AppleDouble files (they break `gen-l10n` / `flutter test` with UTF-8 decode errors) and is slow / unreliable for build output. So on that machine, run every `flutter …` command as **`fflutter …`** (`fflutter pub get`, `fflutter gen-l10n`, `fflutter test`, `fflutter run`):

- `fflutter` first runs `fprep`: deletes `._*` files, mounts an APFS sparsebundle at `~/FlutterProjectsBuild/<project>/`, and symlinks `build/`, `ios/Pods`, `ios/Flutter/ephemeral`, `macos/Pods`, `macos/Flutter/ephemeral`, `android/.gradle` into it; then it calls Flutter with auto-retry.
- Scripts and full explanation live next to the project folder: `../fflutter.sh`, `../exfat-prep.sh`, `../_fflutter_smoke_run.sh`, `../README-EXFAT.md`.
- The symlinked dirs are gitignored (`/build`, `**/Pods`, `**/Flutter/ephemeral`); never commit them.
- `pod install` through the symlinked `ios/Pods` (which `fflutter` runs when pods are out of sync) re-adds a second `FileRef` with an absolute `…/FlutterProjectsBuild/…/ios-Pods` path to `ios/Runner.xcworkspace/contents.xcworkspacedata`. On the ExFAT machine this file is expected to stay **locally modified**: leave it as the tooling wrote it and **never stage or commit it**. Only `group:Pods/Pods.xcodeproj` belongs in git. Treat any other tooling-only rewrite of iOS / macOS project files that adds `FlutterProjectsBuild` paths the same way.

On a normal APFS / ext4 checkout plain `flutter` is fine.

### Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# iOS / macOS pods when required
cd ios && pod install && cd ..

flutter run
```

### Useful docs

| Doc | Contents |
|---|---|
| [`ai_docs/Roadmap.md`](ai_docs/Roadmap.md) | Feature checklist & future work |
| [`.cursor/rules/`](.cursor/rules/) | Agent & code-review rules |
