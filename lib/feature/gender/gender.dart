import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';

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
        actions: [
          IconButton(
            onPressed: () async {
              await Locator.instance.get<UserCache>().createDatabase();
            },
            icon: const Icon(Icons.abc),
          ),
        ],
        title: const Text('Gender'),
      ),
    );
  }
}
