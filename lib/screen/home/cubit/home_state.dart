part of 'home_cubit.dart';

class HomeState {
  HomeState({this.index});

  final int? index;

  HomeState copyWith({int? index, }) {
    return HomeState(
        index: index ?? this.index
    );
  }
}