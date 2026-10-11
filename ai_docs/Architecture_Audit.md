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
- [ ] `2-core` — `lib/core/`
- [ ] `3-data` — repositories + `LocalStorageDataSource`
- [ ] `4-domain` — domain models + services
- [ ] `5-blocs` — presentation BLoCs / Cubits
- [ ] `6-ui-cells` — cells / production / energy / prestige UI + `CellsScreen`
- [ ] `7-ui-crafting` — crafting / research / storage UI
- [ ] `8-ui-meta` — statistics / story / settings / misc chrome

## Coverage

**Reviewed:** `1-bootstrap`  
**Left:** `2-core`, `3-data`, `4-domain`, `5-blocs`, `6-ui-cells`, `7-ui-crafting`, `8-ui-meta`

## Findings

### Phase 1-bootstrap — Bootstrap (main + AppWidget)

#### Critical Architectural Breaches

- None.

#### Refactoring Options

- `lib/main.dart`: `getIt<AppLifecycleService>()` is a silent side-effect resolve to construct the lifecycle observer. Prefer an explicit named call (e.g. assign to a local, or `AppLifecycleService.ensureRegistered()` / document in a one-line comment) so bootstrap intent is obvious and not mistaken for dead code.
- `lib/app/app_widget.dart`: `EnergyBloc` / `CellsBloc` / `PrestigeBloc` call `.start()` at app root (always-on stream subscriptions). Acceptable if they feed persistent chrome (energy header, prestige, cells shell); confirm in phases `5-blocs` / `6-ui-cells` that nothing here is tab-only work that should use a `setWatching`-style gate. `StatisticsBloc` / `CraftingBloc` correctly stay inert until UI mounts — keep that split.
- `lib/app/app_widget.dart`: root `MultiBlocProvider` lists every game BLoC for the single home feature. Fine today; if more features appear, consider shell vs route/tab-scoped providers so unused domains are not constructed for the whole process lifetime.

#### Notes

- Slice is only `main.dart` + `AppWidget`: DI via GetIt, no SharedPreferences/repos in UI, landscape lock + l10n + `AppLayoutBloc` text scale + `CellLoopAnimationScope` all align with documented patterns. Deeper stream/timer/lifecycle behaviour belongs in later phases.
