# BodyMetrics

## TR

BodyMetrics, Flutter ile geliştirilmiş offline-öncelikli bir sağlık metrik takip uygulamasıdır.

Uygulama; onboarding, profil oluşturma, kilo/boy verisi ile BMI hesaplama, geçmiş ölçümleri listeleme/grafikleme ve yerel veriyi API ile senkron etme akışlarını içerir.

### Backend Repository

- Backend (Go): https://github.com/yusufkecer/body-metrics-backend.git

### Özellikler

- BMI hesaplama ve sınıflandırma
- Ölçüm geçmişini kart + grafik olarak gösterme
- Çoklu profil desteği
- Login / Register / Şifremi unuttum akışları
- Offline çalışma (SQLite cache)
- Uygulama açılışında otomatik pending-sync denemesi
- Türkçe, İngilizce, Almanca dil desteği

### Teknoloji Yığını

- Flutter + Dart
- flutter_bloc / Cubit
- auto_route
- injectable + get_it
- sqflite
- dio
- easy_localization
- fl_chart

### Mimari

Proje, Clean Architecture + feature-first yaklaşımını takip eder:

- `lib/core`: Ortak altyapı (router, theme, extension, widget, base sınıflar)
- `lib/data`: API + cache + DB katmanı
- `lib/domain`: Entity, repository sözleşmeleri, use-case’ler
- `lib/feature`: Modül bazlı presentation/domain katmanları
- `lib/injection`: DI konfigürasyonu

### Uygulama Akışı

Ana akış:

`Splash -> Onboard -> AvatarPicker -> UserGeneralInfo -> Gender -> Height -> Weight -> Home`

Auth rotaları:

- `UserOperationsView` (login/register tab ekranı)
- `ForgotPasswordView`

### Auth ve Senkronizasyon

Auth tarafı:

- `AuthService`: register/login/session/forgot-password işlemleri
- `AuthSessionCubit`: oturum durum yönetimi
- `LoginCubit`: login sonrası restore + sync tetikler
- `RegisterCubit`: register sonrası pending işaretler
- `UserOperationsView`: auth UI giriş noktası

Senkronizasyon tarafı:

- `SyncDataRepository` (`lib/domain/repository/sync_data_repository.dart`)
- `SyncLocalDataUseCase`

Temel prensip:

1. Veri önce local cache’e yazılır
2. API senkronizasyonu arka planda denenir
3. Başarısızsa `sync_pending` kalır
4. Splash açılışında pending durum geri yüklenip tekrar denenir

### Proje Yapısı (Özet)

```text
body-metrics/
├─ android/
├─ assets/
├─ lib/
│  ├─ core/
│  ├─ data/
│  ├─ domain/
│  ├─ feature/
│  └─ injection/
├─ scripts/
├─ test/
├─ AGENTS.md
├─ flutter_rules.md
└─ README.md
```

Test dizini ana başlıkları:

- `test/core`
- `test/data`
- `test/domain`
- `test/feature`

### Kurulum

```bash
flutter pub get
```

`.env` oluştur:

```bash
API_KEY=your-api-key-here
```

### Çalıştırma (Flavor)

- `local` (varsayılan): `http://10.0.2.2:8080/api/v1`
- `local_ios`: `http://localhost:8080/api/v1`
- `local` + `LOCAL_IP`: `http://<LOCAL_IP>:8080/api/v1`
- `production`: `https://api.bodymetrics.life/api/v1`

```bash
flutter run
flutter run --dart-define=FLAVOR=local_ios
flutter run --dart-define=FLAVOR=local --dart-define=LOCAL_IP=192.168.1.20
flutter build apk --dart-define=FLAVOR=production
```

### Kod Üretimi

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Testler

- Toplam test dosyası: `33`
- Test dosyası (`*_test.dart`): `21`
- Mock dosyası (`*.mocks.dart`): `12`

```bash
flutter test
# veya
bash scripts/run_tests.sh
```

### Android Release Signing

`android/key.properties` (git’e eklenmemeli):

```properties
storePassword=<şifre>
keyPassword=<şifre>
keyAlias=bodymetrics
storeFile=../bodymetrics.keystore
```

```bash
flutter build apk --release --dart-define=FLAVOR=production
```

---

## EN

BodyMetrics is an offline-first health metrics tracking app built with Flutter.

It covers onboarding, profile creation, BMI calculation from weight/height, historical metric list/chart rendering, and local-to-remote API sync.

### Backend Repository

- Backend (Go): https://github.com/yusufkecer/body-metrics-backend.git

### Features

- BMI calculation and classification
- Historical metrics as cards + charts
- Multi-profile support
- Login / Register / Forgot password flows
- Offline support with SQLite cache
- Automatic pending-sync retry at app startup
- Localization support: Turkish, English, German

### Tech Stack

- Flutter + Dart
- flutter_bloc / Cubit
- auto_route
- injectable + get_it
- sqflite
- dio
- easy_localization
- fl_chart

### Architecture

The project follows Clean Architecture + feature-first structure:

- `lib/core`: shared infrastructure (router, theme, extensions, widgets, base classes)
- `lib/data`: API + cache + DB layer
- `lib/domain`: entities, repository contracts, use-cases
- `lib/feature`: module-based presentation/domain layers
- `lib/injection`: DI setup

### App Flow

Main flow:

`Splash -> Onboard -> AvatarPicker -> UserGeneralInfo -> Gender -> Height -> Weight -> Home`

Auth routes:

- `UserOperationsView` (login/register tabs)
- `ForgotPasswordView`

### Auth and Sync

Auth layer:

- `AuthService`: register/login/session/forgot-password operations
- `AuthSessionCubit`: session state management
- `LoginCubit`: triggers restore + sync after login
- `RegisterCubit`: marks pending sync after register
- `UserOperationsView`: auth UI entry point

Sync layer:

- `SyncDataRepository` (`lib/domain/repository/sync_data_repository.dart`)
- `SyncLocalDataUseCase`

Core principle:

1. Persist data to local cache first
2. Attempt API sync in background
3. Keep `sync_pending` when sync fails
4. Retry on Splash startup after pending-state restore

### Project Structure (Summary)

```text
body-metrics/
├─ android/
├─ assets/
├─ lib/
│  ├─ core/
│  ├─ data/
│  ├─ domain/
│  ├─ feature/
│  └─ injection/
├─ scripts/
├─ test/
├─ AGENTS.md
├─ flutter_rules.md
└─ README.md
```

Main test folders:

- `test/core`
- `test/data`
- `test/domain`
- `test/feature`

### Setup

```bash
flutter pub get
```

Create `.env`:

```bash
API_KEY=your-api-key-here
```

### Run (Flavor)

- `local` (default): `http://10.0.2.2:8080/api/v1`
- `local_ios`: `http://localhost:8080/api/v1`
- `local` + `LOCAL_IP`: `http://<LOCAL_IP>:8080/api/v1`
- `production`: `https://api.bodymetrics.life/api/v1`

```bash
flutter run
flutter run --dart-define=FLAVOR=local_ios
flutter run --dart-define=FLAVOR=local --dart-define=LOCAL_IP=192.168.1.20
flutter build apk --dart-define=FLAVOR=production
```

### Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Tests

- Total test files: `33`
- Test files (`*_test.dart`): `21`
- Mock files (`*.mocks.dart`): `12`

```bash
flutter test
# or
bash scripts/run_tests.sh
```

### Android Release Signing

`android/key.properties` (must not be committed):

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=bodymetrics
storeFile=../bodymetrics.keystore
```

```bash
flutter build apk --release --dart-define=FLAVOR=production
```
