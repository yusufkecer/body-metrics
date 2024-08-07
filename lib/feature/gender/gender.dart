import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/constants/asset_path.dart';
import 'package:bmicalculator/core/constants/product_color.dart';
import 'package:bmicalculator/core/constants/product_pdding.dart';
import 'package:bmicalculator/core/extension/context_extension.dart';
import 'package:bmicalculator/feature/gender/widgets/gender_asset.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'GenderPage')
class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender'),
      ),
      body: Center(
        child: Padding(
          padding: const ProductPadding.ten(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GenderAsset(asset: AssetValue.womenGif.value.gif, gender: "Kadın", color: ProductColor().pink),
              Divider(color: context.colorScheme.onSurface),
              GenderAsset(asset: AssetValue.manGif.value.gif, gender: "Erkek", color: ProductColor().blue),
            ],
          ),
        ),
      ),
    );
  }
}
