import 'package:flutter/material.dart';

enum Lang {
  tr(Locale('tr', 'TR')),

  en(Locale('en', 'US'));

  final Locale locale;

  const Lang(this.locale);
}
