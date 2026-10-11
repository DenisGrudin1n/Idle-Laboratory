# Architecture Audit (whole codebase)

Phased review using `./review_codebase.sh <PHASE>` (same rules as `review_pr.sh`, but for `lib/` slices).

Branch: `code-refactoring`  
Started: 2026-10-11

## How to run

```bash
./review_codebase.sh --list
./review_codebase.sh 1-bootstrap   # paste into Cursor Agent
# …then 2-core, 3-data, …
```

Each Agent run must append findings below and tick the phase when finished.

## Checklist

- [x] `1-bootstrap` — main.dart + `lib/app/` _(2026-10-11)_
- [x] `2-core` — `lib/core/` _(2026-10-11)_
- [ ] `3-data` — repositories + `LocalStorageDataSource`
- [ ] `4-domain` — domain models + services
- [ ] `5-blocs` — presentation BLoCs / Cubits
- [ ] `6-ui-cells` — cells / production / energy / prestige UI + `CellsScreen`
- [ ] `7-ui-crafting` — crafting / research / storage UI
- [ ] `8-ui-meta` — statistics / story / settings / misc chrome

## Coverage

**Reviewed:** `1-bootstrap`, `2-core`  
**Left:** `3-data`, `4-domain`, `5-blocs`, `6-ui-cells`, `7-ui-crafting`, `8-ui-meta`

## Findings

### Phase 1-bootstrap — Bootstrap (main + AppWidget)

#### Critical Architectural Breaches

- None.

#### Refactoring Options

- ~~`lib/main.dart`: silent `getIt<AppLifecycleService>()`~~ **Fixed** — `registerAppLifecycleObserver()` makes bootstrap intent explicit; home route wired via `AppRouter.configure` from `main`.
- ~~`EnergyBloc` / `CellsBloc` / `PrestigeBloc` `.start()` at root~~ **Documented** in `AppWidget` (always-on chrome vs tab-scoped inert blocs). Re-confirm stream scope in phases `5-blocs` / `6-ui-cells` if needed.
- `lib/app/app_widget.dart`: root `MultiBlocProvider` lists every game BLoC for the single home feature. Fine today; if more features appear, consider shell vs route/tab-scoped providers so unused domains are not constructed for the whole process lifetime.

#### Notes

- Slice is only `main.dart` + `AppWidget`: DI via GetIt, no SharedPreferences/repos in UI, landscape lock + l10n + `AppLayoutBloc` text scale + `CellLoopAnimationScope` all align with documented patterns. Deeper stream/timer/lifecycle behaviour belongs in later phases.

### Phase 2-core — Core (lib/core)

#### Critical Architectural Breaches

- ~~**Core widgets → feature presentation**~~ **Fixed** — `AppLayoutBloc` lives in `lib/core/bloc/app_layout/`; core widgets import that path. `TopNavigationBar` takes optional `sectionKey` (tutorial key supplied by feature callers).

- ~~**`enums/` not enum-only**~~ **Fixed** — display/`IconData` moved to `extensions/*_l10n_ext.dart` / `main_navigation_tab_ext.dart`; removed unused `Localized` interface.

- **Core helpers may import home models (documented).** Project rule: do **not** put `constants/` / `extensions/` / `utils/` under `lib/features/*/`. Keep them in `lib/core/` (e.g. `cell_model_ext`, `cell_level_constants`, `validators` with `GameErrors` codes). Single-feature tradeoff until a multi-feature split moves models or splits helpers.

#### Refactoring Options

- ~~`AppRouter` hard-wires `CellsScreen`~~ **Fixed** — `AppRouter.configure(homeBuilder: …)` from `main.dart`.
- ~~`GameValidators` English strings~~ **Fixed** — `GameErrors` codes only.
- Folded `CellEnergyPerSecond` into `GameBalance` calls on `CellModelExt`.
- Debug overlay `RebuildProfilerOverlay` uses a widget `Timer` — fine under `lib/core/debug/`; do not copy that pattern for game meta stats.

#### Notes

- Compliant / keep: `StorageKeys`, `PersistenceLabels`, `guardAsync` / `fireAndForget`, converters, `GameBalance`, `SafeBloc` (+ `AppLayoutBloc` now extends it), `CellLoopAnimationScope`, breakpoints via `GameConstants` + `AppLayoutRepository`.
- DI config (`get_it_service_locator.config.dart`) still imports feature services/blocs — expected for injectable registration, not a widget/domain layering break.
