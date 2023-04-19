import 'package:spend_time/database/database.dart';
import 'package:spend_time/database/model.dart';

class PauseProvider implements AbstractDatabaseProvider<PauseModel, Pause_tbl> {
  @override
  Future<Pause_tbl> convertToDbModel(PauseModel instance) async {
    return Pause_tbl(
      id: instance.id,
      startTime: instance.startTime,
      endTime: instance.endTime,
      stopwatchIndex: instance.stopwatchIndex
    );
  }

  @override
  Future<List<Pause_tbl>?> convertToDbModelList(List<PauseModel> instanceList) async {
    if(instanceList.isEmpty) return null;
    final list = List<Pause_tbl>.empty(growable: true);
    for(var s in instanceList) {
      final m = Pause_tbl(
          id: s.id,
          startTime: s.startTime,
          endTime: s.endTime,
          stopwatchIndex: s.stopwatchIndex
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<PauseModel> convertToInstance(Pause_tbl dbModel) async {
    return PauseModel(
        id: dbModel.id ?? -1,
        startTime: dbModel.startTime,
        endTime: dbModel.endTime,
        stopwatchIndex: dbModel.stopwatchIndex
    );
  }

  @override
  Future<List<PauseModel>?> convertToInstanceList(List<Pause_tbl> dbModelList) async {
    if(dbModelList.isEmpty) return null;
    final list = List<PauseModel>.empty(growable: true);
    for(var s in dbModelList) {
      final m = PauseModel(
          id: s.id ?? -1,
          startTime: s.startTime,
          endTime: s.endTime,
          stopwatchIndex: s.stopwatchIndex
      );
    list.add(m);
    }
    return list;
  }

  @override
  Future<void> delete(int id) async {
    final res = await Pause_tbl()
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
    final res = await Pause_tbl()
        .select()
        .id
        .greaterThanOrEquals(0)
        .delete();
    if(!res.success) {
      throw DeleteAllFailed();
    }
  }

  @override
  Future<void> insert(PauseModel instance) async {
    try {
      final Pause_tbl dbModel = await convertToDbModel(instance);
      await Pause_tbl(
          id: dbModel.id ?? -1,
          startTime: dbModel.startTime,
          endTime: dbModel.endTime,
          stopwatchIndex: dbModel.stopwatchIndex
      ).save();
    }catch(e) {
      throw InsertFailed();
    }
  }

  @override
  Future<void> insertList(List<PauseModel> instanceList) async {
    await Future.forEach(instanceList, (element) async => await insert(element)).catchError((e) {
      throw InsertListFailed();
    });
  }

  @override
  Future<PauseModel> select(int id) async {
    try {
      final dbModel = await Pause_tbl().getById(id);
      return await convertToInstance(dbModel!);
    }catch(e) {
      throw SelectFailed();
    }
  }

  @override
  Future<List<PauseModel>> selectAll() async {
    try {
      final dbModel = await Pause_tbl().select().toList();
      return await convertToInstanceList(dbModel) ?? List.empty();
    }catch(e) {
      throw SelectAllFailed();
    }
  }

  @override
  Future<void> update(PauseModel instance) async {
    final m = await convertToDbModel(instance);
    Pause_tbl(
        id: m.id ?? -1,
        startTime: m.startTime,
        endTime: m.endTime,
        stopwatchIndex: m.stopwatchIndex ?? -1
    ).save();
  }
}