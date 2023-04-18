abstract class AbstractDatabaseProvider<I, D> {
  Future<D> convertToDbModel(I instance);
  Future<I> convertToInstance(D dbModel);

  Future<List<D>?> convertToDbModelList(List<I> instanceList);
  Future<List<I>?> convertToInstanceList(List<D> dbModelList);

  Future<List<I>>selectAll();
  Future<I> select(int id);

  Future<void> insertList(List<I> instanceList);
  Future<void> insert(I instance);

  Future<void> deleteAll();
  Future<void> delete(int id);

  Future<void> update(I instance);
}