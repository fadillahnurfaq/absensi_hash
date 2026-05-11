import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../hive_registrar.g.dart';


class HiveManager {
  HiveManager._();
  
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapters();
  }
}