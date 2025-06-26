import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/common/logger/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    AppLogger.debug('Create $bloc');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    AppLogger.debug('Close $bloc');
    super.onClose(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    AppLogger.debug('$bloc Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    AppLogger.debug('$bloc Changed to ${change.nextState}');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.debug('$bloc $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
