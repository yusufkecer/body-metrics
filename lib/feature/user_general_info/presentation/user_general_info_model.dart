part of 'user_general_info.dart';

mixin _UserGeneralInfoModel on State<_UserInfoFormBody>, DialogUtil<_UserInfoFormBody>, SaveAppMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final DateController _birthOfDateController = DateController();
  late final UserInfoFormCubit _cubit = context.read<UserInfoFormCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _birthOfDateController.dispose();

    super.dispose();
  }

  Future<void> _pushToGender() async {
    await context.pushRoute(const GenderView());
  }

  Future<void> _createProfile() async {
    _formKey.currentState?.validate();
    final birthDay = _birthOfDateController.text.toYMD;
    final user = User(
      name: _nameController.text,
      surname: _surnameController.text,
      birthOfDate: birthDay,
    );
    await _cubit.createProfile(user);
  }

  void _openDatePicker() {
    showDatePicker(
      barrierColor: ProductColor.instance.seedFourTenths,
      context: context,
      initialDate: ProductDateTime.birthInitialDate(),
      firstDate: ProductDateTime.birthLastDate(),
      lastDate: ProductDateTime.now(),
    ).then((value) {
      if (value == null) return;
      _birthOfDateController.setDate(value);
    });
  }

  void _formListener() {
    final isFormFilled = _checkFields();
    context.read<UserInfoFormCubit>().setFormEmpty(param: isFormFilled);
  }

  bool _checkFields() {
    return _nameController.text.formNotEmpty &&
        _birthOfDateController.text.formNotEmpty &&
        _surnameController.text.formNotEmpty;
  }

  String? _formValidator(String? value, String? errorText) {
    if (value?.checkForm ?? false) return null;
    return errorText?.tr();
  }

  String? _birthDateValidator(String? value, String? errorText) {
    if (value?.checkDateForm ?? false) return null;
    return errorText?.tr();
  }

  Future<void> _didPop({required bool isFormEmpty}) async {
    if (isFormEmpty) {
      await context.maybePop();
      return;
    }

    final result = await confirmDialog(LocaleKeys.dialog_progress_lost.tr());

    if (!mounted || (result.isNotNull && !result!)) return;

    context.read<UserInfoFormCubit>().setFormEmpty(param: true);

    await Future<void>.delayed(Duration.zero);
    if (mounted) await context.maybePop();
  }
}
