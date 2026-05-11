import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime? {
  String formatDate({
    final String? pattern,
    final String? onNull,
  }) {
    if (this == null) {
      return onNull ?? "";
    }
    final DateFormat formatter = DateFormat(pattern ?? 'yyyy-MM-dd', 'id_ID');
    return formatter.format(this!);
  }
}