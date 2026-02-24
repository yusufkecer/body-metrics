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

## Phase 4 Continuation (Ordered Backlog)
The list below continues from where we paused. Tests should be added in this exact order.

1. **DI Refactor for `UserCubit`**
   - File: `lib/feature/home/presentation/cubit/user_cubit/user_cubit.dart`
   - Replace `UserUseCaseImpl` dependency with `UserUseCase` interface.
   - Regenerate injectable/build runner outputs.

2. **`UserCubit` Tests**
   - Create: `test/feature/home/presentation/cubit/user_cubit/user_cubit_test.dart`
   - Cases:
     - initial state is `UserLoading`
     - emits `UserLoaded` when current user exists
     - emits `UserError(exception_user_not_found)` when user is null
     - emits `UserError(exception_generic_error)` on thrown exception

3. **`UserMetricCubit` Tests**
   - Create: `test/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit_test.dart`
   - Cases:
     - initial state is `UserMetricInitial`
     - emits `UserMetricLoading` -> `UserMetricSuccess` when metric exists
     - emits `UserMetricLoading` -> `UserMetricError(User metric not found)` when result is null
     - emits `UserMetricLoading` -> `UserMetricError(exception_generic_error)` on exception

4. **`HomeCardCubit` Tests**
   - Create: `test/feature/home/presentation/cubit/home_card_cubit/home_card_cubit_test.dart`
   - Cases:
     - `initialize()` emits `HomeCardLoaded` with `ExpandedCard.none`
     - `dataListOnPressed()` toggles `none <-> list`
     - `chartOnPressed()` toggles `none <-> chart`
     - switching from list to chart and chart to list produces expected animation flags
     - `adjustLength()` returns `2` for values >= 2, otherwise same value

5. **`HeightSelectorCubit` Tests**
   - Create: `test/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit_test.dart`
   - Cases:
     - initial value matches default state
     - `updateHeight()` clamps to min/max bounds
     - page-to-height conversion returns expected integer value

6. **`SaveHeightCubit` Tests**
   - Create: `test/feature/height/presentation/cubit/save_height_cubit/save_height_cubit_test.dart`
   - Cases:
     - initial state is idle/initial
     - success path emits loading -> success
     - failure path emits loading -> error

7. **Auth Cubits**
   - Files:
     - `test/feature/auth/presentation/cubit/login_cubit_test.dart`
     - `test/feature/auth/presentation/cubit/register_cubit_test.dart`
     - `test/feature/auth/presentation/cubit/auth_session_cubit_test.dart`
   - Cases:
     - success, validation/known-failure, and exception flow for each cubit
     - verify session load and logout transitions for `AuthSessionCubit`

8. **`OnboardCubit` Tests**
   - Create: `test/feature/onboard/presentation/cubit/onboard_cubit_test.dart`
   - Cases:
     - index update/skip behavior
     - `done()` success and failure outcomes

9. **`UserInfoFormCubit` Tests**
   - Create: `test/feature/user_general_info/presentation/cubit/user_info_form_cubit_test.dart`
   - Cases:
     - `setFormEmpty` state transition
     - `saveUserInfo` loading/success/error flows

10. **Final Verification**
   - Run full test suite.
   - Mark Phase 4 as completed and update this document status.

## Execution Log
- [x] Setup Test Environment (dependencies: mockito, build_runner, sqflite_common_ffi)
- [x] Phase 1: Core Tests
- [x] Phase 2: Domain Tests
- [x] Phase 3: Data Tests
- [ ] Phase 4: Feature Tests (Partial)

## Next Steps (To-Do)
1.  **Complete Backlog Step 1-4**: DI fix + Home cubit tests (`UserCubit`, `UserMetricCubit`, `HomeCardCubit`).
2.  **Complete Backlog Step 5-9**: Height/Auth/Onboard/UserInfo cubit tests.
3.  **Run All Tests**: `flutter test`
4.  **Close Phase 4**: Update this document and execution log after all feature tests pass.
