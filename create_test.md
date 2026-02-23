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
*   **Also Completed**:
    *   Fixed DI issue: `UserCubit` now depends on `UserUseCase` interface.
    *   Added tests for `UserCubit`, `HomeCardCubit`, and `UserMetricCubit`.

## Execution Log
- [x] Setup Test Environment (dependencies: mockito, build_runner, sqflite_common_ffi)
- [x] Phase 1: Core Tests
- [x] Phase 2: Domain Tests
- [x] Phase 3: Data Tests
- [x] Phase 4: Feature Tests

## Next Steps (To-Do)
1.  Add tests for remaining feature cubits (`Auth`, `Onboard`, `Height`, etc.).
2.  Add integration tests for critical onboarding-to-home flows.
