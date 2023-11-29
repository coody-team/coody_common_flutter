import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ImageAddButton extends StatelessWidget {
  const ImageAddButton({
    super.key,
    this.size = const Size.square(112.0),
    required this.onTap,
  });

  final Size size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      style: appButtonBaseStyle.copyWith(
        fixedSize: MaterialStatePropertyAll(size),
        backgroundColor: MaterialStatePropertyUtil.simple(
          enabled: context.colors.gray3,
          disabled: context.colors.gray4,
        ),
        foregroundColor: MaterialStatePropertyUtil.simple(
          enabled: context.colors.gray8,
          disabled: context.colors.gray5,
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
      ),
      onPressed: onTap,
      child: Icon(Symbols.add_rounded),
    );
  }
}
