part of 'check_bloc.dart';

@immutable
abstract class CheckState {}

class InitialCheckState extends CheckState {}

class ChangedCheckState extends CheckState {
  final Result result;

  ChangedCheckState({@required this.result});
}

