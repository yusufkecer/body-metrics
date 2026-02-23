import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/theme/custom_theme.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/register_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/user_operations.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart';
import 'package:bodymetrics/feature/home/presentation/home.dart';
import 'package:bodymetrics/feature/onboard/presentation/onboard.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mockito/mockito.dart';

class MockOnboardCubit extends Mock implements OnboardCubit {}
class MockLoginCubit extends Mock implements LoginCubit {}
class MockRegisterCubit extends Mock implements RegisterCubit {}
class MockUserCubit extends Mock implements UserCubit {}
class MockUserMetricCubit extends Mock implements UserMetricCubit {}
class MockHomeCardCubit extends Mock implements HomeCardCubit {}
class MockAuthSessionCubit extends Mock implements AuthSessionCubit {}

class _TestHost extends StatelessWidget {
  const _TestHost({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme().theme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: child,
    );
  }
}

Widget _wrapLocalized(Widget child) => AppLocalization(child: _TestHost(child: child));

Future<void> _mockAssets() async {
  const codec = StandardMessageCodec();
  final messenger = ServicesBinding.instance.defaultBinaryMessenger;
  messenger.setMockMessageHandler('flutter/assets', (message) async {
    final key = codec.decodeMessage(message) as String? ?? '';
    if (key.endsWith('.json')) {
      final bytes = Uint8List.fromList(utf8.encode('{"v":"5.7.4","fr":60,"ip":0,"op":1,"w":1,"h":1,"layers":[]}'));
      return ByteData.view(bytes.buffer);
    }
    const transparentImage = <int>[
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
      0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
      0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
      0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41,
      0x54, 0x78, 0x9C, 0x63, 0x60, 0x00, 0x00, 0x00,
      0x02, 0x00, 0x01, 0xE5, 0x27, 0xD4, 0xA2, 0x00,
      0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
      0x42, 0x60, 0x82,
    ];
    final bytes = Uint8List.fromList(transparentImage);
    return ByteData.view(bytes.buffer);
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await _mockAssets();
  });

  tearDown(() async {
    await Locator.sl.reset();
  });

  group('Onboard -> Register -> Home widget flow', () {
    testWidgets('Onboard screen renders introduction structure', (tester) async {
      final onboardCubit = MockOnboardCubit();
      when(onboardCubit.state).thenReturn(const OnboardInitial(currentPage: 0));
      when(onboardCubit.stream).thenAnswer((_) => const Stream<OnboardState>.empty());

      Locator.sl.registerFactory<OnboardCubit>(() => onboardCubit);
      Locator.sl.registerLazySingleton<CustomTheme>(CustomTheme.new);

      await tester.pumpWidget(_wrapLocalized(const Onboard()));
      await tester.pump();

      expect(find.byType(Onboard), findsOneWidget);
      expect(find.byType(IntroductionScreen), findsOneWidget);
    });

    testWidgets('Register screen is shown in user operations flow', (tester) async {
      final loginCubit = MockLoginCubit();
      final registerCubit = MockRegisterCubit();

      when(loginCubit.state).thenReturn(const LoginInitial());
      when(registerCubit.state).thenReturn(const RegisterInitial());
      when(loginCubit.stream).thenAnswer((_) => const Stream<LoginState>.empty());
      when(registerCubit.stream).thenAnswer((_) => const Stream<RegisterState>.empty());

      Locator.sl.registerFactory<LoginCubit>(() => loginCubit);
      Locator.sl.registerFactory<RegisterCubit>(() => registerCubit);

      await tester.pumpWidget(_wrapLocalized(const UserOperations()));
      await tester.pump();

      expect(find.byType(UserOperations), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    });

    testWidgets('Home screen renders with loaded user and base cards', (tester) async {
      final userCubit = MockUserCubit();
      final metricCubit = MockUserMetricCubit();
      final homeCardCubit = MockHomeCardCubit();
      final authSessionCubit = MockAuthSessionCubit();

      const loaded = UserLoaded(
        user: User(id: 1, name: 'Test', surname: 'User', avatar: '', height: 180),
      );

      when(userCubit.state).thenReturn(loaded);
      when(metricCubit.state).thenReturn(const UserMetricInitial());
      when(homeCardCubit.state).thenReturn(const HomeCardInitial());
      when(authSessionCubit.state).thenReturn(const AuthSessionAuthenticated());
      when(authSessionCubit.loadSession()).thenAnswer((_) async {});
      when(metricCubit.getUserMetric(any)).thenAnswer((_) async {});

      when(userCubit.stream).thenAnswer((_) => const Stream<UserState>.empty());
      when(metricCubit.stream).thenAnswer((_) => const Stream<UserMetricState>.empty());
      when(homeCardCubit.stream).thenAnswer((_) => const Stream<HomeCardState>.empty());
      when(authSessionCubit.stream).thenAnswer((_) => const Stream<AuthSessionState>.empty());

      AppUtil.currentUserId = null;
      Locator.sl.registerFactory<UserCubit>(() => userCubit);
      Locator.sl.registerFactory<UserMetricCubit>(() => metricCubit);
      Locator.sl.registerFactory<HomeCardCubit>(() => homeCardCubit);
      Locator.sl.registerFactory<AuthSessionCubit>(() => authSessionCubit);

      await tester.pumpWidget(_wrapLocalized(const Home()));
      await tester.pump();

      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(CustomDrawer), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });
  });
}
