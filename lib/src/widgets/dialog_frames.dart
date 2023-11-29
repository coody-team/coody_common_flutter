import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class _DialogBase extends StatelessWidget {
  const _DialogBase({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.gray2,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          ),
          padding: const EdgeInsets.all(24.0),
          child: child,
        ),
      ),
    );
  }
}

enum _DialogFrameStyle {
  standard,
  alert;

  ButtonStyle getRightButtonStyle(BuildContext context) => switch (this) {
        standard => context.buttonThemes.primary.filled.medium,
        alert => context.buttonThemes.alert.filled.medium,
      };
}

class DialogFrame extends StatelessWidget {
  const DialogFrame({
    super.key,
    required this.title,
    required this.body,
    required this.rightButton,
    this.leftButton,
  }) : _style = _DialogFrameStyle.standard;

  const DialogFrame.alert({
    super.key,
    required this.title,
    required this.body,
    required this.rightButton,
    this.leftButton,
  }) : _style = _DialogFrameStyle.alert;

  final Widget title;
  final Widget body;
  final Widget rightButton;
  final Widget? leftButton;

  final _DialogFrameStyle _style;

  @override
  Widget build(BuildContext context) {
    return _DialogBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle(
            style: context.typography.title1.emphasized,
            child: title,
          ),
          const SizedBox(height: 8.0),
          DefaultTextStyle(
            style: context.typography.body2.normal,
            child: body,
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              if (leftButton != null) ...[
                Expanded(
                  child: AppButtonTheme(
                    data: AppButtonThemeData(
                      style: context.buttonThemes.secondary.filled.medium,
                    ),
                    child: leftButton!,
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
              Expanded(
                child: AppButtonTheme(
                  data: AppButtonThemeData(
                    style: _style.getRightButtonStyle(context),
                  ),
                  child: rightButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
