import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('''onTransition ${bloc.runtimeType}: Transition
currentState: ${transition.currentState},
event: ${transition.event},
nextState: ${transition.nextState}
''');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // TODO: implement onEvent (trough Analyticsrepository)
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // TODO: implement onChange (trough Analyticsrepository)
  }
}
