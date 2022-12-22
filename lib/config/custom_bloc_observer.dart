import 'package:bloc/bloc.dart';
import 'package:spend_time/config/config.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    logger.d('${change.currentState.status} => ${change.nextState.status}');
    super.onChange(bloc, change);
  }
}