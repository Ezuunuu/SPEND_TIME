import 'package:spend_time/database/database.dart';
import 'package:spend_time/database/model.dart';

class StopwatchProvider implements AbstractDatabaseProvider<StopwatchModel, Stopwatch_tbl> {
  @override
  Future<Stopwatch_tbl> convertToDbModel(StopwatchModel instance) async {
    return Stopwatch_tbl(
        id: instance.id,
        startTime: instance.startTime,
        endTime: instance.endTime,
        habitIndex: instance.habitIndex
    );
  }

  @override
  Future<List<Stopwatch_tbl>?> convertToDbModelList(List<StopwatchModel> instanceList) async {
    if(instanceList.isEmpty) return null;
    final list = List<Stopwatch_tbl>.empty(growable: true);
    for(var s in instanceList) {
      final m = Stopwatch_tbl(
          id: s.id,
          startTime: s.startTime,
          endTime: s.endTime,
          habitIndex: s.habitIndex
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<StopwatchModel> convertToInstance(Stopwatch_tbl dbModel) async {
    return StopwatchModel(
        id: dbModel.id ?? -1,
        startTime: dbModel.startTime,
        endTime: dbModel.endTime,
        habitIndex: dbModel.habitIndex
    );
  }

  @override
  Future<List<StopwatchModel>?> convertToInstanceList(List<Stopwatch_tbl> dbModelList) async {
    if(dbModelList.isEmpty) return null;
    final list = List<StopwatchModel>.empty(growable: true);
    for(var s in dbModelList) {
      final m = StopwatchModel(
          id: s.id ?? -1,
          startTime: s.startTime,
          endTime: s.endTime,
          habitIndex: s.habitIndex
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<void> delete(int id) async {
    final res = await Stopwatch_tbl()
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
    final res = await Stopwatch_tbl()
        .select()
        .id
        .greaterThanOrEquals(0)
        .delete();
    if(!res.success) {
      throw DeleteAllFailed();
    }
  }

  @override
  Future<void> insert(StopwatchModel instance) async {
    try {
      final Stopwatch_tbl dbModel = await convertToDbModel(instance);
      await Stopwatch_tbl(
          id: dbModel.id ?? -1,
          startTime: dbModel.startTime,
          endTime: dbModel.endTime,
          habitIndex: dbModel.habitIndex
      ).save();
    }catch(e) {
      throw InsertFailed();
    }
  }

  @override
  Future<void> insertList(List<StopwatchModel> instanceList) async {
    await Future.forEach(instanceList, (element) async => await insert(element)).catchError((e) {
      throw InsertListFailed();
    });
  }

  @override
  Future<StopwatchModel> select(int id) async {
    try {
      final dbModel = await Stopwatch_tbl().getById(id);
      return await convertToInstance(dbModel!);
    }catch(e) {
      throw SelectFailed();
    }
  }

  @override
  Future<List<StopwatchModel>> selectAll() async {
    try {
      final dbModel = await Stopwatch_tbl().select().toList();
      return await convertToInstanceList(dbModel) ?? List.empty();
    }catch(e) {
      throw SelectAllFailed();
    }
  }

  @override
  Future<void> update(StopwatchModel instance) async {
    final m = await convertToDbModel(instance);
    Stopwatch_tbl(
        id: m.id ?? -1,
        startTime: m.startTime,
        endTime: m.endTime,
        habitIndex: m.habitIndex ?? -1
    ).save();
  }
}