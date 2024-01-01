import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ReorderableListViewUtil {
  static Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = standardEasing.transform(animation.value);
        final double scale = lerpDouble(1, 1.03, animValue)!;
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: child,
    );
  }
}
