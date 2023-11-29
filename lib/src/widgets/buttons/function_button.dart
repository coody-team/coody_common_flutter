import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class FunctionButton extends StatelessWidget {
  const FunctionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Widget text;
  final Widget icon;
  final void Function()? onTap;

  static getStyle(BuildContext context) {
    return appButtonBaseStyle.copyWith(
      minimumSize: MaterialStatePropertyAll(Size(double.infinity, 0.0)),
      padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(vertical: 4.0)),
      foregroundColor: MaterialStatePropertyUtil.simple(
        enabled: context.colors.gray8,
        disabled: context.colors.gray4,
      ),
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      iconSize: MaterialStatePropertyAll(24.0),
      textStyle: MaterialStatePropertyAll(context.typography.body1.emphasized),
      alignment: Alignment.centerLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      style: getStyle(context),
      onPressed: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8.0),
          Expanded(child: text),
        ],
      ),
    );
  }
}
