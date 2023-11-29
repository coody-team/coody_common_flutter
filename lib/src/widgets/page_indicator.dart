import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum _PageIndicatorSize {
  small,
  large;

  ScrollingDotsEffect getEffect(BuildContext context) => switch (this) {
        small => ScrollingDotsEffect(
            dotWidth: 4.0,
            dotHeight: 4.0,
            spacing: 4.0,
          ),
        large => ScrollingDotsEffect(
            dotWidth: 6.0,
            dotHeight: 6.0,
            spacing: 4.0,
          ),
      }
          .copyWith(
        maxVisibleDots: 5,
        activeDotScale: 1.0,
        dotColor: context.colors.gray5,
        activeDotColor: context.colors.gray8,
      );
}

extension _ScrollingDotsEffectX on ScrollingDotsEffect {
  ScrollingDotsEffect copyWith({
    Color? dotColor,
    Color? activeDotColor,
    int? maxVisibleDots,
    double? activeDotScale,
  }) =>
      ScrollingDotsEffect(
        activeStrokeWidth: activeStrokeWidth,
        activeDotScale: activeDotScale ?? this.activeDotScale,
        maxVisibleDots: maxVisibleDots ?? this.maxVisibleDots,
        fixedCenter: fixedCenter,
        dotWidth: dotWidth,
        dotHeight: dotHeight,
        spacing: spacing,
        radius: radius,
        dotColor: dotColor ?? this.dotColor,
        activeDotColor: activeDotColor ?? this.activeDotColor,
        strokeWidth: strokeWidth,
        paintStyle: paintStyle,
      );
}

class PageIndicator extends StatelessWidget {
  const PageIndicator.small({
    super.key,
    required this.pageController,
    required this.count,
    this.dotColor,
    this.activeDotColor,
  }) : _size = _PageIndicatorSize.small;

  const PageIndicator.large({
    super.key,
    required this.pageController,
    required this.count,
    this.dotColor,
    this.activeDotColor,
  }) : _size = _PageIndicatorSize.large;

  final PageController pageController;
  final int count;
  final Color? dotColor;
  final Color? activeDotColor;

  final _PageIndicatorSize _size;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: _size.getEffect(context).copyWith(
            dotColor: dotColor,
            activeDotColor: activeDotColor,
          ),
    );
  }
}
