import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class SyncLocalDataUseCase {
  const SyncLocalDataUseCase(
    this._userCache,
    this._userMetricsCache,
    this._userApiService,
    this._metricsApiService,
  );

  final UserCache _userCache;
  final UserMetricsCache _userMetricsCache;
  final UserApiService _userApiService;
  final MetricsApiService _metricsApiService;

  Future<void> execute() async {
    final userId = AppUtil.currentUserId;
    if (userId == null) {
      'SyncLocalDataUseCase: no current user, skipping sync'.w();
      return;
    }

    try {
      // 1. Get local user
      final userDb = await _userCache.initializeDatabase();
      final localUser =
          (await _userCache.select(userDb, {'id': userId}))?.users?.firstOrNull;

      if (localUser == null) {
        'SyncLocalDataUseCase: local user not found, skipping sync'.w();
        return;
      }

      // 2. Create user on server → get server user ID
      final serverUserJson =
          await _userApiService.createUser(_buildUserPayload(localUser));
      final serverUserId = (serverUserJson['id'] as num?)?.toInt();

      if (serverUserId == null) {
        'SyncLocalDataUseCase: server returned no user ID'.e();
        return;
      }

      'SyncLocalDataUseCase: user synced, serverUserId=$serverUserId'.log();

      // 3. Get local metrics
      final metricsDb = await _userMetricsCache.initializeDatabase();
      final localMetrics =
          (await _userMetricsCache.select(metricsDb, {'userId': userId}))
              ?.userMetrics ??
          [];

      'SyncLocalDataUseCase: uploading ${localMetrics.length} local metrics'.log();

      // 4. Push ALL local metrics to server — track failures
      var allUploaded = true;
      for (final metric in localMetrics) {
        try {
          await _metricsApiService.createMetric(
            serverUserId,
            _buildUploadPayload(metric),
          );
        } catch (e) {
          allUploaded = false;
          'SyncLocalDataUseCase: upload failed id=${metric.id}: $e'.e();
        }
      }

      // 5. If any upload failed → stop here, keep local data safe
      if (!allUploaded) {
        'SyncLocalDataUseCase: upload incomplete, keeping local data'.w();
        return;
      }

      // 6. All uploads succeeded → wipe local metrics for this user
      final wipeDb = await _userMetricsCache.initializeDatabase();
      await _userMetricsCache.deleteAllByUserId(wipeDb, userId);
      'SyncLocalDataUseCase: local metrics wiped'.log();

      // 7. Re-fetch from server → write to local (home screen reads local)
      final serverMetrics =
          await _metricsApiService.getMetricsByUserId(serverUserId);

      for (final json in serverMetrics) {
        try {
          final payload = _buildLocalPayload(json, userId);
          final db = await _userMetricsCache.initializeDatabase();
          await _userMetricsCache.insert(db, UserMetric.fromJson(payload));
        } catch (e) {
          'SyncLocalDataUseCase: local write failed: $e'.e();
        }
      }

      'SyncLocalDataUseCase: sync complete — ${serverMetrics.length} metrics cached'.log();
    } catch (e) {
      'SyncLocalDataUseCase error: $e'.e();
    }
  }

  Json _buildUserPayload(User user) => {
    'name': user.name,
    'surname': user.surname,
    'gender': user.gender?.index,
    'avatar': user.avatar,
    'height': user.height,
    'birthOfDate': user.birthOfDate,
  };

  /// Payload sent to the server — no local id, server assigns its own.
  Json _buildUploadPayload(UserMetric metric) => {
    'date': metric.date ?? '',
    'weight': metric.weight,
    'height': metric.height ?? 0,
    'bmi': metric.bmi ?? 0.0,
    'weight_diff': metric.weightDiff,
    'body_metric': metric.userMetric?.name,
    'created_at': metric.createdAt,
  };

  /// Payload written to local SQLite after re-fetch.
  /// - id omitted → SQLite auto-increments (no server id collision)
  /// - user_id mapped to local userId (home screen queries by local id)
  Json _buildLocalPayload(Json serverJson, int localUserId) => {
    'user_id': localUserId,
    'date': serverJson['date'] ?? '',
    'weight': serverJson['weight'],
    'height': serverJson['height'] ?? 0,
    'bmi': serverJson['bmi'] ?? 0.0,
    'weight_diff': serverJson['weight_diff'],
    'body_metric': serverJson['body_metric'],
    'created_at': serverJson['created_at'],
  };
}
