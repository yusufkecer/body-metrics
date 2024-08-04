import 'package:auto_route/auto_route.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.abc),
          ),
        ],
        title: const Text('Gender'),
      ),
    );
  }
}
