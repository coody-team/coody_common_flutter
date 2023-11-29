import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

extension _AppButtonSizeX on AppButtonSize {
  ButtonStyle getButtonStyle(BuildContext context) => switch (this) {
        AppButtonSize.xlarge => context.buttonThemes.primary.outlined.xlarge.copyWith(
            padding: MaterialStatePropertyAll(
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            ),
          ),
        _ => context.buttonThemes.primary.outlined.large.copyWith(
            padding: MaterialStatePropertyAll(
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
            ),
          ),
      }
          .copyWith(
        alignment: Alignment.centerLeft,
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 0.0)),
      );
}

class LeftAlignedAppButton extends StatelessWidget {
  const LeftAlignedAppButton.large({
    super.key,
    required this.text,
    this.icon,
    this.enabledBackgroundColor,
    this.enabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    required this.onTap,
  }) : _size = AppButtonSize.large;

  const LeftAlignedAppButton.xlarge({
    super.key,
    required this.text,
    this.icon,
    this.enabledBackgroundColor,
    this.enabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.onTap,
  }) : _size = AppButtonSize.xlarge;

  final Widget text;
  final Widget? icon;
  final Color? enabledBackgroundColor;
  final Color? enabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 4.0),
          ],
          Expanded(child: text),
        ],
      ),
    );
  }
}
