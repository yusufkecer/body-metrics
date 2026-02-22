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
- `*.gr.dart` — auto_route output (**never create or edit by hand; always regenerate via build_runner**)
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

## REST API Integration — Dio

### Architecture

```
lib/data/api/
├── api_client.dart                    # Dio singleton (@lazySingleton)
├── api_constants.dart                 # Base URL, timeouts, API key
├── error/
│   └── api_exception.dart             # DioException → user-friendly ApiException
├── interceptors/
│   ├── auth_interceptor.dart          # Bearer token injection + 401 handling
│   └── logging_interceptor.dart       # HTTP lifecycle logging
└── services/
    ├── auth_service.dart              # register, login, hasSession, logoutLocal
    ├── user_api_service.dart          # User CRUD
    └── metrics_api_service.dart       # Metrics CRUD
```

### API Client Setup

```dart
@lazySingleton
final class ApiClient {
  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,     // http://10.0.2.2:8080/api/v1
      connectTimeout: ApiConstants.connectTimeout,  // 15s
      receiveTimeout: ApiConstants.receiveTimeout,  // 15s
      headers: {
        'Content-Type': 'application/json',
        if (ApiConstants.apiKey.isNotEmpty)
          'X-API-Key': ApiConstants.apiKey,         // App-level auth
      },
    ));
    _dio.interceptors.addAll([
      AuthInterceptor(),   // JWT token injection
      LoggingInterceptor(),
    ]);
  }
}
```

### Two-Layer Security

**Layer 1 — API Key (App-Level):**
- Prevents unauthorized clients from accessing the backend
- Stored in `.env` file at project root (never committed — in `.gitignore`)
- Read via `envied` package (`Env.apiKey`) — XOR-obfuscated at code generation time
- Key is NOT plaintext in binary; appears as two integer arrays XOR'd at runtime
- Sent as `X-API-Key` header on every request via `ApiClient` default headers
- Backend validates via `APIKeyMiddleware` — returns 403 if invalid
- After changing `.env`, run `dart run build_runner build --delete-conflicting-outputs` to regenerate `env.g.dart`

**Layer 2 — JWT Token (User-Level):**
- `AuthInterceptor` reads token from SQLite `app_cache.jwt_token`
- Sends `Authorization: Bearer <token>` header on every request
- On 401 response → clears session, user must re-authenticate
- Token TTL: 30 days (set by backend)

**Rules:**
- Never hardcode API keys in source code — always use `--dart-define`
- Never log JWT tokens at info level
- API key header is set in `ApiClient` default headers (not interceptor)
- JWT token header is set in `AuthInterceptor` (per-request from cache)

### Data Sync Strategy — Cache-First, API-Fallback

```dart
// Repository pattern
class UserRepositoryImpl implements UserRepository {
  // READ: local cache first, API fallback
  Future<User?> executeWithParams({Json? params}) async {
    final localResult = await _userCache.select(db, params);
    if (localResult != null) return localResult;
    // Fallback to API
    return await _userApiService.getUserById(id);
  }

  // WRITE: local cache first, then API sync
  Future<int?> saveUser({Json? data}) async {
    final result = await _userCache.insert(db, data);  // Local first
    await _userApiService.createUser(data);             // Then API
    return result;
  }
}
```

**Rules:**
- Always save to local cache first (offline-friendly)
- API sync failures are logged but don't block the user
- Use `try/catch` around API calls — emit error state only for critical failures
- Background sync should never throw to the UI layer

### API Service Conventions

```dart
@lazySingleton
final class UserApiService {
  const UserApiService(this._apiClient);
  final ApiClient _apiClient;

  Future<Json> createUser(Json data) async {
    final response = await _apiClient.dio.post<Map<String, dynamic>>(
      '/users',
      data: data,
    );
    return response.data!;
  }
}
```

**Rules:**
- All API services must be `@lazySingleton`
- Constructor takes `ApiClient` as dependency (injected via DI)
- Return raw `Json` (`Map<String, dynamic>`) — let repository/cubit handle mapping
- Path strings must start with `/` (relative to base URL)
- Use typed generic on Dio methods: `.post<Map<String, dynamic>>()`
- Wrap Dio calls in `try/catch` and convert to `ApiException`

### Error Handling

```dart
final class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioException(DioException e) {
    // Maps: timeout → "Connection timeout"
    //       connection error → "No internet connection"
    //       bad response → "Server error ({statusCode})"
  }
}
```

**Rules:**
- All HTTP errors must be caught and converted to `ApiException`
- Check response body for `error` field (backend standard format)
- Never expose raw Dio errors to the UI
- Use `LocaleKeys` for user-facing error messages

### Auth Flow

1. `POST /auth/register` or `POST /auth/login` → JWT token returned
2. `AuthService._saveSession()` → stores token in `app_cache.jwt_token`
3. On app startup → `AuthSessionCubit.loadSession()` checks session
4. All subsequent requests → `AuthInterceptor` injects Bearer token
5. On 401 → `AuthInterceptor.onError()` clears session from DB

### Environments & Flavor

Base URL is selected via `--dart-define=FLAVOR` at run/build time:

| Flavor | `FLAVOR` value | Base URL |
|--------|---------------|----------|
| Android Emulator (local) | `local` (default) | `http://10.0.2.2:8080/api/v1` |
| iOS Simulator (local) | `local_ios` | `http://localhost:8080/api/v1` |
| Physical Device (local) | `local` + `LOCAL_IP=<ip>` | `http://<ip>:8080/api/v1` |
| Production | `production` | `https://api.bodymetrics.app/api/v1` |

**VS Code:** Use the pre-configured launch configurations in `.vscode/launch.json` — no manual `--dart-define` needed.

**Terminal:**
```bash
# Android emulator (default, no flag needed)
flutter run

# iOS simulator
flutter run --dart-define=FLAVOR=local_ios

# Physical device (replace IP with your machine's LAN IP)
flutter run --dart-define=FLAVOR=local --dart-define=LOCAL_IP=192.168.1.100

# Production build
flutter build apk --dart-define=FLAVOR=production
flutter build ios --dart-define=FLAVOR=production
```

**Rules:**
- Never hardcode a URL string in feature code — always use `ApiConstants.baseUrl`
- Production URL is defined only in `ApiConstants` — never in `.env`
- When adding a new environment, add it to both `ApiConstants.baseUrl` switch and `.vscode/launch.json`

### Setup & Build

```bash
# 1. Create .env file in project root
echo "API_KEY=your-api-key-here" > .env

# 2. Generate obfuscated env.g.dart
dart run build_runner build --delete-conflicting-outputs

# 3. Run (FLAVOR defaults to local → Android emulator)
flutter run
```

**Note:** `.env` and `lib/data/api/env/env.g.dart` are in `.gitignore` — never committed.

---

## Package Reference

| Package | Version | Usage |
|---------|---------|-------|
| flutter_bloc | 9.1.1 | BLoC/Cubit state management |
| auto_route | 10.1.2 | Type-safe navigation |
| injectable | 2.5.1 | DI annotations |
| get_it | — | Service locator (via injectable) |
| sqflite | 2.4.2 | Local SQLite database |
| dio | 5.7.0 | HTTP client with interceptors |
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
