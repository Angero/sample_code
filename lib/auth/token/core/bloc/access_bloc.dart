import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizable/flows/auth/token/data/token_repository_interface.dart';

part 'access_event.dart';

part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final ITokenRepository repository;

  AccessBloc({@required this.repository}) : super(InitialAccessState());

  @override
  Stream<AccessState> mapEventToState(AccessEvent event) async* {
    try {
      if (event is GetAccessEvent) {
        yield GettingAccessState();
        await Future.delayed(Duration(milliseconds: 1000));
        bool hasToken = await repository.hasToken();
        if (hasToken)
          yield AccessibleAccessState();
        else
          yield DeniedAccessState();
      }
    } catch (e, stacktrace) {
      print('RA: ${e.toString()} ${stacktrace.toString()}');
      yield FailureAccessState();
    }
  }
}
