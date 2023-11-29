import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

extension _AppButtonSizeX on AppButtonSize {
  ButtonStyle getButtonStyle(BuildContext context) => switch (this) {
        AppButtonSize.small => context.buttonThemes.primary.none.small,
        _ => context.buttonThemes.primary.none.medium,
      };
}

class TextIconButton extends StatelessWidget {
  const TextIconButton.small({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : _size = AppButtonSize.small;

  const TextIconButton.medium({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : _size = AppButtonSize.medium;

  final Widget text;
  final Widget icon;
  final void Function()? onTap;

  final AppButtonSize _size;

  static getStyle(BuildContext context, {required AppButtonSize size}) {
    return size.getButtonStyle(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      style: _size.getButtonStyle(context),
      onPressed: onTap,
      child: Row(
        children: [
          text,
          const SizedBox(width: 4.0),
          icon,
        ],
      ),
    );
  }
}
