part of 'take_bloc.dart';

@immutable
abstract class TakeState {}

class InitialTakeState  extends TakeState {}

class WaitingTakeState extends TakeState {}

class SuccessTakeState<R> extends TakeState {
  final R value;

  SuccessTakeState(this.value);
}

class FailureTakeState extends TakeState {
  final String error;

  FailureTakeState(this.error);
}
