part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class InitialDataState extends DataState {}

class ChangedDataState extends DataState {
  final Result<Data> result;

  ChangedDataState({@required this.result});
}
