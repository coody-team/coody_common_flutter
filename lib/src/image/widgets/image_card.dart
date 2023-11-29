import 'package:coody_common_flutter/src/image/utils/image_provider_util.dart';
import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.imageUrl,
    this.size = const Size.square(112.0),
    this.fit = BoxFit.cover,
    this.onTap,
    this.onRemoveTap,
  });

  final String imageUrl;
  final Size size;
  final BoxFit fit;
  final void Function()? onTap;
  final void Function()? onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              color: context.colors.gray3,
              image: DecorationImage(
                fit: fit,
                image: AdaptiveImageProvider.create(imageUrl),
              ),
            ),
          ),
        ),
        if (onRemoveTap != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, right: 4.0),
            child: AppButton(
              style: context.buttonThemes.primary60.iconCircle.filled.small,
              onPressed: onRemoveTap,
              child: Icon(Symbols.close_rounded),
            ),
          ),
      ],
    );
  }
}
