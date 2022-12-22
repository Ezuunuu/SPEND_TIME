import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/list/list.dart';

class ListRepository {
  late DatabaseRepository _databaseRepository;

  Future<void> init() async {
    _databaseRepository = DatabaseRepository();
    await _databaseRepository.init(name: LIST_KEY);
  }
  
  Future<void> save(List<CategoryModel> category) async {
    _databaseRepository.put(key: LIST_KEY, value: category);
  }

  Future<List<CategoryModel>> load() async {
    final l = List<CategoryModel>.from(await _databaseRepository.get(name: LIST_KEY, defaultValue: List<CategoryModel>.empty(growable: true)));
    return l;
  }
}

// ignore: non_constant_identifier_names
String LIST_KEY = 'SPEND_TIME_LIST';