import 'dart:convert';
import 'dart:typed_data';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/theme/custom_theme.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/presentation/avatar_picker.dart';
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart';
import 'package:bodymetrics/feature/gender/presentation/cubit/gender_cubit/gender_cubit.dart';
import 'package:bodymetrics/feature/gender/presentation/gender.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit.dart';
import 'package:bodymetrics/feature/height/presentation/height_picker.dart';
import 'package:bodymetrics/feature/splash/presentation/splash.dart';
import 'package:bodymetrics/feature/user_general_info/presentation/cubit/user_info_form_cubit.dart';
import 'package:bodymetrics/feature/user_general_info/presentation/user_general_info.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart';
import 'package:bodymetrics/feature/weight_picker/presentation/weight_picker.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGenderCubit extends Mock implements GenderCubit {}
class MockSaveGenderUseCase extends Mock implements SaveGenderUseCase {}
class MockUserInfoFormCubit extends Mock implements UserInfoFormCubit {}
class MockUserUseCase extends Mock implements UserUseCase {}
class MockSaveWeightUseCase extends Mock implements SaveWeightUseCase {}
class MockCalculateBmiUseCase extends Mock implements CalculateBmiUseCase {}

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

  testWidgets('AvatarPicker view renders grid and actions', (tester) async {
    AppUtil.hasSession = false;

    await tester.pumpWidget(_wrapLocalized(const AvatarPicker()));
    await tester.pump();

    expect(find.byType(AvatarPicker), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(CircleAvatar), findsAtLeastNWidgets(1));
    expect(find.byType(CustomFilled), findsOneWidget);
  });

  testWidgets('Gender view renders two selectable assets', (tester) async {
    final useCase = MockSaveGenderUseCase();
    final cubit = GenderCubit(useCase);

    Locator.sl.registerFactory<GenderCubit>(() => cubit);

    await tester.pumpWidget(_wrapLocalized(const Gender()));
    await tester.pump();

    expect(find.byType(Gender), findsOneWidget);
    expect(find.byType(CheckboxListTile), findsNWidgets(2));
    expect(find.byIcon(ProductIcon.venus.icon), findsOneWidget);
    expect(find.byIcon(ProductIcon.mars.icon), findsOneWidget);
  });

  testWidgets('HeightPicker view renders ruler and lottie area', (tester) async {
    Locator.sl.registerFactory<HeightSelectorCubit>(HeightSelectorCubit.new);

    await tester.pumpWidget(_wrapLocalized(const HeightPicker(gender: GenderValue.male)));
    await tester.pump();

    expect(find.byType(HeightPicker), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
  });

  testWidgets('UserGeneralInfo view renders avatar and form fields', (tester) async {
    final cubit = MockUserInfoFormCubit();
    when(cubit.state).thenReturn(const UserInfoFormCubitFormEmpty(isFormEmpty: true));
    when(cubit.stream).thenAnswer((_) => const Stream<UserInfoFormCubitState>.empty());

    Locator.sl.registerFactory<UserInfoFormCubit>(() => cubit);

    await tester.pumpWidget(_wrapLocalized(const UserGeneralInfo(avatar: 'assets/images/profiles/1.png')));
    await tester.pump();

    expect(find.byType(UserGeneralInfo), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(CustomFilled), findsOneWidget);
  });

  testWidgets('WeightPicker view renders indicator and wheel pickers', (tester) async {
    final userUseCase = MockUserUseCase();
    final saveWeightUseCase = MockSaveWeightUseCase();
    final calculateBmiUseCase = MockCalculateBmiUseCase();

    when(userUseCase.getCurrentUser()).thenAnswer((_) async => const User(id: 1, height: 180));
    when(calculateBmiUseCase.executeWithParams(params: anyNamed('params'))).thenAnswer((_) async => 22.0);

    Locator.sl.registerFactory<WeightPickerCubit>(
      () => WeightPickerCubit(userUseCase, saveWeightUseCase, calculateBmiUseCase),
    );

    await tester.pumpWidget(_wrapLocalized(const WeightPicker()));
    await tester.pump();

    expect(find.byType(WeightPicker), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ListWheelScrollView), findsNWidgets(2));
  });

  testWidgets('Splash view renders placeholder widget', (tester) async {
    await tester.pumpWidget(_wrapLocalized(const Splash()));
    await tester.pump();

    expect(find.byType(Splash), findsOneWidget);
    expect(find.byType(SizedBox), findsWidgets);
  });
}
