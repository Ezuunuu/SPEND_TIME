import 'package:hive/hive.dart';
///-
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

part 'list_category_model.g.dart';

@HiveType(typeId: 7)
class CategoryModel {
  CategoryModel({this.index, this.title, required this.habit});

  @HiveField(0)
  final int? index;
  @HiveField(1)
  final String? title;

  @HiveField(2)
  final List<HabitModel> habit;

}