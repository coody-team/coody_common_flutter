import 'dart:io';

import 'package:file_picker/file_picker.dart';

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
