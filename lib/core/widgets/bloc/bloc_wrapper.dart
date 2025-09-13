import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWrapper<T extends StateStreamableSource<S>, S>
    extends StatelessWidget {
  const BlocWrapper({
    required this.create,
    required this.builder,
    super.key,
  });

  final T Function(BuildContext) create;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: Builder(
        builder: (context) {
          final bloc = context.read<T>();
          return builder(context, bloc);
        },
      ),
    );
  }
}
