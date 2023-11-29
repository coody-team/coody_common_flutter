extension IterableX<T> on Iterable<T> {
  /// [other]에 속한 항목 중 한 개라도 포함되어 있으면 true
  containsOneOf(Iterable<T> other) {
    for (final e in other) {
      if (contains(e)) return true;
    }
    return false;
  }

  /// [other]에 속하지 않는 항목을 포함하고 있으면 true
  containsNotIn(Iterable<T> other) {
    final otherSet = Set.from(other);
    final thisSet = Set.from(this);

    return thisSet.difference(otherSet).isNotEmpty;
  }
}
