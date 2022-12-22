// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingModelAdapter extends TypeAdapter<SettingModel> {
  @override
  final int typeId = 1;

  @override
  SettingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingModel(
      darkMode: fields[0] as bool,
      visibleOpening: fields[1] as bool,
      secMinMode: fields[2] as int,
      tutorial: fields[3] as SettingTutorialModel?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.visibleOpening)
      ..writeByte(2)
      ..write(obj.secMinMode)
      ..writeByte(3)
      ..write(obj.tutorial);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
