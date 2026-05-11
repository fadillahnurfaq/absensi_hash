import 'package:uuid/uuid.dart';

class AppHelper {
  AppHelper._();

  static const Uuid _uuid = Uuid();

  static String generateRandomId() {
    return _uuid.v4();
  }
}