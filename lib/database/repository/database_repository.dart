import 'package:hive/hive.dart';

class DatabaseRepository {
  late Box dataBox;

  Future<void> init({required String name}) async {
    await Hive.openBox(name);
    dataBox = Hive.box(name);
  }

  Future<dynamic> get({required String name, required dynamic defaultValue}) async {
    return await dataBox.get(name, defaultValue: defaultValue);
  }

  Future<dynamic> getAt({required int index}) async {
    return await dataBox.getAt(index);
  }

  Future<Map<String, dynamic>> getMap() async {
    return dataBox.toMap().map((key, value) => MapEntry(key, value));
  }

  Future<bool> isEmpty() async {
    return dataBox.isEmpty;
  }

  Future<void> put({required String key, required dynamic value}) async {
    await dataBox.put(key, value);
  }

  Future<void> add({required dynamic value}) async {
    await dataBox.add(value);
  }

  Future<void> saveJson({required Map<String, dynamic> entries}) async {
    await dataBox.putAll(entries);
  }

  Future<void> delete({required int index}) async {
    await dataBox.deleteAt(index);
  }

  Future<void> deleteAll() async {
    await dataBox.deleteAll(dataBox.keys);
  }
}