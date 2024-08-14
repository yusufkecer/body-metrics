import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';

import 'package:flutter/material.dart';

@RoutePage(name: 'UserInfoFormView')
class UserInfoForm extends StatefulWidget {
  final String image;
  const UserInfoForm({
    required this.image,
    super.key,
  });

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(appBar: const CustomAppBar());
  }
}
