class UrlStringParser {
  UrlStringParser(this.text);

  final String text;

  /// 프로토콜을 포함한 Url 파싱
  ///
  /// 포함되는 Url
  /// - https://google.com
  /// - http://google.com
  ///
  /// 포함되지 않는 Url
  /// - www.google.com
  /// - google.com
  static const pattern =
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

  /// 프로토콜을 포함하지 않은 Url도 파싱
  ///
  /// 포함되는 Url
  /// - https://google.com
  /// - http://google.com
  /// - www.google.com
  /// - google.com
  static const loosePattern =
      r'(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

  /// 프로토콜을 포함한 Url 파싱
  ///
  /// 포함되는 Url
  /// - https://google.com
  /// - http://google.com
  ///
  /// 포함되지 않는 Url
  /// - www.google.com
  /// - google.com
  List<String> parse() {
    final exp = RegExp(pattern);
    final matches = exp.allMatches(text);

    return matches.map((e) => e[0]).where((e) => e != null).map((e) => e!).toList();
  }

  /// 프로토콜을 포함하지 않은 Url도 파싱
  ///
  /// 포함되는 Url
  /// - https://google.com
  /// - http://google.com
  /// - www.google.com
  /// - google.com
  List<String> parseLoosely() {
    final exp = RegExp(loosePattern);
    final matches = exp.allMatches(text);

    return matches.map((e) => e[0]).where((e) => e != null).map((e) => e!).toList();
  }
}
