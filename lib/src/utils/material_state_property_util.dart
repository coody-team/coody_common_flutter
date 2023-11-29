import 'package:flutter/material.dart';

abstract class MaterialStatePropertyUtil {
  static MaterialStateProperty<T> simple<T>({required T enabled, required T disabled}) =>
      MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) return disabled;
        return enabled;
      });
}
