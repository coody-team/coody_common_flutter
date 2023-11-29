import 'package:coody_common_flutter/src/styles/app_colors.dart';
import 'package:flutter/widgets.dart';

const _fontFamily = 'Pretendard';
const _bold = FontWeight.w700;
const _semiBold = FontWeight.w600;
const _regular = FontWeight.w400;

class AppTypography {
  final TextStyleWrapper largeTitle1;
  final TextStyleWrapper largeTitle2;
  final TextStyleWrapper title1;
  final TextStyleWrapper title2;
  final TextStyleWrapper body1;
  final TextStyleWrapper body2;
  final TextStyleWrapper caption1;
  final TextStyleWrapper caption2;

  AppTypography({
    required this.largeTitle1,
    required this.largeTitle2,
    required this.title1,
    required this.title2,
    required this.body1,
    required this.body2,
    required this.caption1,
    required this.caption2,
  });

  factory AppTypography.fromColor(AppColors colors) {
    return AppTypography(
      largeTitle1: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _regular,
          fontSize: 24.0,
          height: 32.0 / 24.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _bold,
      ),
      largeTitle2: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _regular,
          fontSize: 20.0,
          height: 28.0 / 24.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _bold,
      ),
      title1: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _semiBold,
          fontSize: 16.0,
          height: 24.0 / 16.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: FontWeight.bold,
      ),
      title2: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _semiBold,
          fontSize: 14.0,
          height: 22.0 / 14.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _bold,
      ),
      body1: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _regular,
          fontSize: 16.0,
          height: 20.0 / 16.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _semiBold,
      ),
      body2: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _regular,
          fontSize: 14.0,
          height: 18.0 / 14.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _semiBold,
      ),
      caption1: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _regular,
          fontSize: 12.0,
          height: 16.0 / 12.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _semiBold,
      ),
      caption2: TextStyleWrapper(
        normal: TextStyle(
          color: colors.gray8,
          fontFamily: _fontFamily,
          fontWeight: _regular,
          fontSize: 10.0,
          height: 14.0 / 10.0,
          letterSpacing: -0.4,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        emphasizedWeight: _semiBold,
      ),
    );
  }
}

class TextStyleWrapper {
  final TextStyle normal;
  final TextStyle emphasized;

  TextStyleWrapper({
    required this.normal,
    required FontWeight emphasizedWeight,
  }) : emphasized = normal.copyWith(fontWeight: emphasizedWeight);
}
