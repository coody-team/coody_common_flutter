import 'package:coody_common_flutter/src/image/widgets/image_add_button.dart';
import 'package:coody_common_flutter/src/image/widgets/image_card.dart';
import 'package:flutter/material.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({
    super.key,
    this.imageUrls = const [],
    this.itemSize = const Size(112.0, 112.0),
    this.itemPadding = const EdgeInsets.only(right: 8.0),
    this.firstItemPadding = const EdgeInsets.only(left: 24.0, right: 8.0),
    this.lastItemPadding = const EdgeInsets.only(right: 24.0),
    this.onImageRemoveTap,
    this.onImageTap,
    this.onImageAddTap,
  });

  final List<String> imageUrls;
  final Size itemSize;
  final EdgeInsets itemPadding;
  final EdgeInsets firstItemPadding;
  final EdgeInsets lastItemPadding;
  final void Function(int index)? onImageRemoveTap;
  final void Function(int index)? onImageTap;
  final void Function()? onImageAddTap;

  int get _itemCount => onImageAddTap != null ? imageUrls.length + 1 : imageUrls.length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemSize.height,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _itemCount,
        itemBuilder: (context, index) {
          final isFirstItem = index == 0;
          final isLastItem = index == _itemCount - 1;
          final isAddButton = index > imageUrls.length - 1;

          EdgeInsets padding = itemPadding;
          if (isFirstItem) {
            padding = firstItemPadding;
          } else if (isLastItem) {
            padding = lastItemPadding;
          }

          if (isAddButton) {
            return Padding(
              padding: padding,
              child: ImageAddButton(
                size: itemSize,
                onTap: onImageAddTap,
              ),
            );
          }

          final imageUrl = imageUrls[index];
          return Padding(
            key: Key(imageUrl),
            padding: padding,
            child: ImageCard(
              imageUrl: imageUrl,
              size: itemSize,
              onTap: onImageTap != null ? () => onImageTap?.call(index) : null,
              onRemoveTap: onImageRemoveTap != null ? () => onImageRemoveTap?.call(index) : null,
            ),
          );
        },
      ),
    );
  }
}
