# Flutter Rules — BodyMetrics Project

Rules specifically tailored for the **body-metrics** codebase. All conventions described here reflect what is already implemented — follow these patterns when adding or modifying code.

---

## Project Architecture

### Clean Architecture + Feature-First

```
lib/
├── core/       # Shared infrastructure (router, theme, widgets, extensions, constants, base classes)
├── data/       # SQLite cache implementations (UserCache, UserMetricsCache, AppCache) + DB init
├── domain/     # Global entities, use-case contracts, repository implementations
├── feature/    # Feature modules — each owns its presentation layer (+ optional domain)
└── injection/  # GetIt + Injectable DI (locator.dart, locator.config.dart)
```

**Rules:**
- Every new feature lives in `lib/feature/<feature_name>/presentation/`
- Business logic (calculation, validation) belongs in a `UseCase`, not in a Cubit or widget
- Data access always goes through a `Cache` class — never call sqflite directly from a Cubit
- Shared utilities live in `lib/core/`; never duplicate them inside a feature

---

## State Management — BLoC/Cubit

### Cubit for simple state, BLoC for complex event flows

```dart
@injectable
class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit(this._calculateBmiUseCase, this._saveWeightUseCase)
      : super(const WeightPickerInitial());
}
```

**State class conventions:**
- Extend `Equatable`, always override `props`
- Name states: `<Feature>Initial`, `<Feature>Loading`, `<Feature>Success(<data>)`, `<Feature>Error(<message>)`
- Keep states immutable — use `copyWith` pattern if mutation needed

```dart
// States file pattern
part of 'weight_picker_cubit.dart';

sealed class WeightPickerState extends Equatable {
  const WeightPickerState();
}

final class WeightPickerInitial extends WeightPickerState {
  const WeightPickerInitial([this.user]);
  final User? user;
  @override List<Object?> get props => [user];
}
```

**UI binding:**
- Use `BlocBuilder` for rebuild-on-state, `BlocListener` for side effects
- Use `MultiBlocProvider` when a screen needs multiple cubits
- Always handle loading + error + success states in the UI

---

## Dependency Injection — GetIt + Injectable

```dart
@injectable        // Factory — use for Cubits (new instance per request)
@lazySingleton     // Singleton — use for Caches, Repositories, UseCases, Router, Theme

// Resolution anywhere in the app:
Locator.sl<SomeUseCase>()
```

**Rules:**
- Every Cubit must be `@injectable` (factory)
- Every Cache/Repository/Service must be `@lazySingleton`
- After adding/modifying any annotation, run:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- Never instantiate dependencies manually — always resolve via `Locator.sl<>()`

---

## Database & Cache — sqflite

### BaseCache implementation pattern

```dart
@lazySingleton
class UserMetricsCache extends ImpCache
    implements BaseCache<UserMetrics, Json, Json, UserMetrics> {

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_metrics (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id     INTEGER NOT NULL REFERENCES user(id),
        weight      REAL,
        height      INTEGER NOT NULL,
        bmi         REAL NOT NULL,
        weight_diff REAL,
        body_metric TEXT,
        date        TEXT NOT NULL,
        created_at  TEXT
      )
    ''');
    // Migrations: always idempotent
    await _migrate(db);
  }
}
```

**Rules:**
- Column names defined as string constants in a `*_columns.dart` file
- Migrations use `PRAGMA table_info` + `ALTER TABLE` — never drop/recreate tables
- Always use `created_at` (ISO8601) as the canonical sort key; `date` is legacy
- Read order must be `ORDER BY created_at ASC, id ASC`
- Use foreign key constraints between tables
- Use `@JsonKey(name: 'snake_case')` when model field name differs from DB column name

---

## Navigation — auto_route

```dart
@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashView.page, initial: true),
    AutoRoute(page: OnboardView.page),
    AutoRoute(page: AvatarPickerView.page),
    AutoRoute(page: UserGeneralInfoView.page),
    AutoRoute(page: GenderView.page),
    AutoRoute(page: HeightView.page),
    AutoRoute(page: WeightView.page),
    AutoRoute(page: HomeView.page),
  ];
}
```

**Rules:**
- Use `auto_route` only — do not use go_router or Navigator.push directly
- Route file is `lib/core/router/app_router.dart`; generated file is `app_router.gr.dart` (never edit)
- Track the last visited page by saving a `Pages` enum value via `SaveAppUseCase`
- Use `SaveAppMixin.saveApp(Pages page)` for consistent page persistence across features

---

## Theme & UI

### CustomTheme (Material 3, Dark)

```dart
@lazySingleton
class CustomTheme implements BaseTheme {
  @override
  ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple,
    // Custom overrides in cardTheme, dialogTheme, appBarTheme...
  );
}
```

**Rules:**
- Primary color: `#673AB7` (deep purple) — use `ProductColor.deepPurple`
- Background gradient: `#6A1B9A → #9747FF` — always wrap screens in `GradientScaffold`
- Never hardcode colors — use `ProductColor`, `context.colorScheme`, or `context.theme`
- Use `ProductPadding`, `ProductRadius`, `SpaceValues` for consistent spacing
- Card border radius: 15px (`ProductRadius.fifTeen()`)
- Input border radius: 10px

### Standard widgets to reuse

| Widget | Where |
|--------|-------|
| `GradientScaffold` | All screen backgrounds |
| `CustomAppBar` | All screens with app bars |
| `CustomTextField` | All text inputs |
| `CustomFilled` | Primary action buttons |
| `ChipButton` | Secondary/toggle buttons |
| `LottieDialog` | Error/success dialogs |
| `LottieConfirmDialog` | Destructive action confirmation |
| `LoadingLottie` | Loading states |
| `SpaceColumn` | Vertically spaced widget lists |
| `HomeCard` | Metric summary cards |
| `LineCharts` | BMI/metric trend charts |

---

## Localization — easy_localization

```dart
// Always use LocaleKeys, never hardcode strings
Text(LocaleKeys.weight_title.tr())
```

**Rules:**
- All UI text must use `LocaleKeys.<namespace>_<key>.tr()`
- Add new keys to both `assets/language/tr.json` and `assets/language/en.json`
- Namespace convention: `onboard_*`, `register_*`, `weight_*`, `height_*`, `gender_*`, `dialog_*`, `exception_*`, `bmi_result_*`
- Error messages emitted from Cubits must reference `LocaleKeys` strings (not raw strings)

---

## Error Handling

```dart
try {
  final result = await _useCase.executeWithParams(params: params);
  emit(FeatureSuccess(result));
} catch (e, st) {
  'FeatureCubit error: $e\n$st'.e();
  emit(FeatureError(LocaleKeys.exception_generic_error));
}
```

**Rules:**
- Use `.log()` for info, `.w()` for warnings, `.e()` for errors (Logger extensions)
- Always emit a localized error state — never let an exception bubble to the widget silently
- Use `DialogUtil` mixin for displaying errors: `showLottieError(context, message)`
- Validate inputs (weight, height, name) before business logic — emit error state on invalid input

---

## Models & Entities

### Model conventions

```dart
@JsonSerializable()
class UserMetric extends Equatable implements BaseModel<UserMetric> {
  const UserMetric({this.id, this.bmi, ...});

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  UserMetric copyWith({String? createdAt, ...}) => UserMetric(createdAt: createdAt ?? this.createdAt, ...);

  factory UserMetric.fromJson(Json json) => _$UserMetricFromJson(json);
  Json toJson() => _$UserMetricToJson(this);

  @override
  List<Object?> get props => [id, bmi, createdAt, ...];
}
```

**Rules:**
- All models extend `Equatable` and implement `BaseModel<T>`
- Use `@JsonKey(name: 'snake_case')` for any field whose DB column differs from the Dart name
- Always provide `copyWith` for immutable updates
- Wrapper models (`Users`, `UserMetrics`) wrap `List<Model>?`
- After modifying a model, run `build_runner` to regenerate `.g.dart`

---

## Code Generation

```bash
# Run after: model changes, new routes, new @injectable/@lazySingleton
dart run build_runner build --delete-conflicting-outputs
```

Generated files (commit these, never edit manually):
- `*.g.dart` — json_serializable output
- `*.gr.dart` — auto_route output
- `lib/injection/locator.config.dart` — injectable output

---

## BMI / Health Metric Logic

```dart
// Formula
double bmi = weight / (heightInMeters * heightInMeters);
bmi = double.parse(bmi.toStringAsFixed(2)); // Always 2 decimal places

// Classification (BodyMetricResult enum)
// < 18.5   → underweight
// 18.5–25  → normal
// 25–30    → overweight
// 30–40    → obese
// ≥ 40     → morbidlyObese
```

**Rules:**
- BMI calculation must stay in `CalculateBmiUseCase`, not in the Cubit or widget
- Weight diff is always relative to the previous stored measurement for the same user
- `body_metric` column stores the `BodyMetricResult` enum `.name` string
- Input validation: weight and height must be positive non-zero numbers

---

## Chart Visualization — fl_chart

```dart
// Spots: X = measurement index, Y = BMI value
final spots = metrics.asMap().entries.map((e) {
  return FlSpot(e.key.toDouble(), e.value.bmi ?? 0);
}).toList();
```

**Rules:**
- Use `LineCharts` widget in `lib/core/widgets/charts/line_charts.dart` — do not build fl_chart directly in feature widgets
- X-axis: sequential index (every 2 points for readability)
- Y-axis: unique BMI values, left titles
- Bottom titles: `dd/MM` format from `created_at` (fallback to sequential number)
- Keep chart data computation out of the widget — prepare `FlSpot` list in the Cubit or a helper

---

## Testing

```dart
group('WeightPickerCubit', () {
  late WeightPickerCubit cubit;

  setUp(() {
    cubit = WeightPickerCubit(FakeCalculateBmiUseCase(), FakeSaveWeightUseCase());
  });

  blocTest<WeightPickerCubit, WeightPickerState>(
    'emits Success after valid saveBodyMetrics call',
    build: () => cubit,
    act: (c) => c.saveBodyMetrics(weight: 75.0),
    expect: () => [isA<WeightPickerLoading>(), isA<WeightPickerSuccess>()],
  );
});
```

**Rules:**
- Use `bloc_test` package for all Cubit tests
- Use `FakeUseCase` stubs (simple manual fakes), not Mockito where already established
- Every new UseCase must have a unit test
- Every new Cubit must have a test covering: initial state, success path, error path
- Test files live under `test/feature/<feature_name>/`

---

## Performance

- Use `const` constructors on all widgets where possible
- Memoize or cache heavy computations (e.g., FlSpot list generation)
- Use `UserMetricsCache` indexes; order queries use `created_at ASC, id ASC`
- Implement lazy loading for long metrics lists
- Avoid rebuilding the whole chart on unrelated state changes — scope `BlocBuilder` tightly
- Use `Equatable` on all states to prevent unnecessary rebuilds

---

## Security & Data Integrity

- Validate weight (> 0, ≤ 500 kg) and height (65–252 cm) before persisting
- Sanitize all user inputs before inserting into SQLite
- Do not log sensitive health data (weight, BMI) at info level in production builds
- Use parameterized queries — never string-concatenate SQL

---

## Code Quality — very_good_analysis

Active lint rules (enforced, see `analysis_options.yaml`):
- No public members without docs → disabled for this project
- Lines ≤ 80 chars → disabled for this project
- `library_private_types_in_public_api` → disabled

**Follow Effective Dart guidelines:**
- Prefer `final` over `var`
- Use `late` only when initialization is guaranteed
- Prefer named parameters for clarity
- Use pattern matching (`switch` expressions) for enum handling
- Avoid dynamic types; prefer explicit generics

---

## Package Reference

| Package | Version | Usage |
|---------|---------|-------|
| flutter_bloc | 9.1.1 | BLoC/Cubit state management |
| auto_route | 10.1.2 | Type-safe navigation |
| injectable | 2.5.1 | DI annotations |
| get_it | — | Service locator (via injectable) |
| sqflite | 2.4.2 | Local SQLite database |
| easy_localization | 3.0.8 | i18n (tr + en) |
| fl_chart | 1.1.1 | BMI/metric trend charts |
| flutter_zoom_drawer | 3.2.0 | Home navigation drawer |
| lottie | 3.3.2 | Animated feedback (loading, success, error) |
| introduction_screen | 4.0.0 | Onboarding flow |
| font_awesome_flutter | 10.12.0 | Icon library |
| json_annotation | 4.9.0 | JSON serialization |
| equatable | 2.0.7 | Value equality for states/models |
| logger | 2.6.1 | Structured logging |
| very_good_analysis | 10.0.0 | Lint rules |
