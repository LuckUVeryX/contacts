import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'logger.dart';

class SimpleBlocObserver extends BlocObserver {
  final Logger logger = getLogger('BlocObserver');

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.v('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.v('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.v('${bloc.runtimeType} $transition');
  }
}
