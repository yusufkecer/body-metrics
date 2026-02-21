# AI Project Structure (BodyMetrics)

This file is prepared to help an AI agent **read and understand** the repository quickly.

## 1) Project Goal
- Create user profiles (avatar + basic info + height), then calculate BMI/VTI using weight input.
- Persist results in local SQLite.
- Display historical measurements on Home as cards and charts.

---

## 2) High-Level Architecture
The project follows Flutter + BLoC + Clean Architecture principles.

### Layers
- **Presentation**: View + Cubit/State (UI, interaction, state transitions)
- **Domain**: UseCase + Entity/Repository contracts (business rules)
- **Data**: Cache/DB implementations (sqflite)
- **Core**: Shared infrastructure (router, base classes, constants, widgets, extensions)

Main directories:
- `lib/core`: shared infrastructure, base layers, router, widgets
- `lib/domain`: global domain entities/usecases/repositories
- `lib/data`: cache and db access
- `lib/feature/*`: feature-based presentation/domain layers

---

## 3) Critical File Map

### App startup and route decision
- `lib/feature/splash/presentation/splash.dart`
- `lib/feature/splash/presentation/splash_model.dart`
- `lib/core/router/app_router.dart`
- `lib/core/router/app_router.gr.dart`

### User and app state
- `lib/core/util/models/app_model/app_model.dart`
- `lib/core/util/models/user/user.dart`
- `lib/domain/use_case/save_app_use_case.dart`
- `lib/domain/use_case/set_id_use_case.dart`

### BMI/VTI calculation and persistence
- `lib/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart`
- `lib/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart`
- `lib/feature/weight_picker/domain/use_case/save_weight_use_case.dart`
- `lib/feature/weight_picker/domain/repository/save_weight_repository.dart`

### Metric data model and cache
- `lib/core/util/models/user_metrics/user_metric.dart`
- `lib/core/util/models/user_metrics/user_metric.g.dart`
- `lib/core/util/models/user_metrics/user_metrics.dart`
- `lib/data/cache/user_metrics_cache/user_metrics_cache.dart`
- `lib/data/cache/user_metrics_cache/user_metrics_columns.dart`

### Home rendering (list + chart)
- `lib/feature/home/presentation/home.dart`
- `lib/feature/home/presentation/widgets/data_list.dart`
- `lib/core/widgets/charts/line_charts.dart`
- `lib/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart`

### Profile flows
- Avatar: `lib/feature/avatar_picker/presentation/*`
- General info: `lib/feature/user_general_info/*`
- Height: `lib/feature/height/*`

---

## 4) Data Flow (Summary)

### First-time setup / onboarding
1. Splash DB init + last-page check
2. Avatar selection
3. User general info
4. Gender / Height
5. Weight input + BMI calculation
6. Home screen

### BMI persistence
1. `WeightPickerCubit.saveBodyMetrics`
2. User + height validation
3. BMI calculation (`CalculateBmiUseCase`)
4. Build `UserMetric` (`weight`, `bmi`, `body_metric`, `created_at`, etc.)
5. `SaveWeightUseCase` -> `SaveWeightRepository`
6. SQLite persistence via `UserMetricsCache.insert`

### Home read path
1. `UserMetricCubit.getUserMetric(userId)`
2. `UserMetricUseCase` -> `UserMetricRepository`
3. `UserMetricsCache.select`
4. UI renders cards + chart spots/labels

---

## 5) DB Notes (`user_metrics`)
Important fields:
- `id`
- `user_id`
- `weight`
- `height`
- `bmi`
- `weight_diff`
- `body_metric`
- `date` (legacy display)
- `created_at` (canonical calculation timestamp)

Ordering:
- Records are read using `created_at ASC, id ASC`.

---

## 6) Quick Debug Guide for AI Agents

### If “BMI calculation is correct but Home display is wrong”
- Check `UserMetric` construction in `weight_picker_cubit.dart`.
- Check insert/select/orderBy in `user_metrics_cache.dart`.
- Check date/label fallback logic in `home.dart` and `data_list.dart`.

### If “Profile switching fails / switches wrong profile”
- Check index->userId resolution in `avatar_picker_model.dart`.
- Check `SetIdUseCase` and `AppModel(activeUser)` updates.

### If “Page-to-page flow is broken”
- Check `Pages` switch flow in `splash_model.dart`.
- Check last-page persistence via `SaveAppUseCase`.

---

## 7) Development Principles (Recommended)
- Keep formatting/computation out of UI when possible; move to usecase/service.
- Keep DB migrations centralized and idempotent (`PRAGMA table_info` + `ALTER TABLE`).
- Use a single canonical timestamp field (`created_at`).
- Define new features at Domain contract level first, then implement Data/Presentation.

