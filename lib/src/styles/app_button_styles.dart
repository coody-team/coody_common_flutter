import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/styles/app_typography.dart';
import 'package:coody_common_flutter/src/utils/material_state_property_util.dart';
import 'package:flutter/material.dart';

enum AppButtonStyle { filled, outlined, none }

enum AppButtonShape { standard, circle, square }

enum AppButtonSize { small, medium, large, xlarge }

extension _ButtonShapeX on ButtonStyle {
  ButtonStyle shapeStandard(AppButtonSize size, AppTypography typography) => switch (size) {
        AppButtonSize.small => copyWith(
            padding: MaterialStatePropertyAll(EdgeInsets.all(12.0)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            )),
            textStyle: MaterialStatePropertyAll(typography.body2.emphasized),
            iconSize: MaterialStatePropertyAll(20.0),
          ),
        AppButtonSize.medium => copyWith(
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
            textStyle: MaterialStatePropertyAll(typography.body2.emphasized),
            iconSize: MaterialStatePropertyAll(24.0),
          ),
        AppButtonSize.large => copyWith(
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 64.0, vertical: 14.0)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
            textStyle: MaterialStatePropertyAll(typography.body2.emphasized),
            iconSize: MaterialStatePropertyAll(24.0),
          ),
        AppButtonSize.xlarge => copyWith(
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 64.0, vertical: 18.0)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
            textStyle: MaterialStatePropertyAll(typography.body2.emphasized),
            iconSize: MaterialStatePropertyAll(24.0),
          ),
      };

  ButtonStyle shapeCircle(AppButtonSize size) => switch (size) {
        AppButtonSize.small => copyWith(
            padding: MaterialStatePropertyAll(EdgeInsets.all(4.0)),
            shape: MaterialStatePropertyAll(CircleBorder()),
            iconSize: MaterialStatePropertyAll(16.0),
          ),
        AppButtonSize.medium => copyWith(
            padding: MaterialStatePropertyAll(EdgeInsets.all(4.0)),
            shape: MaterialStatePropertyAll(CircleBorder()),
            iconSize: MaterialStatePropertyAll(24.0),
          ),
        AppButtonSize.large => copyWith(
            padding: MaterialStatePropertyAll(EdgeInsets.all(12.0)),
            shape: MaterialStatePropertyAll(CircleBorder()),
            iconSize: MaterialStatePropertyAll(24.0),
          ),
        AppButtonSize.xlarge => copyWith(
            padding: MaterialStatePropertyAll(EdgeInsets.all(24.0)),
            shape: MaterialStatePropertyAll(CircleBorder()),
            iconSize: MaterialStatePropertyAll(24.0),
          ),
      };

  ButtonStyle shapeSquare(AppButtonSize size) => switch (size) {
        AppButtonSize.small => shapeCircle(size).copyWith(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )),
          ),
        AppButtonSize.medium => shapeCircle(size).copyWith(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )),
          ),
        AppButtonSize.large => shapeCircle(size).copyWith(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            )),
          ),
        AppButtonSize.xlarge => shapeCircle(size).copyWith(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            )),
          ),
      };
}

extension _ButtonStyleX on ButtonStyle {
  ButtonStyle styleFilled({
    required Color enabledBackgroundColor,
    required Color disabledBackgroundColor,
    required Color enabledForegroundColor,
    required Color disabledForegroundColor,
  }) =>
      copyWith(
        backgroundColor: MaterialStatePropertyUtil.simple(
          enabled: enabledBackgroundColor,
          disabled: disabledBackgroundColor,
        ),
        foregroundColor: MaterialStatePropertyUtil.simple(
          enabled: enabledForegroundColor,
          disabled: disabledForegroundColor,
        ),
      );

  ButtonStyle styleOutlined({
    required Color enabled,
    required Color disabled,
  }) =>
      copyWith(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        foregroundColor: MaterialStatePropertyUtil.simple(
          enabled: enabled,
          disabled: disabled,
        ),
        side: MaterialStatePropertyUtil.simple(
          enabled: BorderSide(color: enabled, width: 2.0),
          disabled: BorderSide(color: disabled, width: 2.0),
        ),
      );

  ButtonStyle styleNone({
    required Color enabled,
    required Color disabled,
  }) =>
      copyWith(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        foregroundColor: MaterialStatePropertyUtil.simple(
          enabled: enabled,
          disabled: disabled,
        ),
      );
}

final appButtonBaseStyle = ButtonStyle(
  surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  visualDensity: const VisualDensity(),
  splashFactory: NoSplash.splashFactory,
  minimumSize: MaterialStatePropertyAll(Size.zero),
  maximumSize: const MaterialStatePropertyAll(Size.infinite),
  animationDuration: const Duration(milliseconds: 200),
  enableFeedback: true,
  alignment: Alignment.center,
  elevation: const MaterialStatePropertyAll(0.0),
  mouseCursor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return SystemMouseCursors.basic;
    }
    return SystemMouseCursors.click;
  }),
);

class ButtonStyles {
  final ButtonStyle small;
  final ButtonStyle medium;
  final ButtonStyle large;
  final ButtonStyle xlarge;

  ButtonStyles({
    required this.small,
    required this.medium,
    required this.large,
    required this.xlarge,
  });
}

class IconButtonStyles {
  final ButtonStyles filled;
  final ButtonStyles outlined;
  final ButtonStyles none;

  IconButtonStyles({
    required this.filled,
    required this.outlined,
    required this.none,
  });
}

class AppButtonStyles {
  AppButtonStyles(
    this.context, {
    required this.enabledBackgroundColor,
    required this.enabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    this.useBackgroundAsPrimary = false,
  })  : disabledBackgroundColor = disabledBackgroundColor ?? context.colors.gray4,
        disabledForegroundColor = disabledForegroundColor ?? context.colors.gray5;

  final BuildContext context;
  final Color enabledBackgroundColor;
  final Color enabledForegroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final bool useBackgroundAsPrimary;

  ButtonStyle _buildButtonStyle(AppButtonStyle style, AppButtonShape shape, AppButtonSize size) {
    ButtonStyle result = appButtonBaseStyle;

    result = switch (style) {
      AppButtonStyle.filled => result.styleFilled(
          enabledBackgroundColor: enabledBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          enabledForegroundColor: enabledForegroundColor,
          disabledForegroundColor: disabledForegroundColor,
        ),
      AppButtonStyle.outlined => result.styleOutlined(
          enabled: useBackgroundAsPrimary ? enabledBackgroundColor : enabledForegroundColor,
          disabled: disabledForegroundColor,
        ),
      AppButtonStyle.none => result.styleNone(
          enabled: useBackgroundAsPrimary ? enabledBackgroundColor : enabledForegroundColor,
          disabled: disabledForegroundColor,
        ),
    };

    result = switch (shape) {
      AppButtonShape.standard => result.shapeStandard(size, context.typography),
      AppButtonShape.circle => result.shapeCircle(size),
      AppButtonShape.square => result.shapeSquare(size),
    };

    return result;
  }

  ButtonStyles _buildButtonStyles(AppButtonStyle style, AppButtonShape shape) => ButtonStyles(
        small: _buildButtonStyle(style, shape, AppButtonSize.small),
        medium: _buildButtonStyle(style, shape, AppButtonSize.medium),
        large: _buildButtonStyle(style, shape, AppButtonSize.large),
        xlarge: _buildButtonStyle(style, shape, AppButtonSize.xlarge),
      );

  IconButtonStyles _buildIconButtonStyles(AppButtonShape shape) => IconButtonStyles(
        filled: _buildButtonStyles(AppButtonStyle.filled, shape),
        outlined: _buildButtonStyles(AppButtonStyle.outlined, shape),
        none: _buildButtonStyles(AppButtonStyle.none, shape),
      );

  ButtonStyles get filled => _buildButtonStyles(AppButtonStyle.filled, AppButtonShape.standard);

  ButtonStyles get outlined => _buildButtonStyles(AppButtonStyle.outlined, AppButtonShape.standard);

  ButtonStyles get none => _buildButtonStyles(AppButtonStyle.none, AppButtonShape.standard);

  IconButtonStyles get iconCircle => _buildIconButtonStyles(AppButtonShape.circle);

  IconButtonStyles get iconSquare => _buildIconButtonStyles(AppButtonShape.square);
}

class AppButtonThemes {
  final BuildContext context;

  AppButtonThemes(this.context);

  AppButtonStyles get primary => AppButtonStyles(
        context,
        enabledBackgroundColor: context.colors.gray3,
        enabledForegroundColor: context.colors.gray8,
      );

  AppButtonStyles get secondary => AppButtonStyles(
        context,
        enabledBackgroundColor: context.colors.gray2,
        enabledForegroundColor: context.colors.gray8,
      );

  AppButtonStyles get primary60 => AppButtonStyles(
        context,
        enabledBackgroundColor: context.colors.gray3.withOpacity(0.6),
        disabledBackgroundColor: context.colors.gray4.withOpacity(0.6),
        enabledForegroundColor: context.colors.gray8.withOpacity(0.6),
        disabledForegroundColor: context.colors.gray5.withOpacity(0.6),
      );

  AppButtonStyles get alert => AppButtonStyles(
        context,
        enabledBackgroundColor: context.colors.red,
        enabledForegroundColor: context.colors.white,
        useBackgroundAsPrimary: true,
      );

  AppButtonStyles get info => AppButtonStyles(
        context,
        enabledBackgroundColor: context.colors.blue,
        enabledForegroundColor: context.colors.white,
        useBackgroundAsPrimary: true,
      );
}

extension AppButtonThemesX on BuildContext {
  AppButtonThemes get buttonThemes => AppButtonThemes(this);
}
