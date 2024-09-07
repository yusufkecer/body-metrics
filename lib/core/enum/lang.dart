import 'package:flutter/material.dart';

enum Lang {
  tr(Locale('tr', 'TR')),

  en(Locale('en', 'US'));

  final Locale locale;
  // ignore: sort_constructors_first
  const Lang(this.locale);
}
