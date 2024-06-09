import 'dart:developer';

import 'package:bloc/bloc.dart';

String onTransitionMessage(Bloc bloc, Transition transition) =>
    '''onTransition ${bloc.runtimeType}: Transition
currentState: ${transition.currentState},
event: ${transition.event},
nextState: ${transition.nextState}
''';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver(
      /*{
    required AnalyticsRepository analyticsRepository,
  }*/
      ) /*: _analyticsRepository = analyticsRepository*/;

  // final AnalyticsRepository _analyticsRepository;
  // TODO: setup analyticsRepository

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(onTransitionMessage(bloc, transition));
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
