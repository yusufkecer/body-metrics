# CLAUDE.md — BodyMetrics Project

> This file is auto-read by Claude Code at session start. It provides AI agents with everything needed to understand, navigate, and contribute to this repository.

---

## 1) Project Goal

Health metrics tracking app (Flutter):
- User onboards → picks avatar, enters name/gender/height
- Enters weight → BMI automatically calculated and stored
- Home screen shows historical measurements as cards and charts

---

## 2) Architecture

**Stack:** Flutter + BLoC/Cubit + Clean Architecture + sqflite + auto_route + injectable/get_it

```
lib/
├── core/          # Shared infrastructure (router, theme, widgets, extensions, constants)
├── data/          # SQLite cache implementations, DB init
├── domain/        # Global entities, use cases, repository contracts
├── feature/       # Feature-based modules (each has presentation + optional domain)
│   ├── splash/
│   ├── onboard/
│   ├── avatar_picker/
│   ├── user_general_info/
│   ├── gender/
│   ├── height/
│   ├── weight_picker/
│   └── home/
└── injection/     # GetIt + Injectable DI setup (locator.dart, locator.config.dart)
```

**Layers (per feature):**
- `presentation/` → View + Cubit + State
- `domain/` → UseCase + Repository (abstract)
- `data/` (in `lib/data/`) → Cache implementations (sqflite)

---

## 3) Navigation Flow

Routes defined in `lib/core/router/app_router.dart` (auto_route):

```
SplashView → OnboardView → AvatarPickerView → UserGeneralInfoView
          → GenderView → HeightView → WeightView → HomeView
```

Splash reads `AppModel.page` (enum `Pages`) and `AppModel.isCompleteOnboard` to decide which screen to show.

`Pages` enum values: `onboardPage, avatarPage, userGeneralInfo, genderPage, heightPage, weightPage, homePage`

---

## 4) Critical File Map

### App startup
| File | Role |
|------|------|
| `lib/main.dart` | Entry: `InitApp.init()` → `runApp` |
| `lib/core/init/app_init.dart` | WidgetsFlutterBinding + DB + DI init |
| `lib/feature/splash/presentation/splash.dart` | Reads AppModel → routes user |
| `lib/feature/splash/presentation/splash_model.dart` | Page switch logic |
| `lib/core/router/app_router.dart` | Route definitions |
| `lib/core/router/app_router.gr.dart` | Generated routes (do not edit) |

### State & user session
| File | Role |
|------|------|
| `lib/core/util/models/app_model/app_model.dart` | App-wide state: lastPage, activeUser, isCompleteOnboard |
| `lib/core/util/models/user/user.dart` | User entity (id, name, surname, avatar, gender, height, birthOfDate) |
| `lib/core/util/constants/app_util.dart` | Static: `currentUserId`, `lastPage`, `databaseVersion` |
| `lib/domain/use_case/save_app_use_case.dart` | Persist AppModel to AppCache |
| `lib/domain/use_case/set_id_use_case.dart` | Set AppUtil.currentUserId |

### BMI / metrics calculation & persistence
| File | Role |
|------|------|
| `lib/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart` | Main orchestrator |
| `lib/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart` | BMI formula: `weight / (height_m²)` |
| `lib/feature/weight_picker/domain/use_case/save_weight_use_case.dart` | Calls SaveWeightRepository |
| `lib/feature/weight_picker/domain/repository/save_weight_repository.dart` | Abstract contract |

### Metric model & cache
| File | Role |
|------|------|
| `lib/core/util/models/user_metrics/user_metric.dart` | UserMetric model (see schema below) |
| `lib/core/util/models/user_metrics/user_metric.g.dart` | Generated JSON serialization |
| `lib/core/util/models/user_metrics/user_metrics.dart` | `UserMetrics` wrapper (List<UserMetric>) |
| `lib/data/cache/user_metrics_cache/user_metrics_cache.dart` | SQLite CRUD |
| `lib/data/cache/user_metrics_cache/user_metrics_columns.dart` | Column name constants |

### Home screen
| File | Role |
|------|------|
| `lib/feature/home/presentation/home.dart` | Main home widget, zoom drawer |
| `lib/feature/home/presentation/widgets/data_list.dart` | Cards list |
| `lib/core/widgets/charts/line_charts.dart` | fl_chart line chart |
| `lib/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart` | Loads metric history |
| `lib/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart` | Toggle list/chart |
| `lib/feature/home/presentation/cubit/user_cubit/user_cubit.dart` | Loads user profile |

### Profile onboarding
| File | Role |
|------|------|
| `lib/feature/avatar_picker/presentation/` | Avatar grid (pr1-pr6) |
| `lib/feature/user_general_info/` | Name, surname, birthdate form |
| `lib/feature/gender/` | Male/female selection |
| `lib/feature/height/` | Ruler-based height picker (65–252 cm) |

---

## 5) Database Schema

**File:** `lib/data/cache/user_metrics_cache/user_metrics_cache.dart`
**DB path:** `body_metrics.db` (version 1, with ALTER TABLE migrations)

### `user` table
```sql
CREATE TABLE user (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  name          TEXT,
  surname       TEXT,
  gender        INTEGER,   -- 0=male, 1=female (GenderValue enum index)
  avatar        TEXT,      -- asset path e.g. 'pr1'
  height        INTEGER,   -- cm
  birth_of_date TEXT
)
```

### `user_metrics` table
```sql
CREATE TABLE user_metrics (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  date        TEXT NOT NULL,   -- dd-MM-yyyy (display label, legacy)
  weight      REAL,
  height      INTEGER NOT NULL,
  user_id     INTEGER NOT NULL REFERENCES user(id),
  bmi         REAL NOT NULL,
  weight_diff REAL,            -- delta from previous measurement
  body_metric TEXT,            -- BodyMetricResult enum name
  created_at  TEXT             -- ISO8601, canonical timestamp
)
```

**Read order:** `created_at ASC, id ASC`

**Migrations (idempotent):** use `PRAGMA table_info` + `ALTER TABLE` to add new columns.

### `app_cache` table
Stores: `is_complete_onboard`, `active_user`, `page` (current Pages enum value)

---

## 6) Key Business Logic

### BMI Calculation
```dart
// lib/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart
double bmi = weight / (heightInMeters * heightInMeters);
bmi = double.parse(bmi.toStringAsFixed(2));
```

### BMI Classification (BodyMetricResult enum)
| Range | Result |
|-------|--------|
| < 18.5 | underweight |
| 18.5 – 25 | normal |
| 25 – 30 | overweight |
| 30 – 40 | obese |
| ≥ 40 | morbidlyObese |

### Height Picker Formula
```dart
// Position on ruler → height in cm
double height = ((position * 2) * (maxValue - minValue)) / 233;
// Range: 65–252 cm
```

### WeightPickerCubit.saveBodyMetrics flow
1. Validate user + height exist
2. `CalculateBmiUseCase` → `double bmi`
3. `_resolveBodyMetricResult(bmi)` → `BodyMetricResult`
4. Build `UserMetric` (weight, bmi, body_metric, weight_diff, height, created_at)
5. `SaveWeightUseCase` → `UserMetricsCache.insert`

---

## 7) State Management

All Cubits registered via `@injectable`. Pattern:

```dart
@injectable
class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit(this._useCase) : super(const FeatureInitial());
}
```

### Home Cubits
| Cubit | States |
|-------|--------|
| `UserCubit` | UserLoading, UserLoaded(user), UserError(message) |
| `UserMetricCubit` | UserMetricInitial, UserMetricLoading, UserMetricSuccess(userMetric), UserMetricError(error) |
| `HomeCardCubit` | HomeCardInitial, HomeCardLoaded(expandedCard, shouldAnimateList, shouldAnimateChart) |

`ExpandedCard` enum: `none`, `list`, `chart`

### Weight Picker States
`WeightPickerInitial(user)` → `WeightPickerLoading` → `WeightPickerSuccess(user)` / `WeightPickerError(error)`

### Gender States
`GenderInitial` → `GenderSelected(genderValue)` / `GenderError(message, genderValue)`

---

## 8) Dependency Injection

```dart
// Resolve anywhere:
Locator.sl<SomeUseCase>()

// Register:
@injectable        // factory — for Cubits
@lazySingleton     // singleton — for Services, Caches, Router, Theme

// After changes: run code generation
dart run build_runner build --delete-conflicting-outputs
```

---

## 9) Models

All models use `@JsonSerializable` + `Equatable`. Generated files: `*.g.dart`.

```dart
// User
class User extends Equatable {
  final int? id;
  final String? name, surname, avatar;
  final GenderValue? gender;
  final int? height;
  final String? birthOfDate;
}

// UserMetric
class UserMetric extends Equatable {
  final int? id;
  @JsonKey(name: 'user_id') final int? userId;
  final String? date;            // dd-MM-yyyy
  final double? weight;
  final double? bmi;
  @JsonKey(name: 'weight_diff') final double? weightDiff;
  @JsonKey(name: 'body_metric') final BodyMetricResult? userMetric;
  final int? height;
  @JsonKey(name: 'created_at') final String? createdAt;  // ISO8601
}

// AppModel
class AppModel extends Equatable {
  final Pages? page;
  @JsonKey(name: 'is_complete_onboard') final bool? isCompleteOnboard;
  @JsonKey(name: 'active_user') final int? activeUser;
}
```

---

## 10) Core Utilities

### Extensions (`lib/core/extensions/`)
- **String:** `.toYMD` (dd/MM/yyyy→yyyy-MM-dd), `.isValidNumber`, `.toGenderValue`
- **Context:** `.theme`, `.textTheme`, `.colorScheme`, `.width`, `.height`, `.unfocus()`
- **Check:** `.isNullOrEmpty`, `.isNotNull`, `.isNull`, `.convertBoolResult`
- **Logger:** `.log()` (info), `.w()` (warn), `.e()` (error)

### Mixins (`lib/core/mixin/`)
- **SaveAppMixin:** `saveApp(Pages)` → persists current page to AppCache
- **DialogUtil:** `showLottieError()`, `showLottieConfirm()` — Lottie-animated dialogs
- **TitleMixin:** Home screen title based on expanded card section

### Constants
- **ProductColor:** deepPurple (#673AB7), gradient colors, animated list colors
- **ProductPadding:** xxs(4), xs(8), s(10), fifTeen(15)
- **ProductRadius:** ten(), fifTeen(), twentyFive()…
- **SpaceValues:** xxs, xs, s, m, l
- **AssetValue enum:** all asset paths (profiles pr1–pr6, onboards ob1–ob5, lotties)
- **AppUtil:** `currentUserId`, `lastPage`, `appName = 'BodyMetrics'`, `databasePath`

### Base Classes (`lib/core/base/`)
```dart
abstract interface class UseCase<OUT, IN> {
  Future<OUT?> executeWithParams({IN? params});
}
abstract interface class Repository<OUT, IN> {
  Future<OUT?> executeWithParams({IN params});
}
// BaseCache<T, U, V, W>: insert, update, delete, select, selectAll, initializeTable
```

---

## 11) Theme & UI

- **Material 3** dark theme, seed: `Colors.deepPurple`
- **Primary color:** #673AB7 (deep purple)
- **Gradient background:** #6A1B9A → #9747FF (`GradientScaffold` widget)
- Custom styling: AppBar (centered, no elevation), cards (15px radius), dialogs (deep purple bg)

### Core Widgets
| Widget | Purpose |
|--------|---------|
| `GradientScaffold` | Scaffold with purple gradient bg |
| `CustomAppBar` | Reusable app bar |
| `CustomDrawer` | Zoom-effect navigation drawer |
| `CustomTextField` | Styled input with validation |
| `CustomFilled` / `ChipButton` | Buttons |
| `HomeCard` | Metric card |
| `LineCharts` | fl_chart wrapper |
| `LottieDialog` / `LottieConfirmDialog` | Animated dialogs |
| `LoadingLottie` | Loading indicator |
| `SpaceColumn` | Auto-spaced column |
| `BlocWrapper` | BlocProvider helper |

---

## 12) Localization

- **Package:** easy_localization
- **Languages:** Turkish (`tr`), English (`en`)
- **Files:** `assets/language/tr.json`, `assets/language/en.json`
- **Usage:** `Text(LocaleKeys.some_key.tr())`
- **Key namespaces:** `onboard_*`, `register_*`, `weight_*`, `height_*`, `gender_*`, `dialog_*`, `exception_*`, `bmi_result_*`

---

## 13) Assets

```
assets/
├── app_logo/app_logo.png
├── images/
│   ├── profiles/pr1.png – pr6.png   (user avatars)
│   ├── onboard/ob1.png – ob5.png   (onboarding images)
│   ├── male_body.svg
│   └── female_body.svg
├── lotties/                          (male.json, female.json, loading, success, error, confirm…)
├── language/tr.json, en.json
└── countries/
```

---

## 14) Code Generation

Run after any model, route, or DI annotation change:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files (committed, do not edit manually):
- `*.g.dart` — json_serializable
- `*.gr.dart` — auto_route
- `locator.config.dart` — injectable

---

## 15) Testing

```
test/
├── feature/
│   └── onboard/
│       ├── onboard_cubit_test.dart
│       └── onboard_use_case_test.dart
└── widget_test.dart
```

Pattern:
```dart
blocTest<OnboardCubit, OnboardState>(
  'description',
  build: () => OnboardCubit(FakeUseCase()),
  act: (cubit) => cubit.someMethod(),
  expect: () => [SomeState()],
);
```

- Use `bloc_test` for Cubits
- Use `FakeUseCase` stubs (not Mockito) where already established
- Test error paths alongside happy paths

---

## 16) Quick Debug Guide

### "BMI calculated correctly but Home shows wrong value"
1. `weight_picker_cubit.dart` → `saveBodyMetrics` — check `UserMetric` construction
2. `user_metrics_cache.dart` → check `insert` / `select` / orderBy (`created_at ASC, id ASC`)
3. `home.dart` + `data_list.dart` → check date/label fallback logic

### "Profile switching shows wrong profile"
1. `avatar_picker_model.dart` → index→userId resolution
2. `SetIdUseCase` + `AppModel(activeUser)` update flow

### "Page navigation flow broken"
1. `splash_model.dart` → `Pages` switch logic
2. `SaveAppUseCase` → last page persistence check

### "Database migration issue"
1. `user_metrics_cache.dart` → `initializeTable` migration section
2. Check `PRAGMA table_info` + `ALTER TABLE` idempotency

### "DI resolution error"
1. Run `build_runner` to regenerate `locator.config.dart`
2. Verify `@injectable` / `@lazySingleton` annotation is present
3. Check constructor parameter types match registered types

---

## 17) Development Principles

1. Define new features at **Domain contract level first** (abstract repository + use case interface), then implement Data → Presentation.
2. Keep **formatting/computation out of UI**; put in use cases or services.
3. DB migrations must be **centralized and idempotent** (`PRAGMA table_info` + `ALTER TABLE`).
4. Use **`created_at`** as canonical timestamp; `date` field is legacy display only.
5. All UI text goes through **LocaleKeys** (never hardcode strings).
6. Use **const constructors** on all widgets where possible.
7. Every new Cubit/UseCase/Repository must be **registered in DI** and **regenerated**.
8. Log errors with `.e()` extension; emit localized error states for UI.
