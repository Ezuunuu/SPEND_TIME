import 'package:spend_time/database/database.dart';
import 'package:spend_time/database/model.dart';

class CategoryProvider implements AbstractDatabaseProvider<CategoryModel, Category_tbl> {
  @override
  Future<Category_tbl> convertToDbModel(CategoryModel instance) async {
    return Category_tbl(id: instance.id, title: instance.title, sort: instance.sort);
  }

  @override
  Future<List<Category_tbl>?> convertToDbModelList(List<CategoryModel> instanceList) async {
    if(instanceList.isEmpty) return null;
    final list = List<Category_tbl>.empty(growable: true);
    for(var s in instanceList) {
      final m = Category_tbl(
          id: s.id,
          title: s.title,
          sort: s.sort
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<CategoryModel> convertToInstance(Category_tbl dbModel) async {
    return CategoryModel(id: dbModel.id ?? -1, title: dbModel.title, sort: dbModel.sort);
  }

  @override
  Future<List<CategoryModel>?> convertToInstanceList(List<Category_tbl> dbModelList) async {
    if(dbModelList.isEmpty) return null;
    final list = List<CategoryModel>.empty(growable: true);
    for(var s in dbModelList) {
      final m = CategoryModel(
          id: s.id ?? -1,
          title: s.title,
          sort: s.sort
      );
      list.add(m);
    }
    return list;
  }

  @override
  Future<void> delete(int id) async {
    final res = await Category_tbl()
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
    final res = await Category_tbl()
        .select()
        .id
        .greaterThanOrEquals(0)
        .delete();
    if(!res.success) {
      throw DeleteAllFailed();
    }
  }

  @override
  Future<void> insert(CategoryModel instance) async {
    final Category_tbl dbModel = await convertToDbModel(instance);
    await Category_tbl(title: dbModel.title, sort: dbModel.sort).save();
  }

  @override
  Future<void> insertList(List<CategoryModel> instanceList) async {
    await Future.forEach(instanceList, (element) async => await insert(element)).catchError((e) {
      throw InsertListFailed();
    });
  }

  @override
  Future<CategoryModel> select(int id) async {
    try {
      final dbModel = await Category_tbl().getById(id);
      return await convertToInstance(dbModel!);
    }catch(e) {
      throw SelectFailed();
    }
  }

  @override
  Future<List<CategoryModel>> selectAll() async {
    try {
      final dbModel = await Category_tbl().select().toList();
      return await convertToInstanceList(dbModel) ?? List.empty();
    }catch(e) {
      throw SelectAllFailed();
    }
  }

  @override
  Future<void> update(CategoryModel instance) async {
    final m = await convertToDbModel(instance);
    Category_tbl(id: m.id, title: m.title, sort: m.sort).save();
  }
}