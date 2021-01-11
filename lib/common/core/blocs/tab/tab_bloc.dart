import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

part 'tab_event.dart';

part 'tab_state.dart';

class TabBloc<T extends IUseCase> extends Bloc<TabEvent, TabState> {
  final T usecase;

  TabBloc({@required this.usecase}) : super(SwitchedTabState(0));

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is SwitchTabEvent) {
      int i = usecase.execute(event.index).value;
      yield SwitchedTabState(i);
    }
  }
}
