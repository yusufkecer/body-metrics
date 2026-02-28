# BodyMetrics — BMI & Vücut Metrik Takip Uygulaması

Flutter ile geliştirilmiş, bulut destekli sağlık metrik takip uygulaması. Kullanıcılar BMI hesaplayabilir, geçmiş ölçümlerini takip edebilir ve verilerini buluta yedekleyebilir.

## Özellikler

- **BMI Hesaplama** — Boy ve kiloya göre anlık hesaplama
- **Geçmiş Takibi** — Tüm ölçümler tarih sırasıyla listelenir
- **Grafikler** — BMI ve kilo değişim grafikleri (fl_chart)
- **Çoklu Profil** — Aynı cihazda birden fazla kullanıcı
- **Bulut Yedekleme** — Hesap oluşturarak verileri buluta senkronize et
- **Şifremi Unuttum** — E-posta ile 6 haneli OTP ile şifre sıfırlama
- **Çevrimdışı Destek** — SQLite cache ile internet olmadan çalışır; sync bekleyen veriler uygulama yeniden açıldığında otomatik olarak sunucuya gönderilir
- **Hesap Restore** — Mevcut hesapla giriş yapıldığında profil ve geçmiş ölçümler otomatik indirilir
- **Çoklu Dil** — Türkçe ve İngilizce

## Teknolojiler

- **Flutter** + **Dart**
- **BLoC/Cubit** — State management
- **auto_route** — Type-safe navigasyon
- **injectable/get_it** — Dependency injection
- **sqflite** — Yerel SQLite önbellek
- **Dio** — HTTP client
- **easy_localization** — i18n (tr + en)
- **fl_chart** — Grafik bileşenleri

## Proje Yapısı

```
lib/
├── core/          # Paylaşımlı altyapı (router, tema, widget'lar, extension'lar)
├── data/          # SQLite önbellek + REST API (Dio client, servisler, interceptor'lar)
├── domain/        # Global entity'ler, use case'ler, repository contract'ları
├── feature/       # Feature modülleri (her biri kendi presentation/cubit/state'ine sahip)
│   ├── auth/      # Login, Register, Şifremi Unuttum
│   ├── splash/
│   ├── onboard/
│   ├── home/
│   └── ...
└── injection/     # GetIt + Injectable DI (locator.dart, locator.config.dart)
```

## Navigasyon Akışı

```
Splash → Onboard → AvatarPicker → UserGeneralInfo → Gender → Height → Weight → Home
```

Login/Register ve Şifremi Unuttum `UserOperations` ekranından erişilir.

AvatarPicker ekranında "Giriş Yap / Kayıt Ol" butonuna basıldığında:
- **Login:** Mevcut profil ve ölçümler sunucudan indirilip local cache'e yazılır → Home'a yönlendirilir
- **Register:** `syncPending` flag SQLite'a kaydedilir → onboarding offline tamamlanabilir → internet geldiğinde uygulama açılışında otomatik sync yapılır

## API Entegrasyonu

Backend: `body-metrics-backend/` (Go 1.23 + MySQL)

### Offline Sync Mekanizması

Kayıt sonrası internet yoksa veriler kaybolmaz:

1. Kayıt → `sync_pending = 1` SQLite'a yazılır
2. Onboarding + ölçüm → tüm veri local SQLite'a kaydedilir
3. İnternet yoksa sync başarısız olur, flag kalır
4. **Uygulama yeniden açıldığında** Splash ekranı `sync_pending` flag'ini okur → internet varsa otomatik sync başlatır
5. Sync tamamlanınca `sync_pending = 0` yazılır

### İki Katmanlı Güvenlik

**Katman 1 — API Key:**
- Her istekte `X-API-Key` header'ı
- `.env` dosyasında saklanır, `envied` ile XOR-obfuscated derlenir
- `dart run build_runner build` ile `env.g.dart` yenilenir

**Katman 2 — JWT Token:**
- Login/Register sonrası alınan token SQLite'a kaydedilir
- `AuthInterceptor` her istekte `Authorization: Bearer <token>` ekler
- 401 gelirse session temizlenir

### Auth Endpoint'leri

| Method | Path | Açıklama |
|--------|------|----------|
| POST | `/auth/register` | Kayıt ol → JWT |
| POST | `/auth/login` | Giriş yap → JWT |
| POST | `/auth/forgot-password` | 6 haneli OTP e-posta gönder |
| POST | `/auth/reset-password` | OTP + yeni şifre ile sıfırla |

## Kurulum & Çalıştırma

```bash
# 1. .env dosyası oluştur (API key için)
echo "API_KEY=your-api-key" > .env

# 2. Kod üretimi (route, DI, env)
dart run build_runner build --delete-conflicting-outputs

# 3. Çalıştır (Android emülatör)
flutter run

# iOS simülatör
flutter run --dart-define=FLAVOR=local_ios

# Production build (imzalı APK için önce android/key.properties doldur)
flutter build apk --release --dart-define=FLAVOR=production
```

## Android Release Signing

`android/key.properties` dosyasını doldur (gitignored):

```properties
storePassword=<keystore-şifresi>
keyPassword=<key-şifresi>
keyAlias=bodymetrics
storeFile=../bodymetrics.keystore
```

Keystore oluşturmak için:
```bash
keytool -genkey -v -keystore android/bodymetrics.keystore \
  -alias bodymetrics -keyalg RSA -keysize 2048 -validity 10000
```

## Lokalizasyon

Dil dosyaları: `assets/language/tr.json` ve `assets/language/en.json`

Yeni key eklemek:
1. Her iki JSON dosyasına key-value çifti ekle
2. `lib/core/init/language/locale_keys.g.dart` dosyasına `static const` ekle
3. Kodda `LocaleKeys.namespace_key.tr()` ile kullan

## Kod Üretimi

Aşağıdaki değişikliklerden sonra `build_runner` çalıştır:
- Model ekleme/değiştirme (`@JsonSerializable`)
- Yeni route ekleme (`@RoutePage`)
- Yeni DI kaydı (`@injectable`, `@lazySingleton`)
- `.env` dosyası değişikliği

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Ekran Görüntüleri

![Screenshot_1727416538](https://github.com/user-attachments/assets/3dc7c29a-31e6-4b2e-a9dd-997ae97a02b5)
![Screenshot_1727416541](https://github.com/user-attachments/assets/05de34dd-4bed-4e0e-a5bb-dc48eb1bbc87)
![Screenshot_1727416544](https://github.com/user-attachments/assets/daf551b3-94ec-4901-af0e-f25e7793db4a)
![Screenshot_1727416546](https://github.com/user-attachments/assets/ae4e844e-d60b-4852-829e-48038004606f)
![Screenshot_1727416549](https://github.com/user-attachments/assets/8a30f988-3539-445c-9c32-4dedfba5ea4c)
![Screenshot_1727416555](https://github.com/user-attachments/assets/41da5a87-6f06-4337-be12-14ae903116d9)
![Screenshot_1727416568](https://github.com/user-attachments/assets/e084c199-4e18-4bfe-a972-0b70a5fdbcc3)
