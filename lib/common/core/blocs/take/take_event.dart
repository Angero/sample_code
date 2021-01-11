part of 'take_bloc.dart';

@immutable
abstract class TakeEvent {}

class SendTakeEvent<T> extends TakeEvent {
  final T value;

  SendTakeEvent([this.value]);
}

class InitiateTakeEvent extends TakeEvent {}
