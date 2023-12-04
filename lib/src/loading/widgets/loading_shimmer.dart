import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    this.isLoading = false,
    this.baseColor,
    this.highlightColor,
    required this.child,
  });

  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;
  final Widget child;

  Color getDefaultBaseColor(BuildContext context) => context.colors.gray2;
  Color getDefaultHighlightColor(BuildContext context) => context.colors.gray1;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Shimmer.fromColors(
      baseColor: baseColor ?? getDefaultBaseColor(context),
      highlightColor: highlightColor ?? getDefaultHighlightColor(context),
      child: child,
    );
  }
}
