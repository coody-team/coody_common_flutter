import 'package:coody_common_flutter/src/styles/app_colors.dart';
import 'package:coody_common_flutter/src/styles/app_typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

AppColors? _lightColors;
AppColors? _darkColors;
AppTypography? _lightTypography;
AppTypography? _darkTypography;

extension AppThemeX on BuildContext {
  AppColors get colors {
    if (Theme.of(this).brightness == Brightness.light) {
      if (kDebugMode) return AppColors.light();
      return _lightColors ??= AppColors.light();
    } else {
      if (kDebugMode) return AppColors.dark();
      return _darkColors ??= AppColors.dark();
    }
  }

  AppTypography get typography {
    if (kDebugMode) {
      return AppTypography.fromColor(colors);
    } else {
      if (Theme.of(this).brightness == Brightness.light) {
        return _lightTypography ??= AppTypography.fromColor(colors);
      } else {
        return _darkTypography ??= AppTypography.fromColor(colors);
      }
    }
  }
}

ThemeData lightTheme() => _buildTheme(_lightColors ?? AppColors.light(), Brightness.light);
ThemeData darkTheme() => _buildTheme(_darkColors ?? AppColors.dark(), Brightness.dark);

ThemeData _buildTheme(AppColors colors, Brightness brightness) {
  final typography = AppTypography.fromColor(colors);
  final baseTheme = ThemeData.light(useMaterial3: true);

  return baseTheme.copyWith(
    brightness: brightness,
    colorScheme: baseTheme.colorScheme.copyWith(
      primary: colors.primary,
      secondary: colors.secondary,
    ),
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.background,
    textTheme: baseTheme.textTheme.apply(
      bodyColor: colors.gray8,
      displayColor: colors.gray8,
      decorationColor: colors.gray8,
    ),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    iconTheme: IconThemeData(color: colors.gray8, weight: 300.0),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.gray2,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      showDragHandle: true,
      dragHandleColor: colors.gray4,
      dragHandleSize: const Size(48.0, 4.0),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colors.background,
      foregroundColor: colors.gray8,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: typography.title1.normal,
      elevation: 0.0,
    ),
    // tabBarTheme: TabBarTheme(
    //   labelStyle: typography.subtitle2,
    //   unselectedLabelStyle: typography.body2,
    //   labelColor: colors.label1,
    //   unselectedLabelColor: colors.label3,
    //   dividerColor: colors.gray2,
    //   indicatorColor: colors.gray6,
    //   indicatorSize: TabBarIndicatorSize.tab,
    // ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.background,
      selectedItemColor: colors.gray8,
      unselectedItemColor: colors.gray8,
      elevation: 0.0,
      selectedIconTheme: const IconThemeData(size: 24.0, fill: 1.0),
      unselectedIconTheme: const IconThemeData(size: 24.0, fill: 0.0),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: colors.gray4,
      thickness: 0.8,
      space: 2.0,
    ),
  );
}
