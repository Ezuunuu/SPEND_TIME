part of 'list_cubit.dart';

enum ListStatus {
  init,
  loading,
  loadComplete,
  saveComplete,
  error
}

class ListState {
  ListState(
      {
        this.status,
        required this.category,
        this.currentCategoryName = '',
        this.errorMsg,
        this.selectIndex,
        this.focusFlag = false,
        this.habit
      });

  final ListStatus? status;
  final List<CategoryModel> category;

  final String currentCategoryName;

  final String? errorMsg;

  final int? selectIndex;
  final bool focusFlag;

  final HabitModel? habit;

  ListState copyWith(
      {
        ListStatus? status,
        List<CategoryModel>? category,
        String? currentCategoryName,
        String? errorMsg,
        int? selectIndex,
        bool? focusFlag,
        HabitModel? habit
      }) {
    return ListState(
      status: status ?? this.status,
      category: category ?? this.category,
      currentCategoryName: currentCategoryName ?? this.currentCategoryName,
      errorMsg: errorMsg ?? this.errorMsg,
      selectIndex: selectIndex ?? this.selectIndex,
      focusFlag: focusFlag ?? this.focusFlag,
      habit: habit ?? this.habit
    );
  }
}