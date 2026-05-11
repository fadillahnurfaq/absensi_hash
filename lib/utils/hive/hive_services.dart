import 'package:hive_ce/hive.dart';

class HiveService {
  HiveService._();

  static Future<Box<T>> getBox<T>(String name) async {
    if (!Hive.isBoxOpen(name)) {
      return await Hive.openBox<T>(name);
    }
    return Hive.box<T>(name);
  }

  static Future<void> closeBox<T>(String name) async {
    if (Hive.isBoxOpen(name)) {
      await Hive.box<T>(name).close();
    }
  }
}