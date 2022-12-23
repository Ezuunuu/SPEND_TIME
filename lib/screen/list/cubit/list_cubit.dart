import 'package:bloc/bloc.dart';
///-
import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit(
      {
        required this.listRepository,
      }) : super(ListState(status: ListStatus.init, category: List.empty(growable: true))) { init(); }
  final ListRepository listRepository;

  Future<void> init() async {
    await listRepository.init();
    await loadCategory();
  }

  Future<void> setText(String value) async {
    emit(state.copyWith(currentCategoryName: value));
  }

  Future<void> saveCategory() async {
    if(state.currentCategoryName.isEmpty) {
      await emitError('카테고리 이름을 작성해주세요');
      return;
    }
    for(CategoryModel c in state.category) {
      if(c.title == state.currentCategoryName) {
        await emitError('중복된 카테고리 이름입니다');
        return;
      }
    }
    final CategoryModel category = CategoryModel(title: state.currentCategoryName, habit: List.empty(growable: true));
    final list = state.category;
    list.add(category);
    await listRepository.save(list);
    await loadCategory();
    emit(state.copyWith(status: ListStatus.saveComplete, errorMsg: ''));
  }

  Future<void> loadCategory() async {
    emit(state.copyWith(status: ListStatus.loading));
    emit(state.copyWith(status: ListStatus.loadComplete, category: await listRepository.load(), errorMsg: ''));
  }

  Future<void> setFocus(bool focus) async {
    emit(state.copyWith(focusFlag: focus));
  }

  Future<void> select(int index) async {
    emit(state.copyWith(selectIndex: index, habit: HabitModel(title: '', stopwatch: List.empty(growable: true))));
  }

  Future<void> setTitle(String title) async {
    emit(state.copyWith(habit: state.habit?.copyWith(title: title)));
  }

  Future<void> makeHabit(Duration duration, int alarm) async {
    emit(state.copyWith(habit: state.habit?.copyWith(mode: duration == Duration.zero ? StopwatchMode.stopwatch.index : StopwatchMode.timer.index, presetTime: duration, sound: alarm, stopwatch: [StopwatchModel.initWithPresetTime(duration)])));
  }

  Future<void> emitError(String msg) async {
    emit(state.copyWith(status: ListStatus.error, errorMsg: msg, habit: HabitModel.init(), currentCategoryName: ''));
    emit(state.copyWith(status: ListStatus.init, errorMsg: ''));
  }

  Future<void> saveHabit() async {
    if(state.habit?.title == "") {
      await emitError('습관 이름을 작성해주세요');
      return;
    }
    for(HabitModel c in state.category[state.selectIndex! - 1].habit) {
      if(c.title == state.habit?.title) {
        await emitError('중복된 습관 이름입니다');
        return;
      }
    }
    final index = state.selectIndex! - 1;
    CategoryModel category = state.category[index];
    category.habit.add(state.habit!);
    state.category.removeAt(index);
    state.category.insert(index, category);
    await listRepository.save(state.category);
    await loadCategory();
    emit(state.copyWith(status: ListStatus.saveComplete, errorMsg: '', habit: HabitModel.init()));
  }
}