import 'dart:math';

import 'package:coody_common_flutter/src/image/utils/image_provider_util.dart';
import 'package:coody_common_flutter/src/styles/app_button_styles.dart';
import 'package:coody_common_flutter/src/styles/app_colors.dart';
import 'package:coody_common_flutter/src/styles/app_theme.dart';
import 'package:coody_common_flutter/src/widgets/buttons/app_button.dart';
import 'package:coody_common_flutter/src/widgets/page_indicator.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:flutter/material.dart' as material;
import 'package:material_symbols_icons/symbols.dart';
import 'package:photo_view/photo_view.dart';

class ImagePageView extends StatefulWidget {
  const ImagePageView({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.minScale = PhotoViewComputedScale.contained,
    this.showPageIndicator = false,
    this.usePhotoView = false,
  });

  final List<String> imageUrls;
  final int initialIndex;
  final PhotoViewComputedScale minScale;
  final bool showPageIndicator;
  final bool usePhotoView;

  @override
  State<ImagePageView> createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: max(widget.initialIndex, 0));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index) {
            final imageUrl = widget.imageUrls[index];
            if (widget.usePhotoView) {
              return PhotoView(
                minScale: widget.minScale,
                backgroundDecoration: BoxDecoration(
                  color: context.colors.background.opacity60,
                ),
                imageProvider: AdaptiveImageProvider.create(imageUrl),
              );
            } else {
              return Image(
                fit: switch (widget.minScale) {
                  PhotoViewComputedScale.contained => BoxFit.contain,
                  PhotoViewComputedScale.covered => BoxFit.cover,
                  _ => BoxFit.cover,
                },
                image: AdaptiveImageProvider.create(imageUrl),
              );
            }
          },
        ),
        if (widget.showPageIndicator)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: PageIndicator.large(
              pageController: _pageController,
              count: widget.imageUrls.length,
            ),
          ),
      ],
    );
  }
}

class ImagePageViewOverlay extends StatelessWidget {
  const ImagePageViewOverlay({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.minScale = PhotoViewComputedScale.contained,
    this.onCloseTap,
  });

  final List<String> imageUrls;
  final int initialIndex;
  final PhotoViewComputedScale minScale;
  final VoidCallback? onCloseTap;

  static void showDialog(BuildContext context, List<String> imageUrls, int initialIndex) {
    material.showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return ImagePageViewOverlay(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
          onCloseTap: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ImagePageView(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
          minScale: minScale,
          usePhotoView: true,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, right: 24.0),
            child: AppButton(
              style: context.buttonThemes.primary.iconSquare.none.medium,
              onPressed: onCloseTap,
              child: const Icon(Symbols.close, size: 32.0),
            ),
          ),
        )
      ],
    );
  }
}
