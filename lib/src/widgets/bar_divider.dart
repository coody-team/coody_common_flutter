import 'package:coody_common_flutter/styles.dart';
import 'package:coody_common_flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarDivider extends StatelessWidget {
  const BarDivider({
    super.key,
    required this.title,
    this.action,
  });

  final Widget title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: context.typography.title1.emphasized,
              child: title,
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: 8.0),
            AppButtonTheme(
              data: AppButtonThemeData(style: context.buttonThemes.primary.filled.small),
              child: action!,
            ),
          ]
        ],
      ),
    );
  }
}
