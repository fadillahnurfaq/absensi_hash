// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TAttendanceAdapter extends TypeAdapter<TAttendance> {
  @override
  final typeId = 1;

  @override
  TAttendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TAttendance(
      id: fields[0] == null ? "" : fields[0] as String,
      latitude: fields[1] == null ? 0.0 : (fields[1] as num).toDouble(),
      longitude: fields[2] == null ? 0.0 : (fields[2] as num).toDouble(),
      address: fields[3] == null ? "" : fields[3] as String,
      checkIn: fields[4] == null ? "" : fields[4] as String,
      checkOut: fields[5] == null ? "" : fields[5] as String,
      createdAt: fields[6] as DateTime?,
      updatedAt: fields[7] as DateTime?,
      locationId: fields[8] == null ? "" : fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TAttendance obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.checkIn)
      ..writeByte(5)
      ..write(obj.checkOut)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.locationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TAttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
