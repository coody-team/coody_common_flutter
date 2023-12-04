import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool isSameMonth(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month;
}

extension DateTimeX on DateTime {
  String format(DateFormat formatter) {
    final formatted = formatter.format(this);

    final cleaned = formatted.replaceAll(' ', '');
    if (cleaned.characters.last == '.') {
      return cleaned.substring(0, cleaned.length - 1);
    }
    return cleaned;
  }

  DateTime get firstDay => DateTime(year, month);

  DateTime get lastDay => DateTime(year, month + 1).subtract(Duration(days: 1));
}
