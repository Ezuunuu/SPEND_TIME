import 'package:spend_time/database/database.dart';
import 'package:spend_time/database/model.dart';

class HabitProvider implements AbstractDatabaseProvider<HabitModel, Habit_tbl> {
  @override
  Future<Habit_tbl> convertToDbModel(HabitModel instance) async {
    return Habit_tbl(
        id: instance.id,
        title: instance.title,
        mode: instance.mode.index,
        icon: instance.icon,
        alarm: instance.alarm,
        presetTime: instance.presetTime,
        categoryIndex: instance.categoryIndex
    );
  }

  @override
  Future<List<Habit_tbl>?> convertToDbModelList(List<HabitModel> instanceList) async {
    if(instanceList.isEmpty) return null;
    final list = List<Habit_tbl>.empty(growable: true);
    for(var s in instanceList) {
      final m = Habit_tbl(
          id: s.id,
          title: s.title,
          mode: s.mode.index,
          icon: s.icon,
          alarm: s.alarm,
          presetTime: s.presetTime,
          categoryIndex: s.categoryIndex
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<HabitModel> convertToInstance(Habit_tbl dbModel) async {
    return HabitModel(
        id: dbModel.id ?? -1,
        title: dbModel.title,
        mode: HabitMode.values[dbModel.mode ?? 0],
        icon: dbModel.icon,
        alarm: dbModel.alarm,
        presetTime: dbModel.presetTime,
        categoryIndex: dbModel.categoryIndex
    );
  }

  @override
  Future<List<HabitModel>?> convertToInstanceList(List<Habit_tbl> dbModelList) async {
    if(dbModelList.isEmpty) return null;
    final list = List<HabitModel>.empty(growable: true);
    for(var s in dbModelList) {
      final m = HabitModel(
          id: s.id ?? -1,
          title: s.title,
          mode: HabitMode.values[s.mode ?? 0],
          icon: s.icon,
          alarm: s.alarm,
          presetTime: s.presetTime,
          categoryIndex: s.categoryIndex
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<void> delete(int id) async {
    final res = await Habit_tbl()
        .select()
        .id
        .equals(id)
        .delete();
    if(!res.success) {
      throw DeleteFailed();
    }
  }

  @override
  Future<void> deleteAll() async {
    final res = await Habit_tbl()
        .select()
        .id
        .greaterThanOrEquals(0)
        .delete();
    if(!res.success) {
      throw DeleteAllFailed();
    }
  }

  @override
  Future<void> insert(HabitModel instance) async {
    final Habit_tbl dbModel = await convertToDbModel(instance);
    await Habit_tbl(
        title: dbModel.title,
        mode: dbModel.mode,
        icon: dbModel.icon,
        alarm: dbModel.alarm,
        presetTime: dbModel.presetTime,
        categoryIndex: dbModel.categoryIndex
    ).save();
  }

  @override
  Future<void> insertList(List<HabitModel> instanceList) async {
    await Future.forEach(instanceList, (element) async => await insert(element)).catchError((e) {
      throw InsertListFailed();
    });
  }

  @override
  Future<HabitModel> select(int id) async {
    try {
      final dbModel = await Habit_tbl().getById(id);
      return await convertToInstance(dbModel!);
    }catch(e) {
      throw SelectFailed();
    }
  }

  @override
  Future<List<HabitModel>> selectAll() async {
    try {
      final dbModel = await Habit_tbl().select().toList();
      return await convertToInstanceList(dbModel) ?? List.empty();
    }catch(e) {
      throw SelectAllFailed();
    }
  }

  @override
  Future<void> update(HabitModel instance) async {
    final m = await convertToDbModel(instance);
    Habit_tbl(
        id: m.id,
        title: m.title,
        mode: m.mode,
        icon: m.icon,
        alarm: m.alarm,
        presetTime: m.presetTime,
        categoryIndex: m.categoryIndex
    ).save();
  }
}