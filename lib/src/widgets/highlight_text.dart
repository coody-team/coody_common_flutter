import 'package:flutter/material.dart';

/// 텍스트 중 일부를 하이라이트로 표현하는 Widget
class HighlightText extends StatelessWidget {
  const HighlightText({
    super.key,
    required this.text,
    this.highlightStrings = const [],
    this.style,
    this.highlightStyle,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.regExpCaseSensitive = true,
    this.regExpDotAll = false,
    this.regExpMultiLine = false,
    this.regExpUnicode = true,
  });

  /// 표시할 텍스트
  final String text;

  /// 기본 TextStyle (Highlight 되지 않은 Text Style)
  final TextStyle? style;

  /// Highlight 처리할 문자열 목록
  final List<String> highlightStrings;

  /// Highlight TextStyle
  /// - [highlightStrings]에 포함되는 문자열에 적용
  final TextStyle? highlightStyle;

  final int? maxLines;

  final TextOverflow overflow;

  final bool regExpCaseSensitive;

  final bool regExpDotAll;

  final bool regExpMultiLine;

  final bool regExpUnicode;

  /// 정규식 표현 특수문자 Escape 처리
  String _escapeRegexSpecialWords(String string) {
    return string.replaceAllMapped(RegExp(r'\?|\*|\+|\{|\}|\||\,|\.|\[|\]|\^|\$|\(|\)|\\'),
        (match) => r'\' + match.group(0).toString());
  }

  /// Highlight를 적용한 TextSpan 생성
  TextSpan _buildTextSpan(BuildContext context) {
    List<TextSpan> children = [];

    final regex = RegExp(
      highlightStrings.map(_escapeRegexSpecialWords).join('|'),
      caseSensitive: regExpCaseSensitive,
      dotAll: regExpDotAll,
      multiLine: regExpMultiLine,
      unicode: regExpUnicode,
    );

    text.splitMapJoin(
      regex,
      onNonMatch: (String span) {
        children.add(TextSpan(text: span, style: style));
        return '';
      },
      onMatch: (Match m) {
        children.add(
          TextSpan(
            text: m[0],
            style: highlightStyle,
          ),
        );
        return '';
      },
    );

    return TextSpan(style: style, children: children);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildTextSpan(context),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
