import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'toggle_event.dart';

part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(OffToggleState());

  @override
  Stream<ToggleState> mapEventToState(ToggleEvent event) async* {
    if (event is TurnOnToggleEvent)
      yield OnToggleState();
    else if (event is TurnOffToggleEvent) {
      yield OffToggleState();
    }
  }
}
