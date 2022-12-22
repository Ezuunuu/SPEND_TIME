// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_tutorial_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingTutorialModelAdapter extends TypeAdapter<SettingTutorialModel> {
  @override
  final int typeId = 8;

  @override
  SettingTutorialModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingTutorialModel(
      alert: fields[0] as bool,
      tutorial: fields[1] as bool,
      tooltip: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SettingTutorialModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.alert)
      ..writeByte(1)
      ..write(obj.tutorial)
      ..writeByte(2)
      ..write(obj.tooltip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingTutorialModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
