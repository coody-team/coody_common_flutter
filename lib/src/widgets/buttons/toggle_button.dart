import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 200),
    this.onChanged,
  });

  final bool value;
  final Duration duration;
  final void Function(bool)? onChanged;

  Color getActiveBackgroundColor(BuildContext context) => context.colors.gray6;
  Color getInactiveBackgroundColor(BuildContext context) => context.colors.gray2;

  Color _getBackgroundColor(BuildContext context) => switch (value) {
        true => getActiveBackgroundColor(context),
        false => getInactiveBackgroundColor(context),
      };
  Alignment get _alignment => switch (value) {
        true => Alignment.centerRight,
        false => Alignment.centerLeft,
      };

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () => onChanged?.call(!value),
        child: AnimatedContainer(
          duration: duration,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(90.0)),
            color: _getBackgroundColor(context),
          ),
          width: 50.0,
          height: 30.0,
          padding: const EdgeInsets.all(3.0),
          child: AnimatedAlign(
            alignment: _alignment,
            duration: duration,
            curve: standardEasing,
            child: Container(
              width: 24.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.gray2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
