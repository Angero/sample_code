import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

part 'check_event.dart';

part 'check_state.dart';

class CheckBloc<T extends IUseCase<String, String>>
    extends Bloc<CheckEvent, CheckState> {
  final T usecase;

  CheckBloc({@required this.usecase}) : super(InitialCheckState());

  @override
  Stream<CheckState> mapEventToState(CheckEvent event) async* {
    if (event is ChangeCheckEvent) {
      Result result = usecase.execute(event.value);
      yield ChangedCheckState(result: result);
    }
  }
}
