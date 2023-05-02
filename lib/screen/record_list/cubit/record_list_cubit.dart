import 'package:bloc/bloc.dart';
import 'package:spend_time/screen/screen.dart';

part 'record_list_state.dart';

class RecordListCubit extends Cubit<RecordListState> {
  RecordListCubit({required this.repository}): super(RecordListState());

  final RecordListRepository repository;

}