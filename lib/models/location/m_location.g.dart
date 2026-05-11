// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MLocationAdapter extends TypeAdapter<MLocation> {
  @override
  final typeId = 0;

  @override
  MLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MLocation(
      id: fields[0] == null ? "" : fields[0] as String,
      address: fields[1] == null ? "" : fields[1] as String,
      latitude: fields[2] == null ? 0.0 : (fields[2] as num).toDouble(),
      longitude: fields[3] == null ? 0.0 : (fields[3] as num).toDouble(),
      createdAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MLocation obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
