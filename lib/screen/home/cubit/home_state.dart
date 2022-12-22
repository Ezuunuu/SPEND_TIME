part of 'home_cubit.dart';

enum HomeStatus { init }

class HomeState {
  HomeState({this.status, this.index = 2});

  final HomeStatus? status;
  final int index;

  HomeState copyWith({HomeStatus? status, int? index, bool? tutorial}) {
    return HomeState(
      status: status ?? this.status,
      index: index ?? this.index,
    );
  }
}