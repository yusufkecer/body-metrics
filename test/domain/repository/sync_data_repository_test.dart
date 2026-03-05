import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/api/error/api_exception.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/repository/sync_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

@GenerateNiceMocks([
  MockSpec<UserApiServiceBase>(),
  MockSpec<MetricsApiServiceBase>(),
])
import 'sync_data_repository_test.mocks.dart';

void main() {
  late MockUserApiServiceBase mockUserApi;
  late MockMetricsApiServiceBase mockMetricsApi;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    mockUserApi = MockUserApiServiceBase();
    mockMetricsApi = MockMetricsApiServiceBase();
    AppUtil.currentUserId = null;
    AppUtil.syncPending = false;
    // Delete the shared database so each test starts clean.
    final dbPath = await getDatabasesPath();
    await deleteDatabase('$dbPath/${AppUtil.databasePath}');
  });

  Future<SyncDataRepository> _buildRepo() async {
    final userCache = UserCache();
    final userMetricsCache = UserMetricsCache();
    final appCache = AppCache();

    final userDb = await userCache.initializeDatabase();
    if (userDb != null) await userCache.initializeTable(userDb, 1);

    final metricsDb = await userMetricsCache.initializeDatabase();
    if (metricsDb != null) {
      await userMetricsCache.initializeTable(metricsDb, 1);
    }

    final appDb = await appCache.initializeDatabase();
    if (appDb != null) await appCache.initializeTable(appDb, 1);

    return SyncDataRepository(
      userCache,
      userMetricsCache,
      mockUserApi,
      mockMetricsApi,
      appCache,
    );
  }

  /// Inserts a user and returns the local id.
  Future<int> _insertUser(String name) async {
    final userCache = UserCache();
    final db = await userCache.initializeDatabase();
    if (db == null) return 0;
    await userCache.initializeTable(db, 1);
    final id = await userCache.insert(db, {
      'name': name,
      'surname': 'User',
      'gender': 'male',
      'height': 175,
      'birthOfDate': '1990-01-01',
    });
    return id;
  }

  group('sync()', () {
    test('skips when syncPending is false', () async {
      AppUtil.syncPending = false;
      final repo = await _buildRepo();

      await repo.sync();

      verifyZeroInteractions(mockUserApi);
      verifyZeroInteractions(mockMetricsApi);
    });

    test('skips when syncPending is true but no user in DB', () async {
      AppUtil.syncPending = true;
      AppUtil.currentUserId = null;
      final repo = await _buildRepo();

      await repo.sync();

      verifyZeroInteractions(mockUserApi);
      verifyZeroInteractions(mockMetricsApi);
    });

    test('uploads user and marks sync complete when createUser returns 201',
        () async {
      AppUtil.syncPending = true;
      final userId = await _insertUser('Sync');
      AppUtil.currentUserId = userId;
      final repo = await _buildRepo();

      when(mockUserApi.createUser(any)).thenAnswer((_) async => {'id': 99});
      when(mockMetricsApi.getMetricsByUserId(99)).thenAnswer((_) async => []);

      await repo.sync();

      verify(mockUserApi.createUser(any)).called(1);
      verify(mockMetricsApi.getMetricsByUserId(99)).called(1);
      expect(AppUtil.syncPending, false);
    });

    test('falls back to getAllUsers on 409 conflict and completes sync',
        () async {
      AppUtil.syncPending = true;
      final userId = await _insertUser('Conflict');
      AppUtil.currentUserId = userId;
      final repo = await _buildRepo();

      when(mockUserApi.createUser(any)).thenThrow(
        const ApiException(message: 'Conflict', statusCode: 409),
      );
      when(mockUserApi.getAllUsers()).thenAnswer(
        (_) async => [
          {'id': 88},
        ],
      );
      when(mockMetricsApi.getMetricsByUserId(88)).thenAnswer((_) async => []);

      await repo.sync();

      verify(mockUserApi.createUser(any)).called(1);
      verify(mockUserApi.getAllUsers()).called(1);
      verify(mockMetricsApi.getMetricsByUserId(88)).called(1);
      expect(AppUtil.syncPending, false);
    });

    test('keeps syncPending true when a metric upload fails', () async {
      AppUtil.syncPending = true;
      final userId = await _insertUser('MetricFail');
      AppUtil.currentUserId = userId;

      // Insert a metric so there is something to upload.
      final metricsCache = UserMetricsCache();
      final metricsDb = await metricsCache.initializeDatabase();
      if (metricsDb != null) {
        await metricsCache.initializeTable(metricsDb, 1);
        await metricsCache.insert(
          metricsDb,
          UserMetric(
            userId: userId,
            date: '2024-01-01',
            weight: 70.0,
            height: 175,
            bmi: 22.86,
            createdAt: '2024-01-01T00:00:00.000Z',
          ),
        );
      }

      final repo = await _buildRepo();

      when(mockUserApi.createUser(any)).thenAnswer((_) async => {'id': 77});
      when(mockMetricsApi.createMetric(any, any)).thenThrow(
        Exception('Upload failed'),
      );

      await repo.sync();

      expect(AppUtil.syncPending, true);
    });
  });

  group('restore()', () {
    test('skips when currentUserId is already set', () async {
      AppUtil.currentUserId = 42;
      final repo = await _buildRepo();

      await repo.restore();

      verifyZeroInteractions(mockUserApi);
      verifyZeroInteractions(mockMetricsApi);
    });

    test('uses existing local user without calling server', () async {
      AppUtil.currentUserId = null;
      await _insertUser('Existing');
      final repo = await _buildRepo();

      await repo.restore();

      verifyZeroInteractions(mockUserApi);
      expect(AppUtil.currentUserId, isNotNull);
    });

    test('downloads user from server when no local user exists', () async {
      AppUtil.currentUserId = null;
      final repo = await _buildRepo();

      when(mockUserApi.getAllUsers()).thenAnswer(
        (_) async => [
          {
            'id': 55,
            'name': 'Server',
            'surname': 'User',
            'gender': 0,
            'avatar': 'pr1',
            'height': 175,
            'birthOfDate': '1990-01-01',
          },
        ],
      );
      when(mockMetricsApi.getMetricsByUserId(55)).thenAnswer((_) async => []);

      await repo.restore();

      verify(mockUserApi.getAllUsers()).called(1);
      expect(AppUtil.currentUserId, isNotNull);
    });

    test('does nothing when server returns no users', () async {
      AppUtil.currentUserId = null;
      final repo = await _buildRepo();

      when(mockUserApi.getAllUsers()).thenAnswer((_) async => []);

      await repo.restore();

      verify(mockUserApi.getAllUsers()).called(1);
      expect(AppUtil.currentUserId, isNull);
    });
  });
}
