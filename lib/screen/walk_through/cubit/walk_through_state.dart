part of 'walk_through_cubit.dart';

class WalkThroughState {
  WalkThroughState({this.index = 0});

  final int index;

  WalkThroughState copyWith({int? index}) {
    return WalkThroughState(
      index: index ?? this.index,
    );
  }
}