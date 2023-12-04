import 'package:flutter/material.dart';

extension TextStyleX on TextStyle {
  double? get textHeight {
    if (fontSize == null || height == null) return null;
    return fontSize! * height!;
  }
}
