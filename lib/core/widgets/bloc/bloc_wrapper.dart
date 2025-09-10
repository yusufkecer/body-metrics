import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWrapper<T extends StateStreamableSource<S>, S>
    extends StatelessWidget {
  const BlocWrapper({
    required this.bloc,
    required this.builder,
    super.key,
  });

  final T bloc;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Builder(
        builder: (context) => builder(context, bloc),
      ),
    );
  }
}
