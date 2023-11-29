import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coody_common_flutter/src/image/utils/image_url_util.dart';
import 'package:flutter/rendering.dart';

abstract class AdaptiveImageProvider {
  /// [imageUrl]이 네트워크 이미지일 경우 [CachedNetworkImageProvider] 리턴, 그 외의 경우 [FileImage] 리턴
  static ImageProvider create(String imageUrl) {
    if (isNetworkImage(imageUrl)) {
      return CachedNetworkImageProvider(imageUrl);
    } else {
      return FileImage(File(imageUrl));
    }
  }
}
