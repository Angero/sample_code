part of 'check_bloc.dart';

@immutable
abstract class CheckEvent {}

class ChangeCheckEvent extends CheckEvent {
  final String value;

  ChangeCheckEvent(this.value);
}
