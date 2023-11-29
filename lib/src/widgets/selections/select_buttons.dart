import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class _SelectBase extends StatelessWidget {
  const _SelectBase({
    required this.value,
    required this.normalIcon,
    required this.activeIcon,
    required this.onChanged,
    this.color,
  });

  final bool value;
  final Widget normalIcon;
  final Widget activeIcon;
  final Color? color;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      style: context.buttonThemes.primary.iconSquare.none.medium.copyWith(
        foregroundColor: color != null
            ? MaterialStatePropertyUtil.simple(
                enabled: color,
                disabled: context.colors.gray5,
              )
            : null,
      ),
      onPressed: onChanged != null ? () => onChanged?.call(value) : null,
      child: Stack(
        children: [
          normalIcon,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            switchInCurve: standardEasing,
            switchOutCurve: standardEasing,
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: value ? activeIcon : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

enum _SelectBoxStyle {
  primary,
  alert;

  Color getColor(BuildContext context) => switch (this) {
        primary => context.colors.gray8,
        alert => context.colors.red,
      };
}

class SelectBox extends StatelessWidget {
  const SelectBox({
    super.key,
    required this.value,
    required this.onChanged,
  }) : _style = _SelectBoxStyle.primary;

  const SelectBox.alert({
    super.key,
    required this.value,
    required this.onChanged,
  }) : _style = _SelectBoxStyle.alert;

  final bool value;
  final void Function(bool value)? onChanged;

  final _SelectBoxStyle _style;

  @override
  Widget build(BuildContext context) {
    return _SelectBase(
      value: value,
      color: _style.getColor(context),
      normalIcon: Icon(
        Symbols.check_box_outline_blank_rounded,
      ),
      activeIcon: Icon(
        Symbols.check_box_rounded,
        fill: 1.0,
      ),
      onChanged: onChanged,
    );
  }
}

class SelectRadio extends StatelessWidget {
  const SelectRadio({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return _SelectBase(
      value: value,
      normalIcon: Icon(Symbols.radio_button_unchecked_rounded),
      activeIcon: Icon(Symbols.radio_button_checked_rounded),
      onChanged: onChanged,
    );
  }
}
