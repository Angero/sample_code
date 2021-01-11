import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

part 'take_event.dart';

part 'take_state.dart';

class TakeBloc<R, T extends IFutureUseCase> extends Bloc<TakeEvent, TakeState> {
  final T usecase;

  TakeBloc({@required this.usecase}) : super(InitialTakeState());

  @override
  Stream<TakeState> mapEventToState(TakeEvent event) async* {
    if (event is SendTakeEvent) {
      yield WaitingTakeState();
      try {
        Result<R> result = await usecase.execute(event.value);
        if (!result.hasError())
          yield SuccessTakeState<R>(result.value);
        else
          yield FailureTakeState(result.error);
      } catch (e, stacktrace) {
        print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailureTakeState(e.toString());
      }
    } else if (event is InitiateTakeEvent) {
      yield InitialTakeState();
    }
  }
}
