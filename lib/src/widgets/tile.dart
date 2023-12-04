import 'package:coody_common_flutter/src/image/utils/image_provider_util.dart';
import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

enum TileSize {
  small,
  medium,
  large;

  double get imageWith => switch (this) {
        small => 40.0,
        medium => 48.0,
        large => 56.0,
      };
}

enum TileStyle {
  standard,
  alert;
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.title,
    this.subTitle,
    this.imageUrl,
    this.action,
    this.imageFit,
    this.imageBackgroundColor,
    this.size = TileSize.small,
    this.style = TileStyle.standard,
    required this.onTap,
  });

  final Widget title;
  final Widget? subTitle;
  final String? imageUrl;
  final Widget? action;
  final BoxFit? imageFit;
  final Color? imageBackgroundColor;
  final TileSize size;
  final TileStyle style;
  final void Function()? onTap;

  bool get _isDisabled => onTap == null;

  TextStyle _getTitleStyle(BuildContext context, TileSize size, TileStyle style) {
    var textStyle = switch (size) {
      TileSize.small => context.typography.title2.normal,
      TileSize.medium || TileSize.large => context.typography.title1.normal,
    };

    if (_isDisabled) {
      textStyle = textStyle.copyWith(color: context.colors.gray5);
    } else {
      textStyle = switch (style) {
        TileStyle.standard => textStyle.copyWith(color: context.colors.gray8),
        TileStyle.alert => textStyle.copyWith(color: context.colors.red),
      };
    }

    return textStyle;
  }

  TextStyle _getSubTitleStyle(BuildContext context, TileSize size, TileStyle style) {
    var textStyle = switch (size) {
      TileSize.small => context.typography.caption1.normal,
      TileSize.medium || TileSize.large => context.typography.body2.normal,
    };

    if (_isDisabled) {
      textStyle = textStyle.copyWith(color: context.colors.gray5);
    } else {
      textStyle = switch (style) {
        _ => textStyle.copyWith(color: context.colors.gray6),
      };
    }

    return textStyle;
  }

  TextStyle _getActionTextStyle(BuildContext context, TileSize size) {
    return switch (size) {
      TileSize.small => context.typography.title2.normal,
      _ => context.typography.title1.normal,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            if (imageUrl != null) ...[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: imageBackgroundColor ?? context.colors.gray3,
                  image: DecorationImage(
                    fit: imageFit ?? BoxFit.cover,
                    image: AdaptiveImageProvider.create(imageUrl!),
                  ),
                ),
                width: size.imageWith,
                height: size.imageWith,
              ),
              const SizedBox(width: 12.0),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: _getTitleStyle(context, size, style),
                    child: title,
                  ),
                  if (subTitle != null)
                    DefaultTextStyle(
                      style: _getSubTitleStyle(context, size, style),
                      child: subTitle!,
                    ),
                ],
              ),
            ),
            if (action != null) ...[
              const SizedBox(width: 12.0),
              DefaultTextStyle(
                style: _getActionTextStyle(context, size),
                child: AppButtonTheme(
                  data: AppButtonThemeData(
                    style: context.buttonThemes.primary.iconSquare.none.medium,
                  ),
                  child: action!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
