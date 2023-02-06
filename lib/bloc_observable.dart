import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObservable extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event $event' as num);
  }

  @override
  void onError(BlocBase bloc, Object errors, StackTrace stackTrace) {
    super.onError(bloc, errors, stackTrace);
    log('onError -- bloc: ${bloc.runtimeType}, errors $errors' as num);
  }
}
