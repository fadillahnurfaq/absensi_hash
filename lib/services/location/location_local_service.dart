import 'package:absensi_hash/models/location/m_location.dart';
import 'package:absensi_hash/utils/hive/hive_boxes.dart';
import 'package:absensi_hash/utils/hive/hive_services.dart';
import 'package:dartz/dartz.dart';

class LocationLocalService {
  const LocationLocalService();
  Future<Either<String, void>> create(MLocation location) async {
    try {
      final box = await HiveService.getBox(HiveBoxes.location);
      await box.put(location.id, location.asNewObject());
      return const Right(null);
    } catch (e) {
      return const Left("Something went wrong. Please contact system administrator.");
    }
  }

  Future<Either<String, List<MLocation>>> getList() async {
    try {
      final box = await HiveService.getBox(HiveBoxes.location);
      final list = box.values.map((e) => e as MLocation).toList();
      list.sort((a, b) {
        final aDate = a.createdAt;
        final bDate = b.createdAt;

        if (aDate == null && bDate == null) return 0;

        if (aDate == null) return 1;

        if (bDate == null) return -1;

        return bDate.compareTo(aDate);
      });
      return Right(list);
    } catch (e) {
      return const Left("Something went wrong. Please contact system administrator.");
    }
  }
}