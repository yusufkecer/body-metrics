# Unit Testing Plan for Body Metrics

This document outlines the strategy for adding unit tests to the Body Metrics project. The goal is to cover all layers of the application, starting from the core utilities up to the feature-level state management.

## Strategy
Due to the use of `final` classes, we will rely on `mockito` with code generation or manual mocks where necessary to isolate dependencies. We will prioritize testing logic over UI widgets.

## Phase 1: Core & Utilities (Completed)
*   **Goal**: Verify helper functions, extensions, and shared logic.
*   **Completed**:
    *   `lib/core/extensions/` (String, Check, Regex extensions) - **Tests Added**
    *   `lib/core/util/models` (User, UserMetric) - **Tests Added**

## Phase 2: Domain Layer (Completed)
*   **Goal**: Verify business rules and use cases.
*   **Completed**:
    *   `lib/domain/use_case/user_use_case_impl.dart` - **Tests Added**
    *   Refactored `UserUseCaseImpl` to depend on `UserRepository` interface for better testability.

## Phase 3: Data Layer (Completed)
*   **Goal**: Verify data transformations and repository implementations.
*   **Completed**:
    *   `lib/data/cache/user_cache/user_cache.dart` - **Tests Added & Bug Fixed**
    *   Fixed `NoSuchTableError` in `UserCache` by correctly overriding `initializeDatabase`.
    *   Verified database operations using `sqflite_common_ffi`.

## Phase 4: Feature Layer (State Management) (Completed)
*   **Goal**: Verify UI logic and state changes.
*   **Completed**:
    *   `lib/feature/gender/presentation/cubit/gender_cubit.dart` - **Tests Added**
    *   `lib/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart` - **Tests Added**
    *   `lib/feature/home/presentation/cubit/user_cubit/user_cubit.dart` - **Tests Added**
    *   `lib/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart` - **Tests Added**
    *   `lib/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart` - **Tests Added**
    *   `lib/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit.dart` - **Tests Added**
    *   `lib/feature/height/presentation/cubit/save_height_cubit/save_height_cubit.dart` - **Tests Added**
    *   `lib/feature/auth/presentation/cubit/login_cubit.dart` - **Tests Added**
    *   `lib/feature/auth/presentation/cubit/register_cubit.dart` - **Tests Added**
    *   `lib/feature/auth/presentation/cubit/auth_session_cubit.dart` - **Tests Added**
    *   `lib/feature/onboard/presentation/cubit/onboard_cubit.dart` - **Tests Added**
    *   `lib/feature/user_general_info/presentation/cubit/user_info_form_cubit.dart` - **Tests Added**

## Execution Log
- [x] Setup Test Environment (dependencies: mockito, build_runner, sqflite_common_ffi)
- [x] Phase 1: Core Tests
- [x] Phase 2: Domain Tests
- [x] Phase 3: Data Tests
- [x] Phase 4: Feature Tests (Completed)

## Next Steps (Completed)
1.  **Complete Backlog Step 1-4**: DI fix + Home cubit tests (`UserCubit`, `UserMetricCubit`, `HomeCardCubit`). -> **Done**
2.  **Complete Backlog Step 5-9**: Height/Auth/Onboard/UserInfo cubit tests. -> **Done**
3.  **Run All Tests**: `flutter test` -> **Done (96/96 passed)**
4.  **Close Phase 4**: Update this document and execution log after all feature tests pass. -> **Done**
