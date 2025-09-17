# AI Rules for Body-Metrics Flutter Project

These rules are specifically customized for the **body-metrics** project and designed to align with the existing project architecture and patterns.

## Project Architecture

### Clean Architecture + Feature-First Structure
```
lib/
├── core/           # Core infrastructure
├── data/           # Data layer (Cache, Database)
├── domain/         # Business logic
├── feature/        # Feature-based organization
└── injection/      # Dependency injection
```

*   Use **feature-first** organization - each feature in its own directory
*   Follow **Clean Architecture** principles
*   Maintain **separation of concerns** - presentation, domain, data layers
*   Centralize shared utilities in the **core** module

## State Management

### BLoC/Cubit Pattern (Current Implementation)
*   Continue using the **BLoC pattern** already implemented
*   Use **Cubit** for simple state, **BLoC** for complex event handling
*   Register Cubit/BLoC with **Injectable** dependency injection
*   Optimize state comparisons using **Equatable**

```dart
@injectable
class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit(this._useCase) : super(const WeightPickerInitial());
  
  // Use case injection via constructor
}
```

*   Provide multiple blocs using **MultiBlocProvider**
*   Use **BlocBuilder** and **BlocListener** with pattern matching
*   Handle loading, success, and error states consistently
*   Emit appropriate states for UI feedback

## Dependency Injection

### Get_it + Injectable (Current Implementation)
*   Use **Injectable** annotations (@injectable, @lazySingleton)
*   Resolve dependencies with **Locator.sl<Type>()**
*   Run code generation with **build_runner**

```dart
@injectable
class MyRepository {
  MyRepository(this._cache);
}

// Usage
final repo = Locator.sl<MyRepository>();
```

*   Use **@injectable** for repository pattern
*   Use **@lazySingleton** for singleton services
*   Use **@injectable** (factory) for UI Cubits
*   Register all dependencies in the injection module

## Database & Cache

### SQLite + Custom Cache Layer (Current Implementation)
*   Use **sqflite** for local database
*   Implement **cache pattern** for data access abstraction
*   Implement **BaseCache** interface

```dart
@lazySingleton
class UserCache extends ImpCache implements BaseCache<Users, Json, Json, Users> {
  @override
  Future<void> initializeTable(Database db, int version) async {
    // Table creation SQL
  }
}
```

*   Use **foreign key** constraints
*   Implement **JSON serialization** for data mapping
*   Support **database versioning** for migrations
*   Handle database initialization and cleanup properly

## Navigation

### Auto Route (Current Implementation)
*   Use **auto_route** package (not go_router)
*   Configure routes with **@AutoRouterConfig()**
*   Implement **type-safe** navigation

```dart
@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashView.page, initial: true),
    // Other routes
  ];
}
```

*   Use **RouteAware** mixins when needed
*   Support **deep linking** with path parameters
*   Handle navigation guards for authentication
*   Maintain consistent navigation patterns

## Theme & UI

### Custom Theme + Material 3 (Current Implementation)
*   Use **CustomTheme** class for centralized theming
*   Enable **Material 3** (`useMaterial3: true`)
*   Focus on **dark theme** design (current structure)

```dart
@lazySingleton
class CustomTheme implements BaseTheme {
  ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // Custom theme properties
  );
}
```

*   Manage color palette with **ProductColor**
*   Create consistent UI with **custom widgets**
*   Enhance UX with **Lottie animations**
*   Use purple theme (#673AB7) as primary color

## Localization

### Easy Localization (Current Implementation)
*   Use **easy_localization** package
*   Support multiple languages with **JSON** files
*   Implement **type-safe** localization with LocaleKeys

```dart
Text(LocaleKeys.exception_user_not_found.tr())
```

*   Organize language files in assets directory
*   Provide easy access with **context extensions**
*   Support Turkish and English languages
*   Generate locale keys automatically

## Error Handling

### Custom Exception + Logging
*   Use **AppException** custom exception class
*   Implement **structured logging** with logger package
*   Provide **convenient logging** with extension methods

```dart
try {
  // Business logic
} catch (e, st) {
  'Error message: $e\n$st'.log();
  emit(ErrorState(message: LocaleKeys.exception_generic_error));
}
```

*   Handle errors gracefully in all layers
*   Provide meaningful error messages to users
*   Log errors with appropriate severity levels
*   Use try-catch blocks consistently

## Code Generation

### Build Runner (Current Implementation)
*   Use **json_serializable** for model generation
*   Use **injectable** for DI registration
*   Use **auto_route** for route generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

*   Run code generation after model changes
*   Keep generated files in version control
*   Use part files for generated code
*   Handle conflicts with delete-conflicting-outputs

## Assets & Resources

### Organized Asset Structure (Current Implementation)
```
assets/
├── app_logo/
├── images/
│   ├── onboard/
│   └── profiles/
├── lotties/
└── language/
```

*   Use **Lottie animations** for engaging UX
*   Provide **profile avatars** for user personalization
*   Maintain **organized folder structure** for maintainability
*   Declare all assets in pubspec.yaml

## Testing

### Flutter Test + Unit Tests
*   Use **widget_test.dart** for widget testing
*   Use **bloc_test** package for Cubit testing
*   Use **Mockito** for dependency mocking

```dart
group('WeightPickerCubit', () {
  late WeightPickerCubit cubit;
  
  setUp(() {
    cubit = WeightPickerCubit(mockUseCase);
  });
  
  test('should emit success when calculation succeeds', () {
    // Test implementation
  });
});
```

*   Test all business logic in use cases
*   Mock external dependencies
*   Test error scenarios
*   Maintain high test coverage

## Performance & Optimization

### Body-Metrics Specific
*   Optimize **BMI calculations** performance
*   Optimize **chart rendering** with fl_chart
*   Use **database indexing** for queries
*   Implement **image caching** for profile avatars
*   Use const constructors for widgets
*   Implement lazy loading for lists

## Security & Health Data

### Health App Best Practices
*   Ensure **secure storage** of sensitive health data
*   Implement **input validation** for BMI/weight data
*   Use **data encryption** for critical information
*   Comply with **privacy regulations** for health data
*   Validate all user inputs
*   Sanitize data before storage

## Code Quality

### Project-Specific Standards
*   Use **very_good_analysis** lint rules (current)
*   Follow **meaningful naming** with feature-based convention
*   Add **documentation** for public APIs
*   Enhance **code reusability** with extension methods
*   Follow Effective Dart guidelines
*   Use pattern matching where appropriate

## Package Usage Guidelines

### Optimal Usage of Current Packages
*   **animated_text_kit**: Engaging text animations
*   **fl_chart**: BMI/weight tracking charts and visualizations
*   **font_awesome_flutter**: Consistent iconography
*   **introduction_screen**: Smooth onboarding experience
*   **flutter_zoom_drawer**: Intuitive navigation drawer
*   **lottie**: Engaging animations and loading states
*   **sqflite**: Reliable local data storage
*   **equatable**: Efficient state comparisons

## Visual Design & Theming

### Body-Metrics UI Guidelines
*   Use **purple theme** (#673AB7) as primary color
*   Prioritize **dark mode** design (current structure)
*   Implement **card-based layout** for information hierarchy
*   Use **gradient backgrounds** for premium feel
*   Add **subtle animations** for user engagement
*   Ensure responsive design for different screen sizes

### Component Standards
*   Use **custom elevated buttons** for consistent styling
*   Implement **rich text widgets** for formatted text
*   Use **chart components** for data visualization
*   Show **loading states** with Lottie animations
*   Create reusable widget components
*   Follow Material Design 3 guidelines

## Data Flow & Architecture

### Repository Pattern
*   Define **abstract repositories** in domain layer
*   Implement **concrete implementations** in data layer
*   Use **use cases** for business logic encapsulation

```dart
abstract class UserRepository {
  Future<User?> getCurrentUser();
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userCache);
  // Implementation
}
```

### Entity & Model Structure
*   Use **domain entities** for business logic
*   Use **data models** for JSON serialization
*   Implement **extension methods** for mapping
*   Keep entities immutable
*   Use value objects where appropriate

## Advanced Patterns

### Mixin Usage
*   Use **mixins** for shared functionality across widgets
*   Implement **lifecycle mixins** for common patterns
*   Use **validation mixins** for form handling

### Extension Methods
*   Create **context extensions** for easy access to theme/locale
*   Implement **utility extensions** for common operations
*   Use **logger extensions** for convenient logging
*   Add **validation extensions** for data types

## Health & Fitness Specific Rules

### BMI & Body Metrics
*   Validate weight and height inputs thoroughly
*   Handle edge cases in BMI calculations
*   Store historical data for tracking
*   Implement proper units conversion
*   Provide meaningful health insights

### Data Visualization
*   Use fl_chart for trend visualization
*   Implement interactive charts
*   Show progress over time
*   Provide clear data labels
*   Use appropriate chart types for different metrics

These rules support the existing architecture of the body-metrics project and ensure maintainability as the project grows.