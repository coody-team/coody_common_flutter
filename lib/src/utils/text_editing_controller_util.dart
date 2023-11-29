import 'dart:math';

import 'package:flutter/material.dart';

extension TextEditingControllerX on TextEditingController {
  /// [text]에서 Cursor가 위차하는 Index
  int get cursorIndex {
    return max(selection.extentOffset, 0);
  }

  /// 현재 Cursor 위치까지의 문자열
  String get headOfCursor => text.substring(0, cursorIndex);

  /// 현재 Cursor 위치부터 끝까지의 문자열
  String get tailOfCursor => text.substring(cursorIndex);

  /// 현재 Cursor 위치에 문자열 삽입 후 Cursor 이동
  void insertStringOnCurrentCursor(String str) {
    value = TextEditingValue(
      text: '$headOfCursor$str$tailOfCursor',
      selection: TextSelection.collapsed(offset: cursorIndex + str.length),
    );
  }

  /// 현재 Cursor 위치에서 [numRemoves] 만큼 문자열 삭제 후 Cursor 이동
  void removeStringFromCurrentCursor(int numRemoves) {
    final targetCursorIndex = max(cursorIndex - numRemoves, 0);

    final head = text.substring(0, targetCursorIndex);
    final tail = text.substring(cursorIndex);

    value = TextEditingValue(
      text: '$head$tail',
      selection: TextSelection.collapsed(offset: targetCursorIndex),
    );
  }

  /// 문자열 추가 후 Cursor 위치를 맨 뒤로 이동
  void appendStringAndMoveBackCursor(String str) {
    value = TextEditingValue(
      text: text + str,
      selection: TextSelection.collapsed(
        offset: text.length + str.length,
        affinity: TextAffinity.upstream,
      ),
    );
  }

  void replaceStringAndMoveBackCursor(String str) {
    value = TextEditingValue(
      text: str,
      selection: TextSelection.collapsed(
        offset: str.length,
        affinity: TextAffinity.upstream,
      ),
    );
  }

  /// 현재 Cursor 위치를 맨 뒤로 이동
  void moveBackCursor() {
    selection = TextSelection.collapsed(offset: text.length, affinity: TextAffinity.upstream);
  }
}
