import 'package:bloc/bloc.dart';
import 'package:spend_time/screen/screen.dart';

part 'calculate_state.dart';

class CalculateCubit extends Cubit<CalculateState> {
  CalculateCubit({required this.repository}) : super(CalculateState());

  final CalculateRepository repository;

}