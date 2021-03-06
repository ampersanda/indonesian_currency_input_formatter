library indonesian_currency_formatter;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IndonesianCurrencyInputFormatter extends TextInputFormatter {
  final double maxValue;

  static double parse(String value,
      [String commaDelimiter = ',', String thousandDelimiter = '.']) {
    if (commaDelimiter == thousandDelimiter) {
      throw '"commaDelimiter" and "thousandDelimiter" can not be same';
    }

    if (value == null || value.trim() == '') {
      return null;
    }

    value = value
        .replaceAll('Rp', '')
        .replaceAll(thousandDelimiter, '')
        .replaceAll(commaDelimiter, '.');
    try {
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  static String format(String value,
      [String parseCommaDelimiter = ',', String thousandParseDelimiter = '.']) {
    final formatter = NumberFormat('Rp ###,###.###', 'id-ID');
    return formatter.format(
      parse(
        value,
        parseCommaDelimiter,
        thousandParseDelimiter,
      ),
    );
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

    if (maxValue != null) {
      if (value >= maxValue) {
        value = maxValue;
      }
//      else if (value <= minValue) {
//        value = minValue;
//      }
    }

    String newText = format(value.toInt().toString());

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  IndonesianCurrencyInputFormatter({this.maxValue});
}
