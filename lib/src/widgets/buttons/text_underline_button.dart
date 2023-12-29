import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:coody_common_flutter/styles.dart';
import 'package:flutter/material.dart';

class TextUnderlineButton extends StatelessWidget {
  const TextUnderlineButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final Widget text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      style: appButtonBaseStyle.copyWith(
        padding: MaterialStatePropertyAll(const EdgeInsets.all(6.0)),
        textStyle: MaterialStatePropertyAll(
          context.typography.caption1.emphasized.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        foregroundColor: MaterialStatePropertyUtil.simple(
          enabled: context.colors.gray5,
          disabled: context.colors.disabledForegroundColor,
        ),
      ),
      onPressed: onTap,
      child: text,
    );
  }
}
