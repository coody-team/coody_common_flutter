import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    super.key,
    required this.title,
    required this.body,
    this.onTap,
  });

  final Widget title;
  final Widget body;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: context.colors.gray3,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: context.typography.title1.emphasized,
              child: title,
            ),
            const SizedBox(height: 8.0),
            DefaultTextStyle(
              style: context.typography.body2.normal,
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
