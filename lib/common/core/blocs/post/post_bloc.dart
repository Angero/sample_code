import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc<T extends IFutureUseCase> extends Bloc<PostEvent, PostState> {
  final T usecase;

  PostBloc({@required this.usecase}) : super(InitialPostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is SendPostEvent) {
      yield WaitingPostState();
      try {
        Result<bool> result = await usecase.execute(event.value);
        if (!result.hasError())
          yield SuccessPostState();
        else
          yield FailurePostState(result.error);
      } catch (e, stacktrace) {
        print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailurePostState(e.toString());
      }
    } else if (event is InitiatePostEvent) {
      yield InitialPostState();
    }
  }
}
