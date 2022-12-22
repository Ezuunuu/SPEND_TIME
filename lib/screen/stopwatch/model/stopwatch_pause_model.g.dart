// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_pause_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PauseModelAdapter extends TypeAdapter<PauseModel> {
  @override
  final int typeId = 5;

  @override
  PauseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PauseModel(
      startTime: fields[0] as DateTime?,
      endTime: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PauseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PauseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
