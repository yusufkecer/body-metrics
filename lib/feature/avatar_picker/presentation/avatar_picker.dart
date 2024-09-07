import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'avatar_picker_model.dart';
part 'widgets/util_button.dart';

@RoutePage(name: 'AvatarPickerView')
@immutable
final class AvatarPicker extends StatefulWidget {
  const AvatarPicker({
    super.key,
    this.canSkip = true,
  });

  final bool canSkip;

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> with _AvatarPickerModel {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _zoomDrawerController,
      borderRadius: 50,
      menuBackgroundColor: ProductColor().seedColor,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      duration: const Duration(milliseconds: 100),
      menuScreenTapClose: true,
      mainScreenTapClose: true,
      showShadow: true,
      shadowLayer2Color: ProductColor().drawerBg,
      shadowLayer1Color: ProductColor().drawerBg2,
      menuScreen: const SafeArea(
        child: Scaffold(
          body: Column(
            children: [Text('asdf')],
          ),
        ),
      ),
      mainScreen: GradientScaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              _zoomDrawerController.toggle!();
            },
            icon: const Icon(Icons.menu),
          ),
          title: LocaleKeys.register_select_profile_picture.tr(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              grid(),
              utilButtons(),
              VerticalSpace.m(),
            ],
          ),
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
            onTap: () => _addNewProfile(index),
            child: CircleAvatar(
              child: Image.asset(
                avatarList[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget utilButtons() {
    return widget.canSkip
        ? Column(
            children: [
              VerticalSpace.xs(),
              UtilButton(
                icon: FontAwesomeIcons.arrowRight,
                onPressed: _onTapSkip,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
