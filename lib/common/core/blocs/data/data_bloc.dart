import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/common/data/data.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc<T extends IUseCase<Data, bool>>
    extends Bloc<DataEvent, DataState> {
  final Data data;
  final T usecase;

  DataBloc({@required this.data, @required this.usecase})
      : super(InitialDataState());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is ChangeDataEvent) {
      data.set(event.key, event.value);
      Result<bool> valid = this.usecase.execute(data);
      yield ChangedDataState(
          result: Result<Data>(
              value: data, error: valid.value ? '' : 'Data is invalid'));
    }
  }
}
