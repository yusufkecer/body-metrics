import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class SyncDataRepository implements SyncDataRepositoryBase {
  const SyncDataRepository(
    this._userCache,
    this._userMetricsCache,
    this._userApiService,
    this._metricsApiService,
  );

  final UserCache _userCache;
  final UserMetricsCache _userMetricsCache;
  final UserApiServiceBase _userApiService;
  final MetricsApiServiceBase _metricsApiService;

  @override
  Future<void> sync() async {
    final userId = AppUtil.currentUserId;
    if (userId == null) {
      'SyncDataRepository: no current user, skipping sync'.w();
      return;
    }

    try {
      final userDb = await _userCache.initializeDatabase();
      final localUser = (await _userCache.select(userDb, {
        'id': userId,
      }))?.users?.firstOrNull;

      if (localUser == null) {
        'SyncDataRepository: local user not found, skipping sync'.w();
        return;
      }

      final serverUserJson = await _userApiService.createUser(
        _buildUserPayload(localUser),
      );
      final serverUserId = (serverUserJson['id'] as num?)?.toInt();

      if (serverUserId == null) {
        'SyncDataRepository: server returned no user ID'.e();
        return;
      }

      'SyncDataRepository: user synced, serverUserId=$serverUserId'.log();

      final metricsDb = await _userMetricsCache.initializeDatabase();
      final localMetrics =
          (await _userMetricsCache.select(metricsDb, {
            'userId': userId,
          }))?.userMetrics ??
          [];

      'SyncDataRepository: uploading ${localMetrics.length} local metrics'
          .log();

      var allUploaded = true;
      for (final metric in localMetrics) {
        try {
          await _metricsApiService.createMetric(
            serverUserId,
            _buildUploadPayload(metric),
          );
        } catch (e) {
          allUploaded = false;
          'SyncDataRepository: upload failed id=${metric.id}: $e'.e();
        }
      }

      if (!allUploaded) {
        'SyncDataRepository: upload incomplete, keeping local data'.w();
        return;
      }

      final wipeDb = await _userMetricsCache.initializeDatabase();
      await _userMetricsCache.deleteAllByUserId(wipeDb, userId);
      'SyncDataRepository: local metrics wiped'.log();

      final serverMetrics = await _metricsApiService.getMetricsByUserId(
        serverUserId,
      );

      for (final json in serverMetrics) {
        try {
          final payload = _buildLocalPayload(json, userId);
          final db = await _userMetricsCache.initializeDatabase();
          await _userMetricsCache.insert(db, UserMetric.fromJson(payload));
        } catch (e) {
          'SyncDataRepository: local write failed: $e'.e();
        }
      }

      'SyncDataRepository: sync complete — ${serverMetrics.length} metrics cached'
          .log();
    } catch (e) {
      'SyncDataRepository error: $e'.e();
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
