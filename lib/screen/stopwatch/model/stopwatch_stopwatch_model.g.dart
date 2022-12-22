// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_stopwatch_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StopwatchModelAdapter extends TypeAdapter<StopwatchModel> {
  @override
  final int typeId = 3;

  @override
  StopwatchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StopwatchModel(
      time: fields[1] as TimeModel,
      pause: (fields[2] as List).cast<PauseModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StopwatchModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.pause);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopwatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
