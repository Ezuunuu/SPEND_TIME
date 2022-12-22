import 'package:spend_time/database/database.dart';

class HabitRepository {
  late DatabaseRepository _databaseRepository;

  Future<void> init() async {
    _databaseRepository = DatabaseRepository();
    await _databaseRepository.init(name: HABIT_KEY);
  }
}

// ignore: non_constant_identifier_names
String HABIT_KEY = 'SPEND_TIME_HABIT';