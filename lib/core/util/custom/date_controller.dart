import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DateController extends TextEditingController {
  DateController({String format = 'dd/MM/yyyy'}) : _formatter = DateFormat(format);
  final DateFormat _formatter;

  void setDate(DateTime date) {
    text = _formatter.format(date);
  }
}
