import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

part 'profile_image_picker_model.dart';

@RoutePage(name: 'ProfileImagePickerView')
class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> with ProfileImagePickerModel {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        title: const Text('Profil Resmi Seç'),
        actions: [
          TextButton(
            onPressed: () {
              context.pushRoute(const GenderView());
            },
            child: Text(
              'Atla',
              style: context.textTheme.titleMedium!.copyWith(
                color: ProductColor().white,
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: profileImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const ProductPadding.ten(),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                child: Image.asset(
                  profileImages[index].profile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
