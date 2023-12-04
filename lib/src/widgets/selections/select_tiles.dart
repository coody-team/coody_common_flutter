import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:coody_common_flutter/src/widgets/selections/select_buttons.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class _SelectTileBase extends StatelessWidget {
  const _SelectTileBase({
    required this.selection,
    required this.body,
    this.onTap,
    this.onActionTap,
  });

  final Widget selection;
  final Widget body;
  final void Function()? onTap;
  final void Function()? onActionTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            selection,
            const SizedBox(width: 8.0),
            Flexible(
              child: DefaultTextStyle(
                style: context.typography.body1.normal,
                child: body,
              ),
            ),
            if (onActionTap != null) ...[
              const SizedBox(width: 8.0),
              AppButton(
                style: context.buttonThemes.primary.iconSquare.none.medium,
                onPressed: onActionTap,
                child: Icon(Symbols.keyboard_arrow_right_rounded),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum _SelectBoxTileStyle {
  primary,
  alert;

  bool get isPrimary => this == primary;
  bool get isAlert => this == alert;
}

class SelectBoxTile extends StatelessWidget {
  const SelectBoxTile({
    super.key,
    required this.value,
    required this.text,
    required this.onChanged,
    this.onActionTap,
  }) : _style = _SelectBoxTileStyle.primary;

  const SelectBoxTile.alert({
    super.key,
    required this.value,
    required this.text,
    required this.onChanged,
    this.onActionTap,
  }) : _style = _SelectBoxTileStyle.alert;

  final bool value;
  final Widget text;
  final void Function(bool value)? onChanged;
  final void Function()? onActionTap;

  final _SelectBoxTileStyle _style;

  @override
  Widget build(BuildContext context) {
    return _SelectTileBase(
      selection: _style.isPrimary
          ? SelectBox(value: value, onChanged: onChanged)
          : SelectBox.alert(value: value, onChanged: onChanged),
      body: DefaultTextStyle(
        style: context.typography.body1.normal.copyWith(
          color: _style.isAlert ? context.colors.red : null,
        ),
        child: text,
      ),
      onTap: () => onChanged?.call(value),
      onActionTap: onActionTap,
    );
  }
}

class SelectRadioTile extends StatelessWidget {
  const SelectRadioTile({
    super.key,
    required this.value,
    required this.text,
    required this.onChanged,
    this.onActionTap,
  });

  final bool value;
  final Widget text;
  final void Function(bool value)? onChanged;
  final void Function()? onActionTap;

  @override
  Widget build(BuildContext context) {
    return _SelectTileBase(
      selection: SelectRadio(value: value, onChanged: onChanged),
      body: text,
      onTap: () => onChanged?.call(value),
      onActionTap: onActionTap,
    );
  }
}

enum AgreeTileType { required, optional, none }

class AgreeTile extends StatelessWidget {
  const AgreeTile({
    super.key,
    required this.value,
    required this.type,
    required this.requiredText,
    required this.optionalText,
    required this.text,
    required this.onChanged,
    this.onActionTap,
  });

  final bool value;
  final AgreeTileType type;
  final Widget requiredText;
  final Widget optionalText;
  final Widget text;
  final void Function(bool value)? onChanged;
  final void Function()? onActionTap;

  @override
  Widget build(BuildContext context) {
    return SelectRadioTile(
      value: value,
      text: Row(
        children: [
          switch (type) {
            AgreeTileType.required => DefaultTextStyle(
                style: context.typography.body1.emphasized.copyWith(
                  color: context.colors.red,
                ),
                child: requiredText,
              ),
            AgreeTileType.optional => DefaultTextStyle(
                style: context.typography.body1.emphasized.copyWith(
                  color: context.colors.gray5,
                ),
                child: optionalText,
              ),
            AgreeTileType.none => const SizedBox(),
          },
          if (type != AgreeTileType.none) const SizedBox(width: 8.0),
          Expanded(child: text),
        ],
      ),
      onChanged: onChanged,
      onActionTap: onActionTap,
    );
  }
}
