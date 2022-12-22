// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_time_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeModelAdapter extends TypeAdapter<TimeModel> {
  @override
  final int typeId = 4;

  @override
  TimeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeModel(
      startTime: fields[0] as int?,
      endTime: fields[1] as int?,
      pausedTime: fields[2] as int?,
      currentTime: fields[3] as Duration?,
    );
  }

  @override
  void write(BinaryWriter writer, TimeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.pausedTime)
      ..writeByte(3)
      ..write(obj.currentTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
