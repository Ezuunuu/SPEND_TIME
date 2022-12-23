import 'package:hive/hive.dart';
///-
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

part 'list_category_model.g.dart';

@HiveType(typeId: 7)
class CategoryModel {
  CategoryModel({this.index = -1, this.title, required this.habit, this.lastHabitIndex});
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final List<HabitModel> habit;
  @HiveField(3)
  final int? lastHabitIndex;

  CategoryModel.init():
      index = -1,
      title = "저장하지 않은 카테고리",
      habit = [HabitModel.init()],
      lastHabitIndex = null;

  CategoryModel copyWith({String? title, List<HabitModel>? habit, int? lastHabitIndex}) {
    return CategoryModel(
        title: title ?? this.title,
        habit: habit ?? this.habit,
        lastHabitIndex: lastHabitIndex ?? this.lastHabitIndex
    );
  }
}