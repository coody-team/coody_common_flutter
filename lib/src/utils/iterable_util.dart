import 'package:collection/collection.dart';

extension IterableX<T> on Iterable<T> {
  /// [other]에 속한 항목 중 한 개라도 포함되어 있으면 true
  bool containsOneOf(Iterable<T> other) {
    for (final e in other) {
      if (contains(e)) return true;
    }
    return false;
  }

  /// [other]에 속하지 않는 항목을 포함하고 있으면 true
  bool containsNotIn(Iterable<T> other) {
    final otherSet = Set.from(other);
    final thisSet = Set.from(this);

    return thisSet.difference(otherSet).isNotEmpty;
  }

  bool containsWhere(bool Function(T element) test) {
    return firstWhereOrNull(test) != null;
  }

  bool isSameWith(Iterable<T> other) {
    if (identical(this, other)) return true;
    if (length != other.length) return false;

    return foldIndexed(true, (index, previous, element) {
      if (!previous) return false;
      return element == other.elementAt(index);
    });
  }
}
