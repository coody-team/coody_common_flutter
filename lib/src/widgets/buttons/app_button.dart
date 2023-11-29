import 'package:coody_common_flutter/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppButton extends ButtonStyleButton {
  const AppButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required super.child,
  });

  factory AppButton.withIcon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    MaterialStatesController? statesController,
    required Widget icon,
    required Widget label,
  }) = _AppButtonWithIcon;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return context.buttonThemes.primary.filled.medium;
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return AppButtonTheme.of(context).style;
  }
}

class AppButtonThemeData with Diagnosticable {
  const AppButtonThemeData({this.style});

  final ButtonStyle? style;

  static AppButtonThemeData? lerp(AppButtonThemeData? a, AppButtonThemeData? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return AppButtonThemeData(
      style: ButtonStyle.lerp(a?.style, b?.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AppButtonThemeData && other.style == style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ButtonStyle>('style', style, defaultValue: null));
  }
}

class AppButtonTheme extends InheritedTheme {
  const AppButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final AppButtonThemeData data;

  static AppButtonThemeData of(BuildContext context) {
    final AppButtonTheme? buttonTheme =
        context.dependOnInheritedWidgetOfExactType<AppButtonTheme>();
    return buttonTheme?.data ?? AppButtonThemeData(style: appButtonBaseStyle);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(AppButtonTheme oldWidget) => data != oldWidget.data;
}

class _AppButtonWithIcon extends AppButton {
  _AppButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _AppButtonWithIconChild(icon: icon, label: label),
        );
}

class _AppButtonWithIconChild extends StatelessWidget {
  const _AppButtonWithIconChild({required this.label, required this.icon});

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: 4.0), Flexible(child: label)],
    );
  }
}
