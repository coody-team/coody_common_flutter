import 'dart:io';

import 'package:coody_common_flutter/src/loading/widgets/loading_dialog_listener.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// 이미지 선택
Future<List<File>> pickImageFiles({bool allowMultiple = true}) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: allowMultiple,
  );

  return result?.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList() ??
      const <File>[];
}

Future<List<String>> pickImagesWithLoading(BuildContext context,
    {bool allowMultiple = true}) async {
  showLoadingDialog(context);
  try {
    final images = await pickImageFiles(allowMultiple: allowMultiple);
    return images.map((image) => image.path).toList();
  } finally {
    if (context.mounted) closeLoadingDialog(context);
  }
}
