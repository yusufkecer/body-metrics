# Mobile Next Step

## next_step

1. **Server-local user id eşleştirmesini düzelt (kritik):** local `user.id` ile backend `user.id` ayrıştırılsın, mapping tablosu (örn. `local_user_id`, `server_user_id`) eklensin.
2. **Restore akışını kullanıcıya bağla:** `/users` listesinden `first` almak yerine login e-postası/token claim ile doğru kullanıcı seçilsin.
3. **Token saklamayı sertleştir:** JWT/email için `flutter_secure_storage` kullan, SQLite’da plaintext token tutma.
4. **Hassas logları kaldır/maskle:** `app_cache` ve auth akışında token/email/debug payload loglarını kapat veya maskele.
5. **`app_cache` tek satır kuralını enforce et:** singleton satır modeli için PK/guard ekle, `UPDATE` işlemlerini deterministik hale getir.
6. **Sync hatalarını görünür yap:** silent catch yerine kullanıcıya retry durumu göster; başarısız sync için kuyruk + backoff stratejisi ekle.
7. **API çağrılarında id güvenliği ekle:** metric/profile update çağrılarında server id yoksa request bloklansın.
8. **Kritik testleri yaz:** `SyncDataRepository`, `AuthInterceptor`, `restore/login` ve ID mapping için unit + integration testler ekle.
9. **Dokümantasyonu güncelle:** offline-first + restore + id-mapping kararlarını README/CLAUDE dokümanlarında tek kaynak olarak netleştir.
