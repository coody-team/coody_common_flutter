import 'package:coody_common_flutter/src/loading/widgets/loading_shimmer.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:flutter/material.dart';

class ImageWidgetUtil {
  static Widget frameBuilder(
      BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
    final isLoading = frame == null;
    if (!isLoading) return child;
    return LoadingShimmer(
      isLoading: isLoading,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: context.colors.gray2,
      ),
    );
  }
}
