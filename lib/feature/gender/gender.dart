import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/constants/asset_path.dart';
import 'package:bmicalculator/core/constants/product_color.dart';
import 'package:bmicalculator/core/constants/product_pdding.dart';
import 'package:bmicalculator/core/extension/context_extension.dart';
import 'package:bmicalculator/core/extension/gradient_scafflod.dart';
import 'package:bmicalculator/feature/gender/widgets/gender_asset.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage(name: 'GenderView')
class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Gender'),
      ),
      body: Center(
        child: Padding(
          padding: const ProductPadding.ten(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GenderAsset(
                asset: AssetValue.female.value.lottie,
                gender: 'Kadın',
                color: ProductColor().pink,
                icon: FontAwesomeIcons.venus,
              ),
              Divider(color: context.colorScheme.onSurface),
              GenderAsset(
                asset: AssetValue.male.value.lottie,
                gender: 'Erkek',
                color: ProductColor().blue,
                icon: FontAwesomeIcons.mars,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
