import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/domain/use_case/save_avatar_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

part 'avatar_picker_model.dart';

@RoutePage(name: 'AvatarPickerView')
@immutable
final class AvatarPicker extends StatefulWidget {
  const AvatarPicker({super.key});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker>
    with DialogUtil, SaveAppMixin, _AvatarPickerModel {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.register_select_profile_picture,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            grid(),
            VerticalSpace.m(),
            if (!AppUtil.hasSession) ...[
              Text(
                LocaleKeys.register_or.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              VerticalSpace.m(),
              SizedBox(
                width: double.infinity,
                child: CustomFilled(
                  text: LocaleKeys.auth_register,
                  onPressed: () async {
                    await context.router.push(const UserOperationsView());
                  },
                ),
              ),
            ],
            VerticalSpace.m(),
          ],
        ),
      ),
    );
  }

  GridView grid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: avatarList.length,
      gridDelegate: const GridDelegate.profileImageGrid(),
      itemBuilder: (context, index) {
        return Padding(
          padding: ProductPadding.ten(),
          child: InkWell(
            onTap: () => _tappedAvatar(index),
            child: CircleAvatar(
              child: Image.asset(avatarList[index], fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
