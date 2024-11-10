// iterable_extensions.dart

extension IndexedMap<T> on Iterable<T> {
  Iterable<R> indexedMap<R>(R Function(T element, int index) transform) {
    final List<R> result = [];
    var index = 0;
    for (final element in this) {
      result.add(transform(element, index));
      index++;
    }
    return result;
  }
}
