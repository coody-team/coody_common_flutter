import 'package:flutter/material.dart';

extension BorderX on Border {
  /// [BorderSide.none]이 아닌 [BorderSide]에 신규 값 적용하여 Border 객체 복제
  copyWith({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return Border(
      top: top != BorderSide.none
          ? top.copyWith(color: color, width: width, style: style, strokeAlign: strokeAlign)
          : BorderSide.none,
      bottom: bottom != BorderSide.none
          ? bottom.copyWith(color: color, width: width, style: style, strokeAlign: strokeAlign)
          : BorderSide.none,
      left: left != BorderSide.none
          ? left.copyWith(color: color, width: width, style: style, strokeAlign: strokeAlign)
          : BorderSide.none,
      right: right != BorderSide.none
          ? right.copyWith(color: color, width: width, style: style, strokeAlign: strokeAlign)
          : BorderSide.none,
    );
  }
}
