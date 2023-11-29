import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  const BarButton({
    super.key,
    required this.child,
    this.enabledBackgroundColor,
    this.enabledForegroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    required this.onTap,
  });

  final Widget child;
  final Color? enabledBackgroundColor;
  final Color? enabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 0.0)),
        maximumSize: MaterialStatePropertyAll(Size.fromHeight(56.0)),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 18.0, horizontal: 64.0),
        ),
        backgroundColor: MaterialStatePropertyUtil.simple(
          enabled: enabledBackgroundColor ?? context.colors.gray2,
          disabled: disabledBackgroundColor ?? context.colors.gray2,
        ),
        foregroundColor: MaterialStatePropertyUtil.simple(
          enabled: enabledForegroundColor ?? context.colors.gray8,
          disabled: disabledForegroundColor ?? context.colors.gray5,
        ),
        textStyle: MaterialStatePropertyAll(context.typography.body1.emphasized),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
