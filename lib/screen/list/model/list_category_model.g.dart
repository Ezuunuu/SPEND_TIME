// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 7;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      index: fields[0] as int?,
      title: fields[1] as String?,
      habit: (fields[2] as List).cast<HabitModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.habit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}