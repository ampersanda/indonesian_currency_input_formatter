library indonesian_currency_formatter;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IndonesianCurrencyInputFormatter extends TextInputFormatter {
  final double minValue, maxValue;

  static double parse(String value) {
    if (value == null || value.trim() == '') {
      return null;
    }

    value = value.replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', '.');
    try {
      return double.parse(value.replaceAll('Rp', ''));
    } catch (e) {
      return null;
    }
  }

  static String format(String value) {
    final formatter = NumberFormat('Rp ###,###.###', 'id-ID');
    return formatter.format(parse(value));
  }

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      var fallback = '0';
      return newValue.copyWith(
          text: format(fallback),
          selection: TextSelection.collapsed(offset: format(fallback).length));
    }

    double value = parse(newValue.text);

    if (minValue != null && maxValue != null) {
      if (value >= maxValue) {
        value = maxValue;
      } else if (value <= minValue) {
        value = minValue;
      }
    }

    String newText = format(value.toInt().toString());

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  IndonesianCurrencyInputFormatter([this.minValue, this.maxValue]);
}
