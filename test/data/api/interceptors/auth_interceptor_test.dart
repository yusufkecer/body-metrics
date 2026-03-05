import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/api/interceptors/auth_interceptor.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SecureTokenServiceBase>()])
import 'auth_interceptor_test.mocks.dart';

void main() {
  late MockSecureTokenServiceBase mockTokenService;
  late AuthInterceptor interceptor;

  setUp(() {
    mockTokenService = MockSecureTokenServiceBase();
    interceptor = AuthInterceptor();

    if (Locator.sl.isRegistered<SecureTokenServiceBase>()) {
      Locator.sl.unregister<SecureTokenServiceBase>();
    }
    Locator.sl.registerSingleton<SecureTokenServiceBase>(mockTokenService);
  });

  tearDown(() {
    if (Locator.sl.isRegistered<SecureTokenServiceBase>()) {
      Locator.sl.unregister<SecureTokenServiceBase>();
    }
  });

  group('AuthInterceptor.onRequest()', () {
    test('passes auth requests through without token check', () async {
      final options = RequestOptions(path: '/auth/login');
      // pre-call to satisfy internal state
      final handlerCapture = _TestRequestHandler();

      await interceptor.onRequest(options, handlerCapture);

      expect(handlerCapture.nextCalled, true);
      expect(handlerCapture.rejectedError, isNull);
      verifyZeroInteractions(mockTokenService);
    });

    test('adds Authorization header when token exists', () async {
      when(mockTokenService.getToken()).thenAnswer((_) async => 'test-jwt');

      final options = RequestOptions(path: '/users');
      final handler = _TestRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(handler.nextCalled, true);
      expect(options.headers['Authorization'], 'Bearer test-jwt');
    });

    test('rejects request when token is null', () async {
      when(mockTokenService.getToken()).thenAnswer((_) async => null);

      final options = RequestOptions(path: '/users');
      final handler = _TestRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(handler.rejectedError, isNotNull);
      expect(handler.nextCalled, false);
    });

    test('rejects request when token is empty', () async {
      when(mockTokenService.getToken()).thenAnswer((_) async => '');

      final options = RequestOptions(path: '/users');
      final handler = _TestRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(handler.rejectedError, isNotNull);
      expect(handler.nextCalled, false);
    });
  });

  group('AuthInterceptor.onError()', () {
    test('clears session on 401 response', () async {
      when(mockTokenService.clearSession()).thenAnswer((_) async {});

      final options = RequestOptions(path: '/users');
      final response = Response<dynamic>(
        requestOptions: options,
        statusCode: 401,
      );
      final err = DioException(
        requestOptions: options,
        response: response,
        type: DioExceptionType.badResponse,
      );
      final handler = _TestErrorHandler();

      await interceptor.onError(err, handler);

      verify(mockTokenService.clearSession()).called(1);
      expect(handler.nextCalled, true);
    });

    test('does not clear session on non-401 errors', () async {
      final options = RequestOptions(path: '/users');
      final response = Response<dynamic>(
        requestOptions: options,
        statusCode: 500,
      );
      final err = DioException(
        requestOptions: options,
        response: response,
        type: DioExceptionType.badResponse,
      );
      final handler = _TestErrorHandler();

      await interceptor.onError(err, handler);

      verifyNever(mockTokenService.clearSession());
      expect(handler.nextCalled, true);
    });
  });
}

// --- Test helpers ---

class _TestRequestHandler extends RequestInterceptorHandler {
  bool nextCalled = false;
  DioException? rejectedError;

  @override
  void next(RequestOptions options) {
    nextCalled = true;
  }

  @override
  void reject(
    DioException error, [
    bool callFollowingErrorInterceptor = false,
  ]) {
    rejectedError = error;
  }
}

class _TestErrorHandler extends ErrorInterceptorHandler {
  bool nextCalled = false;

  @override
  void next(DioException err) {
    nextCalled = true;
  }
}
