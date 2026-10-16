import 'dart:io';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/feature/splash/domain/repository/splash_app_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late UserCache userCache;
  late UserMetricsCache userMetricsCache;
  late AppCache appCache;
  late SplashAppRepository repository;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final tempDir = await Directory.systemTemp.createTemp('splash_app_test');
    await databaseFactory.setDatabasesPath(tempDir.path);
  });

  setUp(() async {
    final dbPath = await getDatabasesPath();
    await deleteDatabase('$dbPath/${AppUtil.databasePath}');

    userCache = UserCache();
    userMetricsCache = UserMetricsCache();
    appCache = AppCache();

    final db = await appCache.initializeDatabase();
    await appCache.initializeTable(db!, 1);
    await userMetricsCache.initializeTable(db, 1);
    await userCache.initializeTable(db, 1);
    await appCache.closeDb();

    repository = SplashAppRepository(appCache, userCache);
  });

  Future<int> insertUser({bool withMetric = false}) async {
    final db = await userCache.initializeDatabase();
    final id = await userCache.insert(db, {'avatar': 'pr1', 'height': 175});
    if (withMetric) {
      final metricsDb = await userMetricsCache.initializeDatabase();
      await userMetricsCache.insert(
        metricsDb,
        UserMetric(
          userId: id,
          date: '01-01-2026',
          weight: 70,
          height: 175,
          bmi: 22.86,
          createdAt: '2026-01-01T00:00:00.000Z',
        ),
      );
    }
    return id;
  }

  Future<void> persistAppModel(AppModel model) async {
    final db = await appCache.initializeDatabase();
    await appCache.update(db, model.toJson());
  }

  Future<List<int?>> userIds() async {
    final db = await userCache.initializeDatabase();
    final users = await userCache.selectAll(db);
    return users?.users?.map((user) => user.id).toList() ?? [];
  }

  test('deletes users without metrics and keeps completed ones', () async {
    final completed = await insertUser(withMetric: true);
    await insertUser();

    await repository.executeWithParams();

    expect(await userIds(), [completed]);
  });

  test('keeps the active user when the profile is completed', () async {
    await insertUser(withMetric: true);
    final active = await insertUser(withMetric: true);
    await persistAppModel(
      AppModel(isCompleteOnboard: true, activeUser: active),
    );

    final result = await repository.executeWithParams();

    expect(result, AppModel(isCompleteOnboard: true, activeUser: active));
  });

  test(
    'falls back to a completed user when the active one is incomplete',
    () async {
      final completed = await insertUser(withMetric: true);
      final incomplete = await insertUser();
      await persistAppModel(
        AppModel(isCompleteOnboard: true, activeUser: incomplete),
      );

      final result = await repository.executeWithParams();

      expect(result, AppModel(isCompleteOnboard: true, activeUser: completed));
    },
  );

  test('returns no active user when registration was abandoned', () async {
    final incomplete = await insertUser();
    await persistAppModel(
      AppModel(isCompleteOnboard: true, activeUser: incomplete),
    );

    final result = await repository.executeWithParams();

    expect(result, const AppModel(isCompleteOnboard: true));
    expect(await userIds(), isEmpty);
  });
}
