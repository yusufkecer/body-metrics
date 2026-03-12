import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DateController extends TextEditingController {
  DateController({String format = 'dd/MM/yyyy'}) : _format = format;
  final String _format;

  void setDate(DateTime date, {String localeCode = 'en'}) {
    text = DateFormat(_format, localeCode).format(date);
  }
}
