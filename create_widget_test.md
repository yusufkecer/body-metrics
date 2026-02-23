# Widget Testing Plan (Presentation Layer Coverage)

Bu plan, `lib/feature/**/presentation` altındaki view ve görünür widget elementlerini test etmek için hazırlanmıştır.

## Kapsam Hedefi
- Onboard → Register/UserOperations → Home akışı
- AvatarPicker, Gender, HeightPicker, UserGeneralInfo, WeightPicker, Splash view’leri
- Her view içinde kullanıcıya görünen temel widget elementleri (app bar, form, list/grid, picker, tab vb.)

## Yazılan Test Dosyaları
1. `test/feature/flow/widget/onboard_register_home_widget_test.dart`
   - Onboard görünümü render
   - UserOperations/Register tab görünümü render
   - Home view render (loaded user state)

2. `test/feature/presentation/presentation_views_widget_test.dart`
   - AvatarPicker: grid + avatar + register action
   - Gender: iki seçim kartı + ikonlar
   - HeightPicker: ruler/pageview + app bar
   - UserGeneralInfo: avatar + form + 3 input
   - WeightPicker: indicator input + 2 wheel picker
   - Splash: placeholder render

## Teknik Notlar
- View’lerin çoğu asset kullandığı için testlerde `flutter/assets` kanalı mocklanmıştır.
- `Locator.sl` her testten sonra resetlenerek izolasyon sağlanmıştır.
- Cubit/UseCase bağımlılıkları testte minimum gerekli şekilde mock/fake edilmiştir.

## Sonraki Adımlar
- Etkileşim odaklı testler: buton click, form submit, validation mesajları.
- Router transition assertion: route push/pop akışlarının explicit kontrolü.
- Home içindeki chart/list expand davranışlarının widget-level doğrulaması.
