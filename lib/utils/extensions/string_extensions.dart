extension NullableStringExtension on String? {
  String getText({final String? defaultValue}) {
    if (this?.isEmpty ?? true) {
      return defaultValue ?? '-';
    } else {
      return this!;
    }
  }
}