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

## Phase 4: Feature Layer (State Management) (In Progress)
*   **Goal**: Verify UI logic and state changes.
*   **Completed**:
    *   `lib/feature/gender/presentation/cubit/gender_cubit.dart` - **Tests Added**
    *   `lib/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart` - **Tests Written (Pending DI Fix)**
*   **Pending**:
    *   Fix DI issue: `UserCubit` depends on concrete `UserUseCaseImpl`, but it is now bound to `UserUseCase`.
    *   Run `WeightPickerCubit` tests after DI fix.
    *   Add tests for other critical Cubits (`UserCubit`, `HomeCubit`, etc.).

## Execution Log
- [x] Setup Test Environment (dependencies: mockito, build_runner, sqflite_common_ffi)
- [x] Phase 1: Core Tests
- [x] Phase 2: Domain Tests
- [x] Phase 3: Data Tests
- [ ] Phase 4: Feature Tests (Partial)

## Next Steps (To-Do)
1.  **Refactor `UserCubit`**: Update `lib/feature/home/presentation/cubit/user_cubit/user_cubit.dart` to depend on `UserUseCase` interface instead of `UserUseCaseImpl`.
2.  **Regenerate Code**: Run `flutter pub run build_runner build --delete-conflicting-outputs` to fix DI registration.
3.  **Verify WeightPicker**: Run tests for `WeightPickerCubit`.
4.  **Expand Coverage**: Continue adding tests for remaining features.
