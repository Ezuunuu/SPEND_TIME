// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 2;

  @override
  HabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitModel(
      mode: fields[0] as int,
      title: fields[1] as String,
      icon: fields[2] as String?,
      sound: fields[3] as int?,
      presetTime: fields[4] as Duration?,
      stopwatch: (fields[5] as List).cast<StopwatchModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.mode)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.sound)
      ..writeByte(4)
      ..write(obj.presetTime)
      ..writeByte(5)
      ..write(obj.stopwatch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
